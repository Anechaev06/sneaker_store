import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sneaker_store/widgets/sneaker_details.dart';
import '../models/sneaker_model.dart';

class SneakerDetailsPanel extends StatelessWidget {
  final Sneaker sneaker;
  final PageController pageController = PageController();

  SneakerDetailsPanel({super.key, required this.sneaker});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImageSlider(context),
          _buildPageIndicator(),
          SneakerDetails(sneaker: sneaker),
        ],
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: PageView.builder(
          controller: pageController,
          itemCount: sneaker.images.length,
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: sneaker.images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return SmoothPageIndicator(
      controller: pageController,
      count: sneaker.images.length,
      effect: const WormEffect(
        dotColor: Colors.grey,
        activeDotColor: Colors.blue,
        dotHeight: 8,
        dotWidth: 8,
      ),
    );
  }
}
