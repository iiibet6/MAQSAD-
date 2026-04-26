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

class _MemoriesScreen extends StatelessWidget {
  const _MemoriesScreen();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final t = AppLocalizations.of(context)!;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(t.memories),
        ),
        body: Center(
          child: Text(t.loginRequired),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.memories),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('photos')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(t.noPhotos),
            );
          }

          final photos = snapshot.data!.docs;return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: photos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final imageUrl = photos[index]['imageUrl'];

              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
    );
  }
}