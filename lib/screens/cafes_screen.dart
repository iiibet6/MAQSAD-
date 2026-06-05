import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme/app_theme.dart';
import '../models/restaurant_model.dart';
import 'restaurant_menu_screen.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';

class CafesScreen extends StatelessWidget {
  const CafesScreen({super.key});

  static const List<Restaurant> cafes = [
    Restaurant(
      name: 'ساكورا',
      description: 'لمسة يابانية في قلب حائل، يقدم ساكورا كافيه تجربة تجمع بين الأجواء الأنيقة والمشروبات المتنوعة، ليمنح زواره مكانًا مثاليًا للاسترخاء والاستمتاع بأوقاتهم',
      googleRating: 4.7,
      image: 'assets/images/sakura.jpeg',
      gallery: [
        'assets/images/sakura1.jpg',
        'assets/images/sakura2.jpg',
        'assets/images/sakura3.jpg',
      ],
      subtitle: 'قهوة مختصة ومخبوزات',
      type: 'مقاهي',
      category: 'قهوة مختصة',
      tags: ['مقاهي', 'قهوة', 'مختصة', 'مخبوزات', 'V60', 'هادئ', 'حلويات'],
      categories: ['القهوة', 'المشروبات الباردة', 'المخبوزات', 'البوكسات'],
      menu: [
        MenuItem(name: 'قهوة اليوم حار', price: '8', image: 'assets/images/sakura_hot_coffee.png', category: 'القهوة'),
        MenuItem(name: 'قهوة اليوم بارد', price: '8', image: 'assets/images/sakura_ice_coffee.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'V60 حار', price: '16', image: 'assets/images/sakura_v60.png', category: 'القهوة'),
        MenuItem(name: 'V60 بارد', price: '16', image: 'assets/images/sakura_ice_v60.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'أمريكانو حار', price: '14', image: 'assets/images/sakura_americano.png', category: 'القهوة'),
        MenuItem(name: 'فلات وايت', price: '14', image: 'assets/images/sakura_flatwhite.png', category: 'القهوة'),
        MenuItem(name: 'ميني كروسان لوز', price: '7', image: 'assets/images/sakura_croissant.png', category: 'المخبوزات'),
        MenuItem(name: 'بوكس كركديه كبير ٢ لتر', price: '69', image: 'assets/images/sakura_karkadeh_box.png', category: 'البوكسات'),
      ],
    ),
    Restaurant(
      name: 'سنس',
      googleRating: 4.7,
      image: 'assets/images/sns.jpeg',
      gallery: [
        'assets/images/sns1.jpg',
        'assets/images/sns2.jpg',
        'assets/images/sns3.jpg',
      ],
      subtitle: 'قهوة وحلويات وبوكسات',
      type: 'مقاهي',
      category: 'قهوة وحلويات',
      description: 'وجهة عصرية لعشاق القهوة في حائل، يقدم سنس أجواءً مريحة وتجربة مميزة تجمع بين المشروبات المتنوعة والحلويات، ليكون مكانًا مناسبًا للاسترخاء واللقاءات اليومية',
      tags: ['مقاهي', 'قهوة', 'حلويات', 'بوكسات', 'ماتشا', 'فرنش توست', 'كوفي'],
      categories: ['العروض', 'القهوة', 'الحلويات', 'البوكسات'],
      menu: [
        MenuItem(name: 'كيكة التمر بالبيكان + بوكس قهوة اليوم ٢ لتر', price: '89', image: 'assets/images/sns_date_cake_offer.png', category: 'العروض'),
        MenuItem(name: 'بوكس محاصيل سنس', price: '129', image: 'assets/images/sns_crop_box.png', category: 'البوكسات'),
        MenuItem(name: 'سويت اوفر', price: '28', image: 'assets/images/sns_sweet_over.png', category: 'الحلويات'),
        MenuItem(name: 'فرنش توست مليت اوفر', price: '25', image: 'assets/images/sns_french_toast.png', category: 'الحلويات'),
        MenuItem(name: 'بوكس قهوة اليوم', price: '49', image: 'assets/images/sns_coffee_box.png', category: 'البوكسات'),
        MenuItem(name: 'بوكس ماتشا بارد', price: '55', image: 'assets/images/sns_matcha_box.png', category: 'البوكسات'),
        MenuItem(name: 'اسبرسو', price: '10', image: 'assets/images/sns_espresso.png', category: 'القهوة'),
        MenuItem(name: 'أمريكانو', price: '13', image: 'assets/images/sns_americano.png', category: 'القهوة'),
      ],
    ),
    Restaurant(
      name: 'إلتون',
      googleRating: 4.7,
      image: 'assets/images/ltone.jpeg',
      gallery: [
        'assets/images/ltone1.jpg',
        'assets/images/ltone2.jpg',
        'assets/images/ltone3.jpg',
      ],
      subtitle: 'محمصة وقهوة مختصة',
      type: 'مقاهي',
      category: 'قهوة مختصة',
      description: 'من رواد القهوة المختصة في حائل، تتميز إلتون باختيار محاصيل القهوة بعناية وتقديم تجربة احترافية تعكس جودة التحميص وشغف القهوة المختصة',
      tags: ['مقاهي', 'قهوة', 'مختصة', 'محمصة', 'محاصيل', 'V60', 'بوكسات'],
      categories: ['القهوة', 'المحاصيل', 'البوكسات'],
      menu: [
        MenuItem(name: 'قهوة اليوم', price: '0', image: 'assets/images/ltone_daily.png', category: 'القهوة'),
        MenuItem(name: 'V60', price: '0', image: 'assets/images/ltone_v60.png', category: 'القهوة'),
        MenuItem(name: 'كولومبيا لافريسا', price: '0', image: 'assets/images/ltone_colombia.png', category: 'المحاصيل'),
        MenuItem(name: 'إندونيسيا وانويا', price: '0', image: 'assets/images/ltone_indonesia.png', category: 'المحاصيل'),
        MenuItem(name: 'البوكس الفاكهي', price: '0', image: 'assets/images/ltone_fruity_box.png', category: 'البوكسات'),
      ],
    ),
    Restaurant(
      name: 'ناف | NAF',
      googleRating: 4.7,
      image: 'assets/images/naf.png',
      gallery: [
        'assets/images/naf1.jpg',
        'assets/images/naf2.jpg',
        'assets/images/naf3.jpg',
      ],
      subtitle: 'قهوة مختصة ',
      type: 'مقاهي',
      category: 'قهوة مختصة',
      description:
      'وجهة القهوة المختصة في حائل، يقدم تجربة مميزة تجمع بين جودة المشروبات والأجواء العصرية الهادئة ليكون مكاناً مثالياً للاسترخاء واللقاءات الاجتماعية.',

      tags: ['مقاهي', 'قهوة', 'مختصة', 'لاتيه', 'بارد', 'منتجات'],
      categories: ['القهوة', 'المشروبات الباردة', 'المنتجات'],
      menu: [
        MenuItem(name: 'قهوة اليوم', price: '0', image: 'assets/images/naf_daily.png', category: 'القهوة'),
        MenuItem(name: 'لاتيه', price: '0', image: 'assets/images/naf_latte.png', category: 'القهوة'),
        MenuItem(name: 'آيس لاتيه', price: '0', image: 'assets/images/naf_ice_latte.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'NAF Okeanos Bottle 500ml', price: '0', image: 'assets/images/naf_bottle.png', category: 'المنتجات'),
      ],
    ),
    Restaurant(
      name: 'ساوث',
      googleRating: 4.7,
      image: 'assets/images/south.png',
      gallery: [
        'assets/images/south1.jpg',
        'assets/images/south2.jpg',
        'assets/images/south3.jpg',
      ],
      subtitle: 'قهوة وحلويات',
      type: 'مقاهي',
      category: 'قهوة وحلويات',
      description: ' يقدم ساوث تجربة عصرية تجمع بين القهوة المختصة والاهتمام بأدق التفاصيل، ليمنح زواره لحظات ممتعة في أي وقت من اليوم.ß',
      tags: ['مقاهي', 'قهوة', 'لاتيه', 'سبانش لاتيه', 'حلويات', 'كوكيز'],
      categories: ['القهوة', 'المشروبات الباردة', 'الحلويات'],
      menu: [
        MenuItem(name: 'أمريكانو', price: '0', image: 'assets/images/south_americano.png', category: 'القهوة'),
        MenuItem(name: 'لاتيه', price: '0', image: 'assets/images/south_latte.png', category: 'القهوة'),
        MenuItem(name: 'آيس سبانش لاتيه', price: '0', image: 'assets/images/south_spanish.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'كوكيز', price: '0', image: 'assets/images/south_cookies.png', category: 'الحلويات'),
      ],
    ),
    Restaurant(
      name: 'رواية',
      googleRating: 4.7,
      image: 'assets/images/riwaya.png',
      gallery: [
        'assets/images/riwaya1.jpg',
        'assets/images/riwaya2.jpg',
        'assets/images/riwaya3.jpg',
      ],
      subtitle: 'قهوة وأجواء هادئة',
      type: 'مقاهي',
      category: 'قهوة هادئة',
      description: 'حيث تبدأ الحكايات مع فنجان قهوة، يوفر رواية أجواءً هادئة وتجربة دافئة تجمع بين القهوة المختصة والجلسات المريحة لعشاق القراءة واللقاءات الهادئة.',
      tags: ['مقاهي', 'قهوة', 'هادئ', 'جلسات', 'كورتادو', 'كيك', 'قراءة'],
      categories: ['القهوة', 'المشروبات الباردة', 'الحلويات'],
      menu: [
        MenuItem(name: 'قهوة اليوم', price: '0', image: 'assets/images/riwaya_daily.png', category: 'القهوة'),
        MenuItem(name: 'كورتادو', price: '0', image: 'assets/images/riwaya_cortado.png', category: 'القهوة'),
        MenuItem(name: 'آيس لاتيه', price: '0', image: 'assets/images/riwaya_ice_latte.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'كيك', price: '0', image: 'assets/images/riwaya_cake.png', category: 'الحلويات'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          title: Text(
            t.cafes,
            style: AppTextStyles.headline2,
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cafes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final cafe = cafes[index];

            return _CafeCard(
              cafe: cafe,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CafeDetailsScreen(cafe: cafe),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _CafeCard extends StatelessWidget {
  final Restaurant cafe;
  final VoidCallback onTap;

  const _CafeCard({
    required this.cafe,
    required this.onTap,
  });

  Future<void> _toggleFavorite(List<Map<String, String>> favs) async {
    final isFav = favs.any((item) => item['title'] == cafe.name);

    if (isFav) {
      await FavoritesService.removeFavorite(cafe.name);
    } else {
      await FavoritesService.addFavorite({
        'title': cafe.name,
        'image': cafe.image,
        'subtitle': cafe.subtitle,
        'type': cafe.type,
        'category': cafe.category,
        'tags': cafe.tags.join(','),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.divider),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.07),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      cafe.image,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 88,
                        height: 88,
                        color: AppColors.background,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: ValueListenableBuilder<List<Map<String, String>>>(
                      valueListenable: FavoritesService.favorites,
                      builder: (context, favs, _) {
                        final isFav = favs.any(
                          (item) => item['title'] == cafe.name,
                        );

                        return GestureDetector(
                          onTap: () => _toggleFavorite(favs),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.surface.withOpacity(0.92),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.10),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              size: 18,
                              color: isFav
                                  ? AppColors.deleteRed
                                  : AppColors.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      cafe.name,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cafe.subtitle,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          cafe.googleRating.toString(),
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.accent,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CafeDetailsScreen extends StatefulWidget {
  final Restaurant cafe;

  const CafeDetailsScreen({
    super.key,
    required this.cafe,
  });

  @override
  State<CafeDetailsScreen> createState() => _CafeDetailsScreenState();
}

class _CafeDetailsScreenState extends State<CafeDetailsScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _commentController = TextEditingController();

  int _currentImage = 0;
  int _userRating = 0;

  List<String> get _images {
    return [
      widget.cafe.image,
      ...widget.cafe.gallery,
    ];
  }

  Future<void> _openMap() async {
    final query = Uri.encodeComponent('${widget.cafe.name} حائل');
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
    Share.share('${widget.cafe.name} - ${widget.cafe.subtitle}');
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

    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    final snapshot = await userRef.get();

    final data = snapshot.data() ?? {};

    List ratings = data['ratings'] ?? [];

    ratings.removeWhere(
      (item) => item['title'] == widget.cafe.name,
    );

    ratings.add({
      'title': widget.cafe.name,
      'type': widget.cafe.type,
      'category': widget.cafe.category,
      'tags': widget.cafe.tags.join(','),
      'rating': rating,
    });

    await userRef.update({
      'ratings': ratings,
    });
  }

  void _showCommentSheet() {
    final t = AppLocalizations.of(context)!;

    showModalBottomSheet(
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
    final t = AppLocalizations.of(context)!;

    return Directionality(
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
                        widget.cafe.name,
                        style: AppTextStyles.headline1,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.cafe.subtitle,
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
      widget.cafe.googleRating.toStringAsFixed(1),
      style: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
    ),
    const SizedBox(width: 6),
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
  widget.cafe.description.isNotEmpty
      ? widget.cafe.description
      : widget.cafe.subtitle,
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

                              await _saveRating(rating);

                              ScaffoldMessenger.of(context).showSnackBar(
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
                                      restaurant: widget.cafe,
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
  });

  @override
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