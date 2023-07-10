import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../services/favorites_service.dart';
import '../models/sneaker_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SneakerTile extends StatefulWidget {
  final Sneaker sneaker;

  const SneakerTile({super.key, required this.sneaker});

  @override
  State<SneakerTile> createState() => _SneakerTileState();
}

class _SneakerTileState extends State<SneakerTile> {
  late bool isFavorite;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoritesService().isFavorite(widget.sneaker);
    _pageController = PageController(); // Initialize the PageController
  }

  void _openSneakerDetailsPanel(Sneaker sneaker) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * .7,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  child: PageView.builder(
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
                count: sneaker.images.length,
                controller: _pageController,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openSneakerDetailsPanel(widget.sneaker);
      },
      child: Card(
        elevation: 5,
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(10),
                onPressed: (BuildContext context) {
                  setState(() {
                    isFavorite = !isFavorite;
                    if (isFavorite) {
                      FavoritesService().addToFavorites(widget.sneaker);
                    } else {
                      FavoritesService().removeFromFavorites(widget.sneaker);
                    }
                  });
                },
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                backgroundColor: Colors.red.shade400,
                autoClose: true,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    widget.sneaker.images[0],
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
                        widget.sneaker.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${widget.sneaker.price.toStringAsFixed(2)}",
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
    );
  }
}
