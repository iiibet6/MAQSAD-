import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../services/favorites_service.dart';
import 'favorites_screen.dart';
/// Screen 7 – Account / Profile
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _notificationsEnabled = true;
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            const PatternBorderFallback(),
            Expanded(
              child: ListView(
                children: [
                  _ProfileHeader(),
                  _QuickActions(),
                  const SizedBox(height: 8),
                  _SettingsSection(
                    notificationsEnabled: _notificationsEnabled,
                    onNotificationsChanged: (v) => setState(() => _notificationsEnabled = v),
                  ),
                  const SizedBox(height: 16),
                  _LogoutButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:AppBottomNavBar(
  currentIndex: _navIndex,
),
      ),
    );
  }
}

// ─── Profile Header ─────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: const Icon(Icons.person, size: 44, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          const Text(
            'البتول',
            style: AppTextStyles.headline2,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}

// ─── Quick Actions Row ──────────────────────────────────────────
class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
  const _QuickActionItem(icon: Icons.photo_library_outlined, label: 'ألبوم الذكريات'),
  const _QuickActionItem(icon: Icons.map_outlined, label: 'سجل الزيارات'),

  _QuickActionItem(
    icon: Icons.favorite_border,
    label: 'المفضلات',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const FavoritesScreen(),
        ),
      );
    },
  ),

  const _QuickActionItem(icon: Icons.help_outline, label: 'تواصل معنا'),
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
          Icon(icon, color: AppColors.textSecondary, size: 26),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(fontSize: 11),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}

// ─── Settings Sections ──────────────────────────────────────────
class _SettingsSection extends StatelessWidget {
  final bool notificationsEnabled;
  final ValueChanged<bool> onNotificationsChanged;

  const _SettingsSection({
    required this.notificationsEnabled,
    required this.onNotificationsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 16),
          _SectionLabel(label: 'حسابي'),
          const SizedBox(height: 8),
          _SettingsTile(icon: Icons.person_outline, label: 'معلوماتي', onTap: () {}),

          const SizedBox(height: 16),
          _SectionLabel(label: 'الإعدادات'),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.language,
            label: 'اللغة',
            trailing: const Text('English', style: AppTextStyles.caption),
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _SettingsTileToggle(
            icon: Icons.notifications_outlined,
            label: 'إشعارات مقصد',
            value: notificationsEnabled,
            onChanged: onNotificationsChanged,
          ),

          const SizedBox(height: 16),
          _SectionLabel(label: 'أخرى'),
          const SizedBox(height: 8),
          _SettingsTile(icon: Icons.lightbulb_outline, label: 'الإقتراحات', onTap: () {}),
          const SizedBox(height: 8),
          _SettingsTile(icon: Icons.group_add_outlined, label: 'إنضم الى شركاء مقصد', onTap: () {}),
          const SizedBox(height: 8),
          _SettingsTile(icon: Icons.system_update_outlined, label: 'تحقق من أخر التحديثات', onTap: () {}),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.cancel_outlined,
            label: 'حذف الحساب',
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
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
      textDirection: TextDirection.rtl,
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
  });

  @override
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
            Icon(icon, size: 20, color: labelColor ?? AppColors.textSecondary),
            const Spacer(),
            if (trailing != null) ...[trailing!, const SizedBox(width: 8)],
            Text(
              label,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: 14,
                color: labelColor ?? AppColors.textPrimary,
              ),
              textDirection: TextDirection.rtl,
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
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.bodyLarge.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}

// ─── Logout Button ──────────────────────────────────────────────
class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: PrimaryButton(
        label: 'تسجيل خروج',
        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
      ),
    );
  }
}
