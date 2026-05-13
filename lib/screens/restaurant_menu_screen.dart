import 'package:flutter/material.dart';

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
  static const Color darkColor = Color(0xFF3F5F73);
  static const Color offerColor = Color(0xFF8A5A35);

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
        content: Text('تمت إضافة ${item.name} إلى السلة'),
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.restaurant.name),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
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
                      icon: const Icon(Icons.shopping_bag_outlined),
                    ),
                    if (count > 0)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: offerColor,
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
          borderRadius: BorderRadius.circular(12),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selected ? Colors.black : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            child: Center(
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.black : Colors.grey,
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
                  final item = filteredItems[index];

                  return _MenuCard(
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
  final VoidCallback onTap;const _MaqsedBanner({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7EFE8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 15),
            label: const Text('عرض العروض'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8A5A35),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          const Spacer(),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'عروض مقصد',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B4024),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'عروض حصرية لعملاء مقصد',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B4024),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.local_offer_rounded,
            color: Color(0xFF6B4024),
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOffer ? const Color(0xFFFFFAF5) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isOffer
            ? Border.all(
                color: const Color(0xFFE8D6C6),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
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
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    item.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: const Color(0xFFF7F7F7),
                      child: Icon(
                        isOffer
                            ? Icons.local_offer_rounded
                            : Icons.coffee_rounded,
                        color: isOffer
                            ? const Color(0xFF8A5A35)
                            : const Color(0xFF3F5F73),
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
                      decoration: BoxDecoration(color: const Color(0xFF8A5A35),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'حصري',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isOffer ? Icons.redeem_rounded : Icons.add,
                        color: Colors.black,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${item.price} ر.س',
                  style: const TextStyle(
                    fontSize: 14,
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