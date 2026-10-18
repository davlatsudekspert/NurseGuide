import 'dart:async';
import 'dart:typed_data';

import 'package:nurseguide/core/backend/admin_console.dart';
import 'package:nurseguide/core/backend/admin_team.dart';
import 'package:nurseguide/core/backend/backend_models.dart';
import 'package:nurseguide/core/backend/app_backend.dart';
import 'package:nurseguide/features/auth/otp_auth.dart';
import 'package:nurseguide/features/classroom/invite_link.dart'
    show nicknameAllowed, normalizeNickname;

class _User {
  _User(this.id, this.email);
  final String id;
  final String email;
  String? role;
  String? language;
  bool teacher = false;
  bool totpVerified = false;
}

/// Widget testlar uchun xotiradagi server. Qoidalari
/// `cloudflare/migrations` bilan bir xil: admin — faqat server ro'yxatidagi
/// email tasdiqlanganda (ilova emas), admin amallari aal2 talab qiladi,
/// har foydalanuvchi faqat o'z murojaatlarini ko'radi.
///
/// Bitta obyekt ko'p foydalanuvchini saqlaydi — chiqib, boshqa email bilan
/// kirish mumkin (qabul tekshiruvi kabi).
class FakeBackend implements AppBackend {
  FakeBackend({this.adminEmails = const {'owner@example.com'}});

  final Set<String> adminEmails;
  static const otpCode = '123456';
  static const totpCode = '000000';

  final Map<String, _User> _users = {};
  final Map<String, String> _pendingCodes = {};
  _User? _current;
  bool _aal2 = false;
  int _seq = 0;
  final List<SupportThread> _threads = [];
  final List<SupportMessage> _messages = [];
  final Map<String, Uint8List> _files = {};
  final List<AuditEntry> audit = [];
  final _lost = StreamController<void>.broadcast();

  String _id(String p) => '$p-${++_seq}';
  DateTime _now() => DateTime.now().toUtc().add(Duration(microseconds: _seq));

  @override
  bool get isConfigured => true;

  /// Variantli test (D-66) qo'llanadimi — widget testlari o'chirib ko'radi.
  bool variantTests = true;
  @override
  bool get supportsVariantTests => variantTests;
  @override
  bool get isAvailable => true;
  @override
  bool get isDemo => false;
  @override
  bool get hasSession => _current != null;
  @override
  String? get sessionEmail => _current?.email;
  @override
  String? get userId => _current?.id;
  @override
  Stream<void> get sessionLost => _lost.stream;

  /// Server sessiyani bekor qildi (masalan, hisob boshqa qurilmada
  /// o'chirildi).
  void revokeSession() {
    _current = null;
    _lost.add(null);
  }

  @override
  Future<OtpRequestResult> requestCode(String email) async {
    if (!isValidEmail(email)) {
      return const OtpRequestResult(OtpRequestStatus.invalidEmail);
    }
    _pendingCodes[normalizeEmail(email)] = otpCode;
    return const OtpRequestResult(
      OtpRequestStatus.sent,
      retryAfter: Duration(seconds: 60),
      validFor: Duration(minutes: 10),
    );
  }

  @override
  Future<OtpVerifyResult> verifyCode(String email, String code) async {
    final key = normalizeEmail(email);
    if (_pendingCodes[key] == null) {
      return const OtpVerifyResult(OtpVerifyStatus.noActiveCode);
    }
    if (code.trim() != _pendingCodes[key]) {
      return const OtpVerifyResult(
        OtpVerifyStatus.invalidCode,
        attemptsLeft: 4,
      );
    }
    _pendingCodes.remove(key);
    _current = _users.putIfAbsent(key, () => _User(_id('user'), key));
    _aal2 = false;
    return const OtpVerifyResult(OtpVerifyStatus.verified);
  }

  @override
  Future<void> restoreSession() async {}

  /// Faqat test: boshqa qurilmadagi foydalanuvchi nomidan amal (ilovadagi
  /// joriy sessiya o'zgarmaydi) — masalan, ustoz sahifasi ochiq turganda
  /// talaba topshiradi.
  Future<T> actAs<T>(String email, Future<T> Function() body) async {
    final key = normalizeEmail(email);
    final prev = _current;
    _current = _users.putIfAbsent(key, () => _User(_id('user'), key));
    try {
      return await body();
    } finally {
      _current = prev;
    }
  }

  @override
  Future<void> signOut() async {
    _current = null;
    _aal2 = false;
  }

  @override
  Future<void> deleteAccount() async {
    final u = _require();
    _users.remove(u.email);
    _threads.removeWhere((t) => t.userId == u.id);
    _current = null;
  }

  _User _require() =>
      _current ?? (throw const BackendException(BackendFailure.unauthorized));

  bool get _isAdminAccount =>
      _current != null &&
      (adminEmails.contains(_current!.email) ||
          _grants.containsKey(_current!.email));
  bool get _isSuperAdmin =>
      _current != null && adminEmails.contains(_current!.email);

  /// Super admin qo'shgan adminlar (D-44; faqat [FakeAdminTeamBackend]).
  final Map<String, ({String id, DateTime at})> _grants = {};
  bool get _isAdmin =>
      (_isAdminAccount && _aal2) || (allowsPanelAdmin && _isSuperAdmin);

  /// Egasi admin paneli (Cloudflare): ADMIN_EMAILS + email kodi, TOTP siz.
  bool get allowsPanelAdmin => false;
  void _requireAdmin() {
    if (!_isAdmin) throw const BackendException(BackendFailure.forbidden);
  }

  int get registeredCount => _users.length;

  @override
  Future<AccessInfo> myAccess() async => _current == null
      ? AccessInfo.none
      : AccessInfo(
          adminAccount: _isAdminAccount,
          aal2: _aal2,
          teacher: _current!.teacher,
          superAdmin: _isSuperAdmin,
          panelAdmin: allowsPanelAdmin && _isSuperAdmin,
        );

  @override
  Future<void> touchProfile({
    required String role,
    required String language,
  }) async {
    final u = _require();
    u
      ..role = role
      ..language = language;
  }

  @override
  Future<MfaStatus> mfaStatus() async {
    final u = _require();
    return MfaStatus(
      verifiedFactorId: u.totpVerified ? 'totp-1' : null,
      aal2: _aal2,
    );
  }

  @override
  Future<TotpEnrollment> mfaEnroll() async {
    _require();
    return const TotpEnrollment(
      factorId: 'totp-1',
      secret: 'JBSWY3DPEHPK3PXP',
      uri: 'otpauth://totp/NurseGuide:admin?secret=JBSWY3DPEHPK3PXP&issuer=NurseGuide',
    );
  }

  @override
  Future<void> mfaVerify({
    required String factorId,
    required String code,
  }) async {
    final u = _require();
    if (code.trim() != totpCode) {
      throw const BackendException(BackendFailure.invalid);
    }
    u.totpVerified = true;
    _aal2 = true;
  }

  SupportThread _thread(String id) => _threads.firstWhere(
    (t) => t.id == id,
    orElse: () => throw const BackendException(BackendFailure.notFound),
  );

  SupportThread _copy(
    SupportThread t, {
    SupportStatus? status,
    DateTime? lastUser,
    DateTime? lastAdmin,
    DateTime? userRead,
    DateTime? adminRead,
  }) => SupportThread(
    id: t.id,
    userId: t.userId,
    kind: t.kind,
    subject: t.subject,
    status: status ?? t.status,
    createdAt: t.createdAt,
    updatedAt: _now(),
    lastUserMessageAt: lastUser ?? t.lastUserMessageAt,
    lastAdminMessageAt: lastAdmin ?? t.lastAdminMessageAt,
    userReadAt: userRead ?? t.userReadAt,
    adminReadAt: adminRead ?? t.adminReadAt,
  );

  void _replace(SupportThread t) {
    _threads[_threads.indexWhere((x) => x.id == t.id)] = t;
  }

  String? _store(SupportAttachment? a) {
    if (a == null) return null;
    if (a.bytes.length > SupportAttachment.maxBytes ||
        !SupportAttachment.allowedTypes.contains(a.mimeType)) {
      throw const BackendException(BackendFailure.invalid);
    }
    final path = '${_require().id}/${_id('file')}.${a.extension}';
    _files[path] = a.bytes;
    return path;
  }

  @override
  Future<List<SupportThread>> myThreads() async {
    final u = _require();
    return _threads.where((t) => t.userId == u.id).toList().reversed.toList();
  }

  @override
  Future<List<SupportMessage>> messages(String threadId) async {
    final t = _thread(threadId);
    if (t.userId != _require().id && !_isAdmin) {
      throw const BackendException(BackendFailure.forbidden);
    }
    return _messages.where((m) => m.threadId == threadId).toList();
  }

  @override
  Future<String> createThread({
    required SupportKind kind,
    required String subject,
    required String body,
    SupportAttachment? attachment,
  }) async {
    final u = _require();
    if (subject.trim().length < 3 || body.trim().isEmpty) {
      throw const BackendException(BackendFailure.invalid);
    }
    final path = _store(attachment);
    final now = _now();
    final t = SupportThread(
      id: _id('thread'),
      userId: u.id,
      kind: kind,
      subject: subject.trim(),
      status: SupportStatus.newThread,
      createdAt: now,
      updatedAt: now,
      lastUserMessageAt: now,
      lastAdminMessageAt: null,
      userReadAt: now,
      adminReadAt: null,
    );
    _threads.add(t);
    _messages.add(
      SupportMessage(
        id: _id('msg'),
        threadId: t.id,
        fromAdmin: false,
        body: body.trim(),
        attachmentPath: path,
        createdAt: now,
      ),
    );
    return t.id;
  }

  @override
  Future<void> postMessage(
    String threadId,
    String body, {
    SupportAttachment? attachment,
  }) async {
    final t = _thread(threadId);
    if (t.userId != _require().id) {
      throw const BackendException(BackendFailure.forbidden);
    }
    final path = _store(attachment);
    final now = _now();
    _messages.add(
      SupportMessage(
        id: _id('msg'),
        threadId: threadId,
        fromAdmin: false,
        body: body.trim(),
        attachmentPath: path,
        createdAt: now,
      ),
    );
    _replace(
      _copy(
        t,
        lastUser: now,
        userRead: now,
        status:
            t.status == SupportStatus.answered ||
                t.status == SupportStatus.closed
            ? SupportStatus.newThread
            : null,
      ),
    );
  }

  @override
  Future<void> markRead(String threadId) async {
    final t = _thread(threadId);
    if (t.userId != _require().id) {
      throw const BackendException(BackendFailure.forbidden);
    }
    _replace(_copy(t, userRead: _now()));
  }

  @override
  Future<Uint8List> attachment(String path) async {
    final owner = path.split('/').first;
    if (owner != _require().id && !_isAdmin) {
      throw const BackendException(BackendFailure.forbidden);
    }
    return _files[path] ??
        (throw const BackendException(BackendFailure.notFound));
  }

  @override
  Future<AdminStats> adminStats() async {
    _requireAdmin();
    int count(SupportStatus s) => _threads.where((t) => t.status == s).length;
    final roles = <String, int>{};
    final langs = <String, int>{};
    for (final u in _users.values) {
      if (u.role != null) roles[u.role!] = (roles[u.role!] ?? 0) + 1;
      if (u.language != null) {
        langs[u.language!] = (langs[u.language!] ?? 0) + 1;
      }
    }
    return AdminStats({
      'registered': _users.length,
      'new_today': _users.length,
      'new_7d': _users.length,
      'new_30d': _users.length,
      'active_today': _users.values.where((u) => u.role != null).length,
      'active_7d': _users.values.where((u) => u.role != null).length,
      'active_30d': _users.values.where((u) => u.role != null).length,
      'by_role': roles,
      'by_language': langs,
      'without_profile': _users.values.where((u) => u.role == null).length,
      'billing': null,
      'support': {
        'new': count(SupportStatus.newThread),
        'in_review': count(SupportStatus.inReview),
        'answered': count(SupportStatus.answered),
        'closed': count(SupportStatus.closed),
        'awaiting_reply':
            count(SupportStatus.newThread) + count(SupportStatus.inReview),
      },
    });
  }

  @override
  Future<List<SupportThread>> adminThreads({SupportStatus? status}) async {
    _requireAdmin();
    return _threads
        .where((t) => status == null || t.status == status)
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<void> adminReply(String threadId, String body) async {
    _requireAdmin();
    final t = _thread(threadId);
    final now = _now();
    _messages.add(
      SupportMessage(
        id: _id('msg'),
        threadId: threadId,
        fromAdmin: true,
        body: body.trim(),
        attachmentPath: null,
        createdAt: now,
      ),
    );
    _replace(
      _copy(t, lastAdmin: now, adminRead: now, status: SupportStatus.answered),
    );
    audit.add(
      AuditEntry(
        at: now,
        action: 'support_reply',
        target: threadId,
        details: const {},
      ),
    );
  }

  @override
  Future<void> adminSetStatus(String threadId, SupportStatus status) async {
    _requireAdmin();
    final t = _thread(threadId);
    _replace(_copy(t, status: status));
    audit.add(
      AuditEntry(
        at: _now(),
        action: 'support_status',
        target: threadId,
        details: {'to': supportStatusToWire(status)},
      ),
    );
  }

  @override
  Future<void> adminMarkRead(String threadId) async {
    _requireAdmin();
    _replace(_copy(_thread(threadId), adminRead: _now()));
  }

  @override
  Future<AdminUserPage> adminUsers({
    String? query,
    String? role,
    String? language,
    int limit = 20,
    int offset = 0,
  }) async {
    _requireAdmin();
    final all = _users.values
        .where(
          (u) =>
              (query == null || u.email.contains(query.toLowerCase())) &&
              (role == null || u.role == role) &&
              (language == null || u.language == language),
        )
        .toList();
    final page = all.skip(offset).take(limit);
    return AdminUserPage([
      for (final u in page)
        AdminUserRow(
          userId: u.id,
          emailMasked:
              '${u.email.substring(0, 2)}***@${u.email.split('@').last}',
          role: u.role,
          language: u.language,
          registeredOn: DateTime.utc(2026, 10, 9),
          lastSeenOn: u.role == null ? null : DateTime.utc(2026, 10, 9),
        ),
    ], all.length);
  }

  @override
  Future<String> adminRevealEmail(String userId) async {
    _requireAdmin();
    audit.add(
      AuditEntry(
        at: _now(),
        action: 'reveal_email',
        target: userId,
        details: const {},
      ),
    );
    return _users.values.firstWhere((u) => u.id == userId).email;
  }

  @override
  Future<List<AuditEntry>> adminAudit({int limit = 50}) async {
    _requireAdmin();
    return audit.reversed.take(limit).toList();
  }

  // ------------------------------------------------------------ guruhlar
  // Qoidalar `cloudflare/migrations/*groups*.sql` bilan bir xil: guruhni
  // yaratgan hisob — ustoz; talaba faqat kod bilan qo'shiladi; a'zo bo'lmagan
  // hech narsa ko'rmaydi; kalit faqat ustozga; ball serverda; bir marta
  // topshiriladi; muddat va vaqt chegarasi serverda tekshiriladi.

  /// Server soati (muddat/vaqt chegarasi) — testlarda suriladi.
  DateTime Function() groupClock = DateTime.now;

  /// Vaqt chegarasi tugagach tarmoq kechikishi uchun qo'shimcha vaqt.
  static const submitGrace = Duration(minutes: 2);
  static const _codeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  final List<_Group> _groups = [];
  final List<_Member> _members = [];
  final List<_Assignment> _assignments = [];
  final Map<(String, String), DateTime> _attempts = {};
  final List<GroupSubmission> _submissions = [];

  _Member? _membership(String groupId) => _members
      .where((m) => m.groupId == groupId && m.userId == _current?.id)
      .firstOrNull;
  bool _isMember(String groupId) => _membership(groupId) != null;
  bool _isTeacher(String groupId) => _membership(groupId)?.teacher ?? false;

  /// Taxallus: bo'sh — null (tartib raqami ko'rinadi); email ishlatilmaydi.
  String? _aliasOf(String? alias) {
    // Worker kabi: apostroflar (iPhone ’) normallashtiriladi, belgilar
    // `NICK_RE` bo'yicha tekshiriladi (`400 invalid_nickname`).
    final a = normalizeNickname(alias ?? '');
    if (a.isEmpty) return null;
    _checkLength(a, 2, 24); // ilova maydoni va Worker: 2–24
    if (!nicknameAllowed(a)) {
      throw const BackendException(
        BackendFailure.invalid,
        'invalid nickname',
        'invalid_nickname',
      );
    }
    return a;
  }

  /// Guruh egasi va ro'yxatdan o'tgan ustoz (SQL `_owns_group`).
  bool _owns(String groupId) {
    final u = _current;
    if (u == null || !u.teacher) return false;
    return _groups.any((g) => g.id == groupId && g.ownerId == u.id);
  }

  void _checkLength(String value, int min, int max) {
    final n = value.trim().length;
    if (n < min || n > max) {
      throw const BackendException(BackendFailure.invalid);
    }
  }

  String _newCode() {
    String code;
    do {
      final n = ++_seq * 7919 + _groups.length * 104729;
      code = [
        for (var i = 0; i < 8; i++)
          _codeAlphabet[(n ~/ (i + 1) + i * 13) % _codeAlphabet.length],
      ].join();
    } while (_groups.any((g) => g.code == code));
    return code;
  }

  @override
  Future<List<StudyGroup>> myGroups() async {
    _require();
    return [
      for (final g in _groups.reversed)
        if (_membership(g.id) case final m?)
          StudyGroup(
            id: g.id,
            name: g.name,
            joinCode: m.teacher ? g.code : null,
            isTeacher: m.teacher,
            memberCount: _members.where((x) => x.groupId == g.id).length,
            myNickname: m.alias,
          ),
    ];
  }

  @override
  Future<void> registerTeacher() async {
    _require().teacher = true;
  }

  @override
  Future<StudyGroup> createGroup(String name, {String? displayName}) async {
    final u = _require();
    if (!u.teacher) throw const BackendException(BackendFailure.forbidden);
    _checkLength(name, 3, 80);
    final shown = _aliasOf(displayName);
    if (_groups.where((g) => g.ownerId == u.id).length >= 10) {
      throw const BackendException(BackendFailure.rateLimited);
    }
    final g = _Group(_id('group'), u.id, name.trim(), _newCode());
    _groups.add(g);
    _members.add(_Member(g.id, u.id, shown, teacher: true, joinedAt: _now()));
    return StudyGroup(
      id: g.id,
      name: g.name,
      joinCode: g.code,
      isTeacher: true,
      memberCount: 1,
    );
  }

  @override
  Future<String> joinGroup(String code, {String? displayName}) async {
    final u = _require();
    final g = _groups
        .where(
          (g) => g.code == code.toUpperCase().replaceAll(RegExp(r'[\s-]'), ''),
        )
        .firstOrNull;
    if (g == null) throw const BackendException(BackendFailure.notFound);
    if (_isMember(g.id)) return g.id; // SQL: qayta qo'shilish o'zgartirmaydi
    final shown = _aliasOf(displayName);
    if (_members.where((m) => m.groupId == g.id).length >= 200) {
      throw const BackendException(
        BackendFailure.rateLimited,
        'group full',
        'group_full',
      );
    }
    // Server kabi: taxallus guruhda yagona (katta-kichik harf farqsiz).
    if (shown != null &&
        _members.any(
          (m) =>
              m.groupId == g.id &&
              m.alias?.toLowerCase() == shown.toLowerCase(),
        )) {
      throw const BackendException(
        BackendFailure.invalid,
        'nickname taken',
        'nickname_taken',
      );
    }
    _members.add(
      _Member(
        g.id,
        u.id,
        shown,
        teacher: false,
        joinedAt: _now(),
        seatNo: g.nextSeat++,
      ),
    );
    return g.id;
  }

  @override
  Future<void> setMyAlias(String groupId, String? alias) async {
    final m = _membership(groupId);
    if (m == null) throw const BackendException(BackendFailure.forbidden);
    m.alias = _aliasOf(alias);
  }

  @override
  Future<void> leaveGroup(String groupId) async {
    final u = _require();
    _members.removeWhere(
      (m) => m.groupId == groupId && m.userId == u.id && !m.teacher,
    );
  }

  @override
  Future<List<GroupMember>> groupMembers(String groupId) async {
    _require();
    if (!_isMember(groupId)) return const []; // RLS: begona — bo'sh
    // RLS: talaba — o'zi va ustoz qatori; ustoz — hamma.
    final all = _isTeacher(groupId);
    return [
      for (final m in _members)
        if (m.groupId == groupId &&
            (all || m.teacher || m.userId == _current?.id))
          GroupMember(
            userId: m.userId,
            alias: m.alias,
            seatNo: m.seatNo,
            isTeacher: m.teacher,
            joinedAt: m.joinedAt,
          ),
    ];
  }

  @override
  Future<void> removeMember(String groupId, String userId) async {
    _require();
    if (!_isTeacher(groupId)) {
      throw const BackendException(BackendFailure.forbidden);
    }
    _members.removeWhere(
      (m) => m.groupId == groupId && m.userId == userId && !m.teacher,
    );
  }

  @override
  Future<List<GroupAssignment>> assignments(String groupId) async {
    _require();
    if (!_isMember(groupId)) return const [];
    return [
      for (final a in _assignments.reversed)
        if (a.info.groupId == groupId) a.info,
    ];
  }

  @override
  Future<String> createAssignment({
    required String groupId,
    required String title,
    required List<String> questionIds,
    required List<int> correctIndexes,
    DateTime? dueAt,
    int? timeLimitMinutes,
    String? topicId,
    String? dayId,
    String? deckId,
    bool revealAfterDue = false,
    int? perStudent,
    List<String?>? poolTopics,
  }) async {
    _require();
    if (!_isTeacher(groupId)) {
      throw const BackendException(BackendFailure.forbidden);
    }
    _checkLength(title, 3, 120);
    // 0010: “muddat tugagach” — muddat bo'lishi shart; deck id — mavzu id
    // qoidasi bilan bir xil.
    if ((revealAfterDue && dueAt == null) ||
        (deckId != null && !_topicId.hasMatch(deckId))) {
      throw const BackendException(BackendFailure.invalid);
    }
    // D-66: variantli testda hovuz ≤ 100, takrorsiz, kamida 2 × perStudent.
    if (perStudent != null &&
        (perStudent < 1 ||
            perStudent > 50 ||
            questionIds.toSet().length != questionIds.length ||
            questionIds.length < perStudent * 2 ||
            (poolTopics != null && poolTopics.length != questionIds.length))) {
      throw const BackendException(BackendFailure.invalid, 'per_student');
    }
    if (questionIds.isEmpty ||
        questionIds.length > (perStudent == null ? 50 : 100) ||
        questionIds.length != correctIndexes.length ||
        correctIndexes.any((i) => i < 0) ||
        (timeLimitMinutes != null &&
            (timeLimitMinutes < 1 || timeLimitMinutes > 180)) ||
        (dueAt != null && !dueAt.isAfter(groupClock()))) {
      throw const BackendException(BackendFailure.invalid);
    }
    final a = GroupAssignment(
      id: _id('assignment'),
      groupId: groupId,
      title: title.trim(),
      questionIds: List.unmodifiable(questionIds),
      dueAt: dueAt?.toUtc(),
      timeLimitMinutes: timeLimitMinutes,
      createdAt: _now(),
      topicId: topicId ?? dayId,
      deckId: deckId,
      revealAfterDue: revealAfterDue,
      perStudent: perStudent,
      poolTopics: perStudent == null || poolTopics == null
          ? null
          : List.unmodifiable(poolTopics),
    );
    _assignments.add(_Assignment(a, List.unmodifiable(correctIndexes)));
    return a.id;
  }

  /// Faqat shu guruhning talabasi (SQL dagi kabi; ustoz yecha olmaydi).
  _Assignment _forStudent(String assignmentId) {
    final u = _require();
    final a = _assignments.where((a) => a.info.id == assignmentId).firstOrNull;
    if (a == null ||
        !_members.any(
          (m) => m.groupId == a.info.groupId && m.userId == u.id && !m.teacher,
        )) {
      throw const BackendException(BackendFailure.forbidden);
    }
    return a;
  }

  @override
  Future<AssignmentStart> startAssignment(String assignmentId) async {
    final a = _forStudent(assignmentId);
    final now = groupClock();
    final key = (assignmentId, _current!.id);
    final due = a.info.dueAt;
    if (!_attempts.containsKey(key) && due != null && now.isAfter(due)) {
      throw const BackendException(BackendFailure.invalid, 'past due');
    }
    // Server kabi: yakunlangan testni yangidan boshlab bo'lmaydi.
    if (!_attempts.containsKey(key) && a.closedAt != null) {
      throw const BackendException(BackendFailure.invalid, 'not open');
    }
    final started = _attempts.putIfAbsent(key, () => now);
    return AssignmentStart(
      startedAt: started,
      serverNow: now,
      questionIds: a.info.isVariant
          ? a.info.questionIdsFor(_current!.id)
          : null,
    );
  }

  @override
  Future<List<AssignmentAttempt>> assignmentProgress(
    String assignmentId,
  ) async {
    _require();
    final a = _assignments.where((a) => a.info.id == assignmentId).firstOrNull;
    if (a == null || !_owns(a.info.groupId)) return const [];
    return [
      for (final e in _attempts.entries)
        if (e.key.$1 == assignmentId)
          AssignmentAttempt(userId: e.key.$2, startedAt: e.value),
    ];
  }

  @override
  Future<void> closeAssignment(String assignmentId) async {
    _require();
    final a = _assignments.where((a) => a.info.id == assignmentId).firstOrNull;
    if (a == null || !_owns(a.info.groupId)) {
      throw const BackendException(BackendFailure.forbidden);
    }
    if (a.closedAt != null) return;
    a.closedAt = groupClock();
    final i = a.info;
    a.info = GroupAssignment(
      id: i.id,
      groupId: i.groupId,
      title: i.title,
      questionIds: i.questionIds,
      dueAt: i.dueAt,
      timeLimitMinutes: i.timeLimitMinutes,
      createdAt: i.createdAt,
      topicId: i.topicId,
      deckId: i.deckId,
      revealAfterDue: i.revealAfterDue,
      perStudent: i.perStudent,
      poolTopics: i.poolTopics,
      closed: true,
    );
  }

  @override
  Future<GroupSubmission> submitAssignment(
    String assignmentId,
    List<int> answers, {
    List<String>? questionIds,
  }) async {
    final a = _forStudent(assignmentId);
    final u = _current!;
    final now = groupClock();
    final started = _attempts[(assignmentId, u.id)];
    // Yakunlangan: faqat yakunlanishdan oldin boshlaganlarga 2 daqiqa.
    final closedAt = a.closedAt;
    if (closedAt != null &&
        (started == null ||
            started.isAfter(closedAt) ||
            now.isAfter(closedAt.add(submitGrace)))) {
      throw const BackendException(BackendFailure.invalid, 'closed');
    }
    final due = a.info.dueAt;
    if (due != null) {
      final grace = started != null && !started.isAfter(due)
          ? submitGrace
          : Duration.zero;
      if (now.isAfter(due.add(grace))) {
        throw const BackendException(BackendFailure.invalid, 'past due');
      }
    }
    final limit = a.info.timeLimitMinutes;
    if (limit != null &&
        (started == null ||
            now.isAfter(started.add(Duration(minutes: limit) + submitGrace)))) {
      throw const BackendException(BackendFailure.invalid, 'time over');
    }
    // Server kabi: variantli testda kalit — talabaga tushgan savollarniki;
    // javoblar aynan shu to'plamga (istalgan tartibda) bo'lishi shart.
    final info = a.info;
    final mine = info.questionIdsFor(u.id);
    final key = info.isVariant
        ? [for (final q in mine) a.key[info.questionIds.indexOf(q)]]
        : a.key;
    if (answers.length != key.length) {
      throw const BackendException(BackendFailure.invalid);
    }
    var ordered = answers;
    if (info.isVariant) {
      final ids = questionIds;
      if (ids == null ||
          ids.length != mine.length ||
          ids.toSet().length != ids.length ||
          !ids.every(mine.contains)) {
        throw const BackendException(BackendFailure.invalid, 'questions');
      }
      ordered = [for (final q in mine) answers[ids.indexOf(q)]];
    }
    if (_submissions.any(
      (s) => s.assignmentId == assignmentId && s.userId == u.id,
    )) {
      throw const BackendException(BackendFailure.invalid, 'already');
    }
    final correct = [for (var i = 0; i < key.length; i++) ordered[i] == key[i]];
    final s = GroupSubmission(
      assignmentId: assignmentId,
      userId: u.id,
      score: correct.where((c) => c).length,
      total: key.length,
      submittedAt: now.toUtc(),
      answers: List.unmodifiable(ordered),
      correct: List.unmodifiable(correct),
      questionIds: info.isVariant ? List.unmodifiable(mine) : null,
    );
    _submissions.add(s);
    return _forViewer(s);
  }

  /// Server kabi: “muddat tugagach” topshirig'ida talabaga har savol
  /// natijasi (`correct`) muddatgacha berilmaydi.
  GroupSubmission _forViewer(GroupSubmission s) {
    final a = _assignments.firstWhere((a) => a.info.id == s.assignmentId);
    if (_isTeacher(a.info.groupId) || a.info.answersOpen(groupClock())) {
      return s;
    }
    return GroupSubmission(
      assignmentId: s.assignmentId,
      userId: s.userId,
      score: s.score,
      total: s.total,
      submittedAt: s.submittedAt,
      answers: s.answers,
      questionIds: s.questionIds,
    );
  }

  /// RLS: o'z natijasi yoki ustoz bo'lgan guruhniki.
  bool _canSee(GroupSubmission s) {
    final a = _assignments.firstWhere((a) => a.info.id == s.assignmentId);
    return s.userId == _current?.id || _isTeacher(a.info.groupId);
  }

  @override
  Future<List<GroupSubmission>> submissions(String assignmentId) async {
    _require();
    return [
      for (final s in _submissions)
        if (s.assignmentId == assignmentId && _canSee(s)) _forViewer(s),
    ];
  }

  @override
  Future<List<GroupSubmission>> groupSubmissions(String groupId) async {
    final ids = {for (final a in await assignments(groupId)) a.id};
    return [
      for (final s in _submissions)
        if (ids.contains(s.assignmentId) && _canSee(s)) _forViewer(s),
    ];
  }

  @override
  Future<List<int>> assignmentKey(String assignmentId) async {
    _require();
    final a = _assignments.where((a) => a.info.id == assignmentId).firstOrNull;
    if (a == null || !_isTeacher(a.info.groupId)) {
      throw const BackendException(BackendFailure.forbidden);
    }
    return a.key;
  }

  // ------------------------------------------------------------- mavzular
  // `20261010000100_teacher_topics.sql`: a'zo ochilgan mavzularni ko'radi;
  // ochish, bosqich va testni faqat guruh egasi-ustoz o'zgartiradi.

  final Map<(String, String), GroupTopic> _topics = {};
  static final _topicId = RegExp(r'^[A-Za-z0-9][A-Za-z0-9_.:-]{0,79}$');

  void _requireOwner(String groupId) {
    _require();
    if (!_owns(groupId)) throw const BackendException(BackendFailure.forbidden);
  }

  @override
  Future<List<GroupTopic>> groupTopics(String groupId) async {
    _require();
    if (!_isMember(groupId)) return const [];
    return [
      for (final t in _topics.values)
        if (t.groupId == groupId) t,
    ];
  }

  @override
  Future<void> openTopic(String groupId, String topicId) async {
    _requireOwner(groupId);
    if (!_topicId.hasMatch(topicId)) {
      throw const BackendException(BackendFailure.invalid);
    }
    _topics.putIfAbsent(
      (groupId, topicId),
      () => GroupTopic(
        groupId: groupId,
        topicId: topicId,
        openedAt: groupClock().toUtc(),
      ),
    );
  }

  @override
  Future<void> markTopicStage(
    String groupId,
    String topicId,
    TopicStage stage,
  ) async {
    await openTopic(groupId, topicId);
    final t = _topics[(groupId, topicId)]!;
    final now = groupClock().toUtc();
    _topics[(groupId, topicId)] = switch (stage) {
      TopicStage.lecture => t.copyWith(lectureDoneAt: t.lectureDoneAt ?? now),
      TopicStage.oral => t.copyWith(oralDoneAt: t.oralDoneAt ?? now),
    };
  }

  @override
  Future<String> startTopicTest({
    required String groupId,
    required String topicId,
    required String title,
    required List<String> questionIds,
    required List<int> correctIndexes,
    int? timeLimitMinutes,
  }) async {
    await openTopic(groupId, topicId);
    final t = _topics[(groupId, topicId)]!;
    if (t.testAssignmentId != null) {
      throw const BackendException(BackendFailure.invalid, 'already started');
    }
    final id = await createAssignment(
      groupId: groupId,
      title: title,
      questionIds: questionIds,
      correctIndexes: correctIndexes,
      timeLimitMinutes: timeLimitMinutes,
      topicId: topicId,
    );
    _topics[(groupId, topicId)] = t.copyWith(testAssignmentId: id);
    return id;
  }

  @override
  Future<void> finishTopicTest(String groupId, String topicId) async {
    _requireOwner(groupId);
    final id = _topics[(groupId, topicId)]?.testAssignmentId;
    if (id == null) throw const BackendException(BackendFailure.notFound);
    final a = _assignments.firstWhere((a) => a.info.id == id);
    final now = groupClock().toUtc();
    final due = a.info.dueAt;
    if (due == null || due.isAfter(now)) {
      final i = a.info;
      a.info = GroupAssignment(
        id: i.id,
        groupId: i.groupId,
        title: i.title,
        questionIds: i.questionIds,
        dueAt: now,
        timeLimitMinutes: i.timeLimitMinutes,
        createdAt: i.createdAt,
        topicId: i.topicId,
        deckId: i.deckId,
        revealAfterDue: i.revealAfterDue,
        perStudent: i.perStudent,
        poolTopics: i.poolTopics,
      );
    }
  }
}

class _Group {
  _Group(this.id, this.ownerId, this.name, this.code);
  final String id;
  final String ownerId;
  final String name;
  final String code;

  /// Keyingi talabaning tartib raqami (qayta ishlatilmaydi).
  int nextSeat = 1;
}

class _Member {
  _Member(
    this.groupId,
    this.userId,
    this.alias, {
    required this.teacher,
    required this.joinedAt,
    this.seatNo,
  });
  final String groupId;
  final String userId;
  String? alias;
  final bool teacher;
  final DateTime joinedAt;
  final int? seatNo;
}

class _Assignment {
  _Assignment(this.info, this.key);
  GroupAssignment info;
  final List<int> key;

  /// Ustoz yakunlagan vaqt ([FakeBackend.closeAssignment]).
  DateTime? closedAt;
}

/// Cloudflare serveriga o'xshash soxta server: adminlar boshqaruvi (D-44)
/// bor; Supabase'dan hali ko'chirilmagan admin bo'limlari (statistika,
/// murojaatlar, foydalanuvchilar, jurnal, hamkorlar, tekshiruv) —
/// `unavailable` ([legacyAdminApi] `true` bo'lsa — ishlaydi).
///
/// Qoidalar serverdagidek: faqat super admin (+aal2) qo'shadi/oladi; email
/// faqat niqoblangan holda qaytadi; olib tashlangan admin darhol vakolatini
/// yo'qotadi.
class FakeAdminTeamBackend extends FakeBackend implements AdminTeamBackend {
  FakeAdminTeamBackend({super.adminEmails, this.legacyAdminApi = false});

  final bool legacyAdminApi;
  static const maxGranted = 20;

  /// Ilova qaysi emaillarni yuborganini tekshirish uchun (faqat test).
  final List<String> addCalls = [];

  static String mask(String email) {
    final i = email.indexOf('@');
    final local = email.substring(0, i);
    return '${local.substring(0, local.length < 2 ? local.length : 2)}***${email.substring(i)}';
  }

  Never _notYet() => throw const BackendException(
    BackendFailure.unavailable,
    'not ported to cloudflare yet',
  );

  void _requireSuper() {
    _requireAdmin();
    if (!_isSuperAdmin) {
      throw const AdminTeamException(
        BackendFailure.forbidden,
        'not_super_admin',
      );
    }
  }

  @override
  Future<AdminTeam> adminTeam() async {
    _requireAdmin();
    final me = _current!.email;
    return AdminTeam(
      canManage: _isSuperAdmin,
      maxGranted: maxGranted,
      admins: [
        for (final e in adminEmails)
          AdminEntry(
            id: null,
            emailMasked: mask(e),
            kind: AdminKind.superAdmin,
            active: _users.containsKey(e),
            you: e == me,
          ),
        for (final g
            in _grants.entries.toList()
              ..sort((a, b) => b.value.at.compareTo(a.value.at)))
          AdminEntry(
            id: g.value.id,
            emailMasked: mask(g.key),
            kind: AdminKind.granted,
            active: _users.containsKey(g.key),
            you: g.key == me,
            createdAt: g.value.at,
          ),
      ],
    );
  }

  @override
  Future<AdminEntry> addAdmin(String email) async {
    _requireSuper();
    addCalls.add(email);
    if (!isValidEmail(email)) {
      throw const AdminTeamException(BackendFailure.invalid, 'invalid_email');
    }
    final e = normalizeEmail(email);
    if (adminEmails.contains(e)) {
      throw const AdminTeamException(
        BackendFailure.invalid,
        'already_super_admin',
      );
    }
    if (_grants.containsKey(e)) {
      throw const AdminTeamException(BackendFailure.invalid, 'already_admin');
    }
    if (_grants.length >= maxGranted) {
      throw const AdminTeamException(BackendFailure.invalid, 'too_many_admins');
    }
    final g = (id: _id('grant'), at: _now());
    _grants[e] = g;
    audit.add(
      AuditEntry(
        action: 'admin_grant_added',
        at: g.at,
        target: g.id,
        details: const {},
      ),
    );
    return AdminEntry(
      id: g.id,
      emailMasked: mask(e),
      kind: AdminKind.granted,
      active: _users.containsKey(e),
      you: false,
      createdAt: g.at,
    );
  }

  @override
  Future<void> removeAdmin(String id) async {
    _requireSuper();
    final key = _grants.entries
        .where((g) => g.value.id == id)
        .map((g) => g.key)
        .firstOrNull;
    if (key == null) throw const BackendException(BackendFailure.notFound);
    _grants.remove(key);
    if (_current?.email == key) _aal2 = false;
    audit.add(
      AuditEntry(
        action: 'admin_grant_removed',
        at: _now(),
        target: id,
        details: const {},
      ),
    );
  }

  /// Boshqa qurilmadagi super admin olib tashladi (test: mavjud sessiya).
  void revokeGrantFor(String email) {
    final e = normalizeEmail(email);
    _grants.remove(e);
    // Server sessiyalarni aal1 ga tushiradi.
    if (_current?.email == e) _aal2 = false;
  }

  @override
  Future<AdminStats> adminStats() async =>
      legacyAdminApi ? super.adminStats() : _notYet();
  @override
  Future<List<SupportThread>> adminThreads({SupportStatus? status}) async =>
      legacyAdminApi ? super.adminThreads(status: status) : _notYet();
  @override
  Future<AdminUserPage> adminUsers({
    String? query,
    String? role,
    String? language,
    int limit = 20,
    int offset = 0,
  }) async => legacyAdminApi
      ? super.adminUsers(
          query: query,
          role: role,
          language: language,
          limit: limit,
          offset: offset,
        )
      : _notYet();
  @override
  Future<List<AuditEntry>> adminAudit({int limit = 50}) async =>
      legacyAdminApi ? super.adminAudit(limit: limit) : _notYet();
  @override
  Future<List<SupportThread>> myThreads() async =>
      legacyAdminApi ? super.myThreads() : _notYet();
}

/// Cloudflare egasi admin paneli soxtasi: ADMIN_EMAILS dagi email kod bilan
/// kirsa — TOTP siz admin ([allowsPanelAdmin]); foydalanuvchilar (rol,
/// to'xtatish), ilova shikoyatlari, hamjamiyat shikoyatlari, jurnal.
/// Qoidalar serverdagidek: oddiy foydalanuvchi — `forbidden`, admin
/// to'xtatilmaydi, o'z rolini o'zgartira olmaydi, to'xtatilgan hisob kira
/// olmaydi, shikoyat — soatiga 5 ta (mehmon ham).
class FakeAdminConsoleBackend extends FakeAdminTeamBackend
    implements AdminConsoleBackend, ComplaintsBackend, SupportAttachmentPolicy {
  FakeAdminConsoleBackend({super.adminEmails}) : super(legacyAdminApi: true);

  @override
  bool get allowsPanelAdmin => true;
  @override
  bool get supportAttachments => false;

  final Set<String> _suspendedEmails = {};
  final Map<String, String> nicknames = {};
  final List<Complaint> complaints = [];
  final Map<String, int> _complaintHits = {};

  /// Keyingi admin o'qishi shu xato bilan tugaydi (xato holatini sinash).
  BackendException? failNext;

  /// Berilsa — admin o'qishlari shu tugaguncha kutadi (yuklanish holati).
  Completer<void>? hold;

  Future<void> _gate() async {
    final h = hold;
    if (h != null) await h.future;
    final f = failNext;
    if (f != null) {
      failNext = null;
      throw f;
    }
  }

  void _panel() {
    if (!_isAdmin) {
      throw const AdminConsoleException(BackendFailure.forbidden, 'forbidden');
    }
  }

  _User _byId(String id) => _users.values.firstWhere(
    (u) => u.id == id,
    orElse: () =>
        throw const AdminConsoleException(BackendFailure.notFound, 'not_found'),
  );

  void _log(String action, String? target, [Map<String, Object?>? d]) =>
      audit.add(
        AuditEntry(
          at: _now(),
          action: action,
          target: target,
          details: d ?? const {},
          actorMasked: _current == null
              ? null
              : FakeAdminTeamBackend.mask(_current!.email),
        ),
      );

  @override
  Future<OtpVerifyResult> verifyCode(String email, String code) async {
    if (_suspendedEmails.contains(normalizeEmail(email))) {
      return const OtpVerifyResult(OtpVerifyStatus.accountSuspended);
    }
    return super.verifyCode(email, code);
  }

  @override
  Future<AdminStats> adminStats() async {
    await _gate();
    _panel();
    final base = (await super.adminStats()).json;
    final today = DateTime.utc(2026, 10, 17);
    return AdminStats({
      ...base,
      'billing': null,
      'online_now': _current == null ? 0 : 1,
      'suspended_accounts': _suspendedEmails.length,
      'new_by_day': [
        for (var i = 13; i >= 0; i--)
          {
            'day': today
                .subtract(Duration(days: i))
                .toIso8601String()
                .substring(0, 10),
            'n': i == 0 ? _users.length : (i % 3),
          },
      ],
      'groups': {
        'groups': 2,
        'teachers': 1,
        'students': 7,
        'assignments': 3,
        'results': 12,
      },
      'complaints': {
        'open': complaints
            .where((c) => c.status == ComplaintStatus.open)
            .length,
        'resolved': complaints
            .where((c) => c.status == ComplaintStatus.resolved)
            .length,
      },
    });
  }

  AdminAccountRow _row(_User u) => AdminAccountRow(
    userId: u.id,
    emailMasked: FakeAdminTeamBackend.mask(u.email),
    role: u.role ?? 'student',
    language: u.language ?? 'uz',
    registeredOn: DateTime.utc(2026, 10, 9),
    lastSeenOn: DateTime.utc(2026, 10, 16),
    status: _suspendedEmails.contains(u.email)
        ? AccountStatus.suspended
        : AccountStatus.active,
    admin: adminEmails.contains(u.email),
  );

  @override
  Future<AdminAccountPage> adminAccounts({
    String? email,
    String? name,
    String? role,
    AccountStatus? status,
    int limit = 20,
    int offset = 0,
  }) async {
    await _gate();
    _panel();
    if (email != null && !isValidEmail(email)) {
      throw const AdminConsoleException(
        BackendFailure.invalid,
        'invalid_email',
      );
    }
    if (name != null && (name.length < 2 || name.length > 40)) {
      throw const AdminConsoleException(BackendFailure.invalid, 'invalid_name');
    }
    final rows = [
      for (final u in _users.values)
        if ((email == null || u.email == normalizeEmail(email)) &&
            // Taxallus: `%`/`_` oddiy belgi (serverdagi LIKE ekranlash kabi).
            (name == null ||
                (nicknames[u.id]?.toLowerCase().contains(name.toLowerCase()) ??
                    false)) &&
            (role == null || (u.role ?? 'student') == role))
          _row(u),
    ].where((r) => status == null || r.status == status).toList();
    return AdminAccountPage(
      rows.skip(offset).take(limit).toList(),
      rows.length,
    );
  }

  @override
  Future<AdminUserDetail> adminUserDetail(String userId) async {
    await _gate();
    _panel();
    final u = _byId(userId);
    return AdminUserDetail(
      account: _row(u),
      you: u.id == _current?.id,
      teacher: u.teacher,
      groupsOwned: 0,
      groupsJoined: nicknames.containsKey(u.id) ? 1 : 0,
      supportThreads: _threads.where((t) => t.userId == u.id).length,
      complaints: complaints.where((c) => c.userId == u.id).length,
    );
  }

  @override
  Future<void> adminSetRole(String userId, String role) async {
    _panel();
    final u = _byId(userId);
    if (u.id == _current!.id) {
      throw const AdminConsoleException(BackendFailure.forbidden, 'self');
    }
    final from = u.role;
    u.role = role;
    _log('role_changed', u.id, {'from': from, 'to': role});
  }

  @override
  Future<void> adminSuspendAccount(String userId) async {
    _panel();
    final u = _byId(userId);
    if (u.id == _current!.id) {
      throw const AdminConsoleException(BackendFailure.forbidden, 'self');
    }
    if (adminEmails.contains(u.email)) {
      throw const AdminConsoleException(BackendFailure.forbidden, 'admin');
    }
    if (_suspendedEmails.add(u.email)) _log('account_suspended', u.id);
  }

  @override
  Future<void> adminReactivateAccount(String userId) async {
    _panel();
    final u = _byId(userId);
    if (_suspendedEmails.remove(u.email)) _log('account_reactivated', u.id);
  }

  @override
  Future<void> adminDeleteAccount({
    required String email,
    required String confirmUserId,
  }) async {
    _panel();
    if (!isValidEmail(email)) {
      throw const AdminConsoleException(
        BackendFailure.invalid,
        'invalid_email',
      );
    }
    final u = _users[normalizeEmail(email)];
    if (u == null) {
      throw const AdminConsoleException(BackendFailure.notFound, 'not_found');
    }
    if (u.id != confirmUserId) {
      throw const AdminConsoleException(
        BackendFailure.invalid,
        'confirmation_mismatch',
      );
    }
    if (u.id == _current!.id) {
      throw const AdminConsoleException(BackendFailure.forbidden, 'self');
    }
    if (adminEmails.contains(u.email)) {
      throw const AdminConsoleException(BackendFailure.forbidden, 'admin');
    }
    _users.remove(u.email);
    _threads.removeWhere((t) => t.userId == u.id);
    deletedByAdmin.add(u.id);
    _log('account_deleted_by_admin', u.id, {'via': 'admin_console'});
  }

  /// Admin panelidan o'chirilgan hisoblar (testlar tekshiradi).
  final List<String> deletedByAdmin = [];

  @override
  Future<void> submitComplaint({
    required ComplaintKind kind,
    required String body,
    String? targetRef,
    String? lang,
  }) async {
    if (body.trim().length < 5 || body.length > 2000) {
      throw const ComplaintException(BackendFailure.invalid);
    }
    final key = _current?.id ?? 'guest';
    final n = (_complaintHits[key] ?? 0) + 1;
    _complaintHits[key] = n;
    if (n > 5) {
      throw const ComplaintException(
        BackendFailure.rateLimited,
        retryAfter: Duration(minutes: 30),
      );
    }
    complaints.insert(
      0,
      Complaint(
        id: _id('complaint'),
        kind: kind,
        body: body.trim(),
        status: ComplaintStatus.open,
        createdAt: _now(),
        targetRef: targetRef,
        anonymous: _current == null,
        userId: _current?.id,
        emailMasked: _current == null
            ? null
            : FakeAdminTeamBackend.mask(_current!.email),
      ),
    );
  }

  Complaint _complaint(String id) => complaints.firstWhere(
    (c) => c.id == id,
    orElse: () =>
        throw const AdminConsoleException(BackendFailure.notFound, 'not_found'),
  );

  Complaint _replaceComplaint(
    Complaint c, {
    String? note,
    ComplaintStatus? status,
  }) {
    final s = status ?? c.status;
    final n = Complaint(
      id: c.id,
      kind: c.kind,
      body: c.body,
      status: s,
      createdAt: c.createdAt,
      targetRef: c.targetRef,
      adminNote: note ?? c.adminNote,
      anonymous: c.anonymous,
      userId: c.userId,
      emailMasked: c.emailMasked,
      resolvedAt: s == ComplaintStatus.resolved ? _now() : null,
    );
    complaints[complaints.indexWhere((x) => x.id == c.id)] = n;
    return n;
  }

  @override
  Future<List<Complaint>> adminComplaints({
    ComplaintStatus? status,
    ComplaintKind? kind,
  }) async {
    await _gate();
    _panel();
    return complaints
        .where(
          (c) =>
              (status == null || c.status == status) &&
              (kind == null || c.kind == kind),
        )
        .toList();
  }

  @override
  Future<Complaint> adminComplaint(String id) async {
    await _gate();
    _panel();
    return _complaint(id);
  }

  @override
  Future<Complaint> adminComplaintNote(String id, String note) async {
    _panel();
    final c = _replaceComplaint(_complaint(id), note: note.trim());
    _log('complaint_note', id);
    return c;
  }

  @override
  Future<Complaint> adminSetComplaintStatus(
    String id,
    ComplaintStatus status,
  ) async {
    _panel();
    final c = _replaceComplaint(_complaint(id), status: status);
    _log(
      status == ComplaintStatus.resolved
          ? 'complaint_resolved'
          : 'complaint_reopened',
      id,
    );
    return c;
  }

  @override
  Future<List<AuditEntry>> adminAudit({int limit = 50}) async {
    await _gate();
    _panel();
    return audit.reversed.take(limit).toList();
  }
}
