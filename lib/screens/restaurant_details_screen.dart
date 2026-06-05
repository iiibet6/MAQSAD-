import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme/app_theme.dart';
import '../models/restaurant_model.dart';
import '../l10n/app_localizations.dart';
import 'restaurant_menu_screen.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _commentController = TextEditingController();

  int _currentImage = 0;
  int _userRating = 0;

  List<String> get _images {
    return [
      widget.restaurant.image,
      ...widget.restaurant.gallery,
    ];
  }

  Future<void> _openMap() async {
    final query = Uri.encodeComponent('${widget.restaurant.name} حائل');
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _contactPlace() async {
    final uri = Uri.parse('tel:');
    await launchUrl(uri);
  }

  void _sharePlace() {
    Share.share('${widget.restaurant.name} - ${widget.restaurant.subtitle}');
  }

  void _sendComment() {
    final t = AppLocalizations.of(context)!;

    if (_commentController.text.trim().isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          t.commentSent,
          style: AppTextStyles.body.copyWith(color: Colors.white),
        ),
      ),
    );

    _commentController.clear();
  }

  Future<void> _saveRating(int rating) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    final snapshot = await userRef.get();
    final data = snapshot.data() ?? {};

    List ratings = data['ratings'] ?? [];

    ratings.removeWhere(
      (item) => item['title'] == widget.restaurant.name,
    );

    ratings.add({
      'title': widget.restaurant.name,
      'type': widget.restaurant.type,
      'category': widget.restaurant.category,
      'tags': widget.restaurant.tags.join(','),
      'rating': rating,
    });

    await userRef.update({
      'ratings': ratings,
    });
  }

  void _showCommentSheet() {
    final t = AppLocalizations.of(context)!;showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Directionality(
            textDirection: Directionality.of(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    width: 55,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  t.writeComment,
                  style: AppTextStyles.headline2,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _commentController,
                  maxLines: 4,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.body,
                  decoration: InputDecoration(
                    hintText: t.commentHint,
                    filled: true,
                    fillColor: AppColors.background,
                    hintStyle: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: AppColors.accent,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _sendComment();
                    },
                    child: Text(t.send),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 330,
              pinned: true,
              backgroundColor: AppColors.background,
              foregroundColor: AppColors.textPrimary,
              iconTheme: const IconThemeData(
                color: AppColors.textPrimary,
              ),
              flexibleSpace: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _images.length,
                    onPageChanged: (index) {
                      setState(() => _currentImage = index);
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _images[index],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.background,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    },
                  ),
                  IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.20),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.28),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _images.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentImage == index ? 18 : 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: _currentImage == index
                                  ? AppColors.accent
                                  : Colors.white.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -28),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(34),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Container(width: 55,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.divider,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        widget.restaurant.name,
                        style: AppTextStyles.headline1,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.restaurant.subtitle,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${widget.restaurant.googleRating.toStringAsFixed(1)}  ',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const _RatingStars(size: 21),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: _showCommentSheet,
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.divider),
                              ),
                              child: const Icon(
                                Icons.mode_comment_outlined,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _InfoChip(
                        icon: Icons.access_time_rounded,
                        text: t.workingHours,
                      ),
                      const SizedBox(height: 26),
                      Text(
                        t.aboutPlace,
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${widget.restaurant.name} ${widget.restaurant.subtitle}',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.bodyLarge.copyWith(
                          height: 1.8,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        t.ratePlace,
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          5,
                          (index) => GestureDetector(
                            onTap: () async {
                              final rating = index + 1;

                              setState(() {
                                _userRating = rating;
                              });

                              await _saveRating(rating);ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.primary,
                                  content: Text(
                                    '${t.ratingSaved}: $rating ${t.stars}',
                                    style: AppTextStyles.body.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              index < _userRating
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              color: AppColors.accent,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        t.contactPlace,
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _ActionButton(
                              icon: Icons.phone_rounded,
                              label: t.call,
                              onTap: _contactPlace,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _ActionButton(
                              icon: Icons.menu_book_rounded,
                              label: t.menu,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RestaurantMenuScreen(
                                      restaurant: widget.restaurant,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _ActionButton(
                              icon: Icons.share_rounded,
                              label: t.share,
                              onTap: _sharePlace,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _ActionButton(
                              icon: Icons.location_on_rounded,
                              label: t.location,
                              onTap: _openMap,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  final double size;

  const _RatingStars({
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star_rounded, color: AppColors.accent, size: size),
        Icon(Icons.star_rounded, color: AppColors.accent, size: size),
        Icon(Icons.star_rounded, color: AppColors.accent, size: size),
        Icon(Icons.star_rounded, color: AppColors.accent, size: size),
        Icon(Icons.star_half_rounded, color: AppColors.accent, size: size),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({
    required this.icon,
    required this.text,
  });@override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            icon,
            color: AppColors.primary,
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 26,
            ),
            const SizedBox(height: 7),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}