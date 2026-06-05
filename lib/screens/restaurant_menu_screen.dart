import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/restaurant_model.dart';
import '../services/cart_service.dart';
import 'cart_screen.dart';

class RestaurantMenuScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantMenuScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  late String selectedCategory;

  List<String> get categories => [
        'عروض مقصد',
        ...widget.restaurant.categories,
      ];

  List<MenuItem> get maqsedOffers {
    final menu = widget.restaurant.menu;
    if (menu.isEmpty) return [];

    return [
      MenuItem(
        name: 'عرض مقصد الخاص',
        price: '25',
        image: widget.restaurant.image,
        category: 'عروض مقصد',
      ),
      MenuItem(
        name: 'خصم لعملاء مقصد',
        price: '15',
        image: widget.restaurant.image,
        category: 'عروض مقصد',
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = 'عروض مقصد';
    CartService.setRestaurant(widget.restaurant.name);
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(
          restaurantName: widget.restaurant.name,
        ),
      ),
    );
  }

  void _addToCart(MenuItem item) {
    CartService.addToCart(item);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          'تمت إضافة ${item.name} إلى السلة',
          style: AppTextStyles.body.copyWith(color: Colors.white),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = selectedCategory == 'عروض مقصد'
        ? maqsedOffers
        : widget.restaurant.menu
            .where((item) => item.category == selectedCategory)
            .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            widget.restaurant.name,
            style: AppTextStyles.headline2,
          ),
          centerTitle: true,
          backgroundColor: AppColors.background,
          elevation: 0,
          foregroundColor: AppColors.textPrimary,
          actions: [
            ValueListenableBuilder(
              valueListenable: CartService.cartItems,
              builder: (context, cartItems, _) {
                final count = cartItems.fold<int>(
                  0,
                  (sum, item) => sum + item.quantity,
                );return Stack(
                  children: [
                    IconButton(
                      onPressed: _openCart,
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    if (count > 0)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 62,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: categories.map((category) {
                    final selected = category == selectedCategory;

                    return InkWell(
                      onTap: () {
                        if (selectedCategory == category) return;

                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (selectedCategory != 'عروض مقصد')
              _MaqsedBanner(
                onTap: () {
                  setState(() {
                    selectedCategory = 'عروض مقصد';
                  });
                },
              ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  mainAxisExtent: 260,
                ),
                itemBuilder: (context, index) {
                  final item = filteredItems[index];return _MenuCard(
                    item: item,
                    isOffer: selectedCategory == 'عروض مقصد',
                    onAdd: () => _addToCart(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaqsedBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _MaqsedBanner({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.navBarBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 15),
            label: const Text('عرض العروض'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              textStyle: AppTextStyles.button,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'عروض مقصد',
                style: AppTextStyles.headline2.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'عروض حصرية لعملاء مقصد',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.local_offer_rounded,
            color: AppColors.accent,
            size: 34,
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final MenuItem item;
  final bool isOffer;
  final VoidCallback onAdd;

  const _MenuCard({
    required this.item,
    required this.isOffer,
    required this.onAdd,
  });@override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOffer ? AppColors.navBarBg : AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isOffer ? AppColors.divider : AppColors.divider,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  child: Image.asset(
                    item.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.background,
                      child: Icon(
                        isOffer
                            ? Icons.local_offer_rounded
                            : Icons.restaurant_rounded,
                        color: isOffer ? AppColors.accent : AppColors.primary,
                        size: 44,
                      ),
                    ),
                  ),
                ),
                if (isOffer)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'حصري',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        isOffer ? Icons.redeem_rounded : Icons.add,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.name,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text('${item.price} ر.س',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}