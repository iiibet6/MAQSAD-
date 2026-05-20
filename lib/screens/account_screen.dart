import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'favorites_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'privacy_policy_screen.dart';
import 'profile_info_screen.dart';
import '../main.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _notificationsEnabled = true;
  final int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Image.asset(
              'assets/images/gh.png',
              width: double.infinity,
              height: 45,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: ListView(
                children: [
                  const _ProfileHeader(),
                  const _QuickActions(),
                  const SizedBox(height: 8),
                  _SettingsSection(
                    notificationsEnabled: _notificationsEnabled,
                    onNotificationsChanged: (v) {
                      setState(() {
                        _notificationsEnabled = v;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const _LogoutButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: _navIndex,
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.border,
              border: Border.all(color: AppColors.divider, width: 2),
            ),
            child: const Icon(
              Icons.person,
              size: 44,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .get(),
            builder: (context, snapshot) {
              String name = t.guestName;

              if (snapshot.hasData && snapshot.data!.exists) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                name = data['name'] ?? t.guestName;
              }

              return Text(
                name,
                style: AppTextStyles.headline2,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _QuickActionItem(
            icon: Icons.photo_library_outlined,
            label: t.memories,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const _MemoriesScreen(),
                ),
              );
            },
          ),
          _QuickActionItem(
            icon: Icons.map_outlined,
            label: t.visits,
          ),
          _QuickActionItem(
            icon: Icons.favorite_border,
            label: t.favorites,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              );
            },
          ),
          _QuickActionItem(
            icon: Icons.help_outline,
            label: t.contact,
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.textSecondary,
            size: 26,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final bool notificationsEnabled;
  final ValueChanged<bool> onNotificationsChanged;

  const _SettingsSection({
    required this.notificationsEnabled,
    required this.onNotificationsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final currentLang = Localizations.localeOf(context).languageCode;return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 16),
          _SectionLabel(label: t.myAccount),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.person_outline,
            label: t.myInfo,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileInfoScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _SectionLabel(label: t.settings),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.language,
            label: t.language,
            trailing: Text(
              currentLang == 'ar' ? 'العربية' : 'English',
              style: AppTextStyles.caption,
            ),
            onTap: () {
              final app = MaqsadApp.of(context);
              app?.changeLanguage(currentLang == 'ar' ? 'en' : 'ar');
            },
          ),
          const SizedBox(height: 8),
          _SettingsTileToggle(
            icon: Icons.notifications_outlined,
            label: t.notifications,
            value: notificationsEnabled,
            onChanged: onNotificationsChanged,
          ),
          const SizedBox(height: 16),
          _SectionLabel(label: t.other),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.lightbulb_outline,
            label: t.suggestions,
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            label: t.privacy,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.group_add_outlined,
            label: t.partners,
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.system_update_outlined,
            label: t.update,
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.cancel_outlined,
            label: t.deleteAccount,
            labelColor: AppColors.deleteRed,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? labelColor;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    this.labelColor,
    this.trailing,
    required this.onTap,
  });@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: labelColor ?? AppColors.textSecondary,
            ),
            const Spacer(),
            if (trailing != null) ...[
              trailing!,
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: 14,
                color: labelColor ?? AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTileToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsTileToggle({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.successGreen,
          ),
          const Spacer(),
          Icon(
            icon,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.bodyLarge.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: PrimaryButton(
        label: t.logout,
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/');
          }
        },
      ),
    );
  }
}

class _MemoriesScreen extends StatefulWidget {
  const _MemoriesScreen();

  @override
  State<_MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<_MemoriesScreen> {
  Future<Map<String, List<String>>> _loadAlbums() async {
    final prefs = await SharedPreferences.getInstance();

    final keys = prefs
        .getKeys()
        .where((key) => key.startsWith('local_photos_'))
        .toList();

    final Map<String, List<String>> albums = {};

    for (final key in keys) {
      final placeName = key.replaceFirst('local_photos_', '');
      final photos = prefs.getStringList(key) ?? [];

      if (photos.isNotEmpty) {
        albums[placeName] = photos;
      }
    }

    return albums;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.memories),
      ),
      body: FutureBuilder<Map<String, List<String>>>(
        future: _loadAlbums(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final albums = snapshot.data!;

          if (albums.isEmpty) {
            return Center(
              child: Text(t.noPhotos),
            );
          }

          final places = albums.keys.toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: places.length,
            itemBuilder: (context, index) {
              final placeName = places[index];
              final photos = albums[placeName]!;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(photos.first),
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(placeName),
                  subtitle: Text('${photos.length} صورة'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _PlaceAlbumScreen(
                          placeName: placeName,
                          photos: photos,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PlaceAlbumScreen extends StatefulWidget {
  final String placeName;
  final List<String> photos;

  const _PlaceAlbumScreen({
    required this.placeName,
    required this.photos,
  });

  @override
  State<_PlaceAlbumScreen> createState() => _PlaceAlbumScreenState();
}

class _PlaceAlbumScreenState extends State<_PlaceAlbumScreen> {
  late List<String> photos;

  @override
  void initState() {
    super.initState();
    photos = List.from(widget.photos);
  }

  Future<void> _deletePhoto(String path) async {
    final prefs = await SharedPreferences.getInstance();
    final albumKey = 'local_photos_${widget.placeName}';

    photos.remove(path);

    await prefs.setStringList(albumKey, photos);

    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حذف الصورة'),
      ),
    );
  }

  Future<void> _sharePhoto(String path) async {
  final file = File(path);

  if (!await file.exists()) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('الصورة غير موجودة'),
      ),
    );
    return;
  }

  await Share.shareXFiles(
    [XFile(path)],
    text: 'ذكرى من ${widget.placeName}',
  );
}

  void _showPhotoOptions(String path) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('مشاركة الصورة'),
                  onTap: () {
                    Navigator.pop(context);
                    _sharePhoto(path);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'حذف الصورة',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _deletePhoto(path);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.placeName),
        ),
        body: const Center(
          child: Text('لا توجد صور بعد 📸'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.placeName),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
  final path = photos[index];

  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Stack(
      children: [
        Positioned.fill(
          child: Image.file(
            File(path),
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => _sharePhoto(path),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.share,
                size: 18,
              ),
            ),
          ),
        ),

        Positioned(
          top: 8,
          left: 8,
          child: GestureDetector(
            onTap: () => _deletePhoto(path),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    ),
  );
},
      ),
    );
  }
}