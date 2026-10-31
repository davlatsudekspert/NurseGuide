import 'package:flutter/foundation.dart' show Uint8List;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/widgets/lg_page.dart';
import '../../app/widgets/links.dart';
import '../../design/tokens.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'profile_card.dart';

FaIconData socialIcon(SocialNetwork n) => switch (n) {
  SocialNetwork.instagram => FontAwesomeIcons.instagram,
  SocialNetwork.telegram => FontAwesomeIcons.telegram,
  SocialNetwork.facebook => FontAwesomeIcons.facebook,
  SocialNetwork.youtube => FontAwesomeIcons.youtube,
  SocialNetwork.tiktok => FontAwesomeIcons.tiktok,
};

/// Dumaloq profil rasmi (yo'q bo'lsa — ikonka).
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.photo, this.size = 56});

  final Uint8List? photo;
  final double size;

  @override
  Widget build(BuildContext context) {
    final p = LgPalette.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: p.soft, shape: BoxShape.circle),
      child: photo == null
          ? Icon(Icons.person_rounded, color: p.brand, size: size * 0.55)
          : ClipOval(
              child: Image.memory(
                photo!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                errorBuilder: (_, _, _) => Icon(
                  Icons.person_rounded,
                  color: p.brand,
                  size: size * 0.55,
                ),
              ),
            ),
    );
  }
}

/// Ijtimoiy tarmoq ikonlari: bosilganda havola tashqi ilovada ochiladi.
class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key, required this.card});

  final ProfileCardController card;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = LgPalette.of(context);
    return Wrap(
      spacing: 4,
      children: [
        for (final n in card.networks)
          IconButton(
            key: ValueKey('social-${n.name}'),
            tooltip: l.profileOpenLink(n.label),
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            icon: FaIcon(socialIcon(n), color: p.brand, size: 22),
            onPressed: () => openExternalLink(context, card.link(n)),
          ),
      ],
    );
  }
}

/// «Mening profilim»: rasm, ish joyi, ijtimoiy tarmoqlar (ixtiyoriy, qurilmada).
class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late final ProfileCardController _card;
  final _name = TextEditingController();
  final _workplace = TextEditingController();
  final _position = TextEditingController();
  final _city = TextEditingController();
  final _links = {
    for (final n in SocialNetwork.values) n: TextEditingController(),
  };
  Map<SocialNetwork, String> _errors = const {};
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    _loaded = true;
    _card = AppScope.of(context).profileCard;
    _name.text = _card.name;
    _workplace.text = _card.workplace;
    _position.text = _card.position;
    _city.text = _card.city;
    for (final n in SocialNetwork.values) {
      _links[n]!.text = _card.link(n);
    }
  }

  @override
  void dispose() {
    for (final c in [_name, _workplace, _position, _city, ..._links.values]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final errors = <SocialNetwork, String>{};
    final links = <SocialNetwork, String>{};
    for (final n in SocialNetwork.values) {
      final v = n.normalize(_links[n]!.text);
      if (v == null) {
        errors[n] = l.profileLinkInvalid(n.label);
      } else {
        links[n] = v;
      }
    }
    setState(() => _errors = errors);
    if (errors.isNotEmpty) return;
    await _card.save(
      name: _name.text,
      workplace: _workplace.text,
      position: _position.text,
      city: _city.text,
      links: links,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l.profileSaved)));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return LgPage(
      title: l.profileMe,
      subtitle: l.profileMeSub,
      showProfile: false,
      children: [
        ListenableBuilder(
          listenable: _card,
          builder: (context, _) => Column(
            children: [
              Center(
                child: GestureDetector(
                  key: const ValueKey('my-photo'),
                  onTap: _card.pickPhoto,
                  child: ProfileAvatar(photo: _card.photo, size: 104),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  TextButton(
                    key: const ValueKey('my-photo-pick'),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(48, 48),
                    ),
                    onPressed: _card.pickPhoto,
                    child: Text(
                      _card.photo == null
                          ? l.profilePhotoPick
                          : l.profilePhotoChange,
                    ),
                  ),
                  if (_card.photo != null)
                    TextButton(
                      key: const ValueKey('my-photo-remove'),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(48, 48),
                      ),
                      onPressed: _card.removePhoto,
                      child: Text(l.profilePhotoRemove),
                    ),
                ],
              ),
            ],
          ),
        ),
        LgField(
          key: const ValueKey('my-name'),
          label: l.profileFieldName,
          controller: _name,
          maxLength: 60,
        ),
        LgSectionTitle(l.profileWorkTitle),
        LgField(
          key: const ValueKey('my-workplace'),
          label: l.profileFieldWorkplace,
          controller: _workplace,
          maxLength: 80,
        ),
        LgField(
          key: const ValueKey('my-position'),
          label: l.profileFieldPosition,
          controller: _position,
          maxLength: 60,
        ),
        LgField(
          key: const ValueKey('my-city'),
          label: l.profileFieldCity,
          controller: _city,
          maxLength: 60,
        ),
        LgSectionTitle(l.profileSocialTitle),
        for (final n in SocialNetwork.values)
          LgField(
            key: ValueKey('my-social-${n.name}'),
            label: n.label,
            hint: l.profileSocialHint,
            controller: _links[n],
            keyboardType: TextInputType.url,
            errorText: _errors[n],
          ),
        const SizedBox(height: 4),
        Text(l.profileLocalNote, style: text.bodySmall),
        const SizedBox(height: 16),
        LgButton(
          key: const ValueKey('my-save'),
          label: l.actionSave,
          onPressed: _save,
        ),
      ],
    );
  }
}
