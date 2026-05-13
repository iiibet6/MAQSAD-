import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../services/cart_service.dart';

class CartScreen extends StatefulWidget {
  final String restaurantName;

  const CartScreen({
    super.key,
    required this.restaurantName,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? orderCode;

  void _generateCode() {
    final now = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      orderCode = 'MQSAD-${now.toString().substring(7)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سلة مقصد'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: CartService.cartItems,
          builder: (context, cartItems, _) {
            if (cartItems.isEmpty) {
              return const Center(
                child: Text('السلة فارغة'),
              );
            }

            final qrData =
                'MAQSAD|${widget.restaurantName}|${orderCode ?? "NO_CODE"}|TOTAL:${CartService.totalPrice.toStringAsFixed(2)}';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    widget.restaurantName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                cartItem.item.image,
                                width: 58,
                                height: 58,
                                fit: BoxFit.cover,
                                errorBuilder: (_,__ , ___) => Container(
                                  width: 58,
                                  height: 58,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    cartItem.item.name,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),const SizedBox(height: 6),
                                  Text(
                                    '${cartItem.item.price} ر.س × ${cartItem.quantity}',
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                CartService.removeFromCart(cartItem.item);
                              },
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7EFE8),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'الإجمالي: ${CartService.totalPrice.toStringAsFixed(2)} ر.س',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B4024),
                          ),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton.icon(
                          onPressed: _generateCode,
                          icon: const Icon(Icons.qr_code_2_rounded),
                          label: const Text('إنشاء كود مقصد'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8A5A35),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),if (orderCode != null) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 14,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'اعرض هذا الكود للكاشير',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 14),
                          QrImageView(
                            data: qrData,
                            size: 190,
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            orderCode!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'خصم خاص لعملاء مقصد',
                            style: TextStyle(
                              color: Color(0xFF6B4024),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}