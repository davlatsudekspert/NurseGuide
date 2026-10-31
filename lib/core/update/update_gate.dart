import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:material_ui/material_ui.dart';

import '../../app/widgets/links.dart';
import '../../l10n/gen/app_localizations.dart';

/// Build raqami (CI beradi: `--dart-define=NG_BUILD=<raqam>`); berilmasa 0 —
/// tekshiruv ishlamaydi (debug/test).
const kBuildNumber = int.fromEnvironment('NG_BUILD');

const kUpdateConfigUrl = 'https://nurseguide.nfcstore.uz/app-config.json';

class UpdateRequirement {
  const UpdateRequirement(this.minBuild, this.url);

  final int minBuild;
  final String? url;

  bool blocks(int build) => build > 0 && minBuild > build;
}

/// `app-config.json`: `{"android": {"min_build": 70, "url": "..."}, "ios": {...}}`.
/// Har qanday xato (tarmoq, vaqt, noto'g'ri JSON) — `null` (ilova ishlayveradi).
UpdateRequirement? parseUpdateConfig(String body, {required bool android}) {
  try {
    final m = jsonDecode(body);
    if (m is! Map) return null;
    final p = m[android ? 'android' : 'ios'];
    if (p is! Map) return null;
    final min = p['min_build'];
    if (min is! int || min < 0) return null;
    final url = p['url'];
    final ok = url is String && url.startsWith('https://');
    return UpdateRequirement(min, ok ? url : null);
  } on Object {
    return null;
  }
}

typedef UpdateFetcher = Future<UpdateRequirement?> Function();

UpdateFetcher httpUpdateFetcher({http.Client? client}) => () async {
  final c = client ?? http.Client();
  try {
    final r = await c
        .get(Uri.parse(kUpdateConfigUrl))
        .timeout(const Duration(seconds: 5));
    if (r.statusCode != 200) return null;
    return parseUpdateConfig(
      utf8.decode(r.bodyBytes),
      android: defaultTargetPlatform == TargetPlatform.android,
    );
  } on Object {
    return null;
  } finally {
    if (client == null) c.close();
  }
};

/// Eski versiyani to'xtatadi: ochilganda va fondan qaytganda tekshiradi.
class UpdateGate extends StatefulWidget {
  const UpdateGate({
    super.key,
    required this.child,
    this.build = kBuildNumber,
    this.fetch,
  });

  final Widget child;
  final int build;
  final UpdateFetcher? fetch;

  @override
  State<UpdateGate> createState() => _UpdateGateState();
}

class _UpdateGateState extends State<UpdateGate> with WidgetsBindingObserver {
  UpdateRequirement? _req;
  late final UpdateFetcher _fetch = widget.fetch ?? httpUpdateFetcher();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.build > 0) unawaited(_check());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && widget.build > 0) {
      unawaited(_check());
    }
  }

  Future<void> _check() async {
    final r = await _fetch();
    if (mounted && r != null) setState(() => _req = r);
  }

  @override
  Widget build(BuildContext context) {
    final r = _req;
    if (r != null && r.blocks(widget.build)) {
      return _UpdateRequired(url: r.url);
    }
    return widget.child;
  }
}

class _UpdateRequired extends StatelessWidget {
  const _UpdateRequired({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return Scaffold(
      key: const ValueKey('update-required'),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.system_update_rounded, size: 64),
                const SizedBox(height: 20),
                Text(
                  l.updateTitle,
                  style: text.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  l.updateBody,
                  style: text.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                FilledButton(
                  key: const ValueKey('update-action'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(220, 52),
                  ),
                  onPressed: () => openExternalLink(
                    context,
                    url ?? 'https://nurseguide.nfcstore.uz/',
                  ),
                  child: Text(l.updateAction),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
