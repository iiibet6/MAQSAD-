import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';


class RestaurantMenuScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantMenuScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantMenuScreen> createState() =>
      _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState
    extends State<RestaurantMenuScreen> {

  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory =
        widget.restaurant.categories.first;
  }

  @override
  Widget build(BuildContext context) {

    final filteredItems = widget.restaurant.menu
        .where((item) =>
            item.category == selectedCategory)
        .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          title: Text(widget.restaurant.name),
          centerTitle: true,
        ),

        body: Column(
          children: [

            /// categories
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    widget.restaurant.categories.length,
                itemBuilder: (context, index) {

                  final category =
                      widget.restaurant.categories[index];

                  final selected =
                      category == selectedCategory;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },

                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),

                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selected
                                ? Colors.black
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),

                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            color: selected
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// items
            Expanded(
              child: GridView.builder(
                padding:
                    const EdgeInsets.all(16),

                itemCount: filteredItems.length,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),

                itemBuilder: (context, index) {

                  final item =
                      filteredItems[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.08),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.end,

                      children: [

                        Expanded(
                          child: Stack(
                            children: [

                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.vertical(
                                  top: Radius.circular(18),
                                ),

                                child: Image.asset(
                                  item.image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned(
                                left: 10,
                                bottom: 10,

                                child: Container(
                                  width: 40,
                                  height: 40,

                                  decoration:
                                      BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),

                                  child: const Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.all(10),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.end,

                            children: [

                              Text(
                                item.name,
                                textAlign:
                                    TextAlign.right,

                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                '${item.price} ر.س',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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