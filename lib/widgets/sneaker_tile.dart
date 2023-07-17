import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../services/favorites_service.dart';
import '../models/sneaker_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SneakerTile extends StatelessWidget {
  final Sneaker sneaker;

  const SneakerTile({super.key, required this.sneaker});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SneakerDetailsPanel(sneaker: sneaker),
      ),
      child: Consumer<FavoritesService>(
        builder: (context, favoritesService, child) => Card(
          elevation: 5,
          child: Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (_) => favoritesService.toggleFavorite(sneaker),
                  icon: favoritesService.isFavorite(sneaker)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  backgroundColor: Colors.red.shade400,
                  autoClose: true,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (sneaker.images.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        sneaker.images[0],
                        height: 100,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sneaker.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${sneaker.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SneakerDetailsPanel extends StatelessWidget {
  final Sneaker sneaker;

  const SneakerDetailsPanel({super.key, required this.sneaker});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Container(
      height: MediaQuery.of(context).size.height * .7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: PageView.builder(
                controller: pageController,
                itemCount: sneaker.images.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    sneaker.images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SmoothPageIndicator(
            controller: pageController, // added controller here
            count: sneaker.images.length,
            effect: const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.blue,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              sneaker.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Price: \$${sneaker.price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // Add more details as needed
        ],
      ),
    );
  }
}
