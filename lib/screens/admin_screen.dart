import 'package:flutter/material.dart';
import 'package:sneaker_store/screens/pages/edit_sneaker_page.dart';
import 'package:sneaker_store/screens/pages/new_sneaker_page.dart';
import '../constants/colors.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageIndex = ValueNotifier<int>(0);

  void _changePage(int index) {
    _currentPageIndex.value = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButtonRow(
              currentIndex: _currentPageIndex,
              onPageSelected: _changePage,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  kBottomNavigationBarHeight -
                  MediaQuery.of(context).padding.top,
              child: ValueListenableBuilder(
                valueListenable: _currentPageIndex,
                builder: (context, value, child) {
                  return PageView(
                    controller: _pageController,
                    onPageChanged: _changePage,
                    children: const [
                      NewSneakerPage(),
                      EditSneakerPage(),
                    ],
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

class ToggleButtonRow extends StatelessWidget {
  final ValueNotifier<int> currentIndex;
  final ValueChanged<int> onPageSelected;

  const ToggleButtonRow({
    super.key,
    required this.currentIndex,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ToggleButton(
          text: 'Upload',
          index: 0,
          currentIndex: currentIndex,
          onPressed: () => onPageSelected(0),
        ),
        ToggleButton(
          text: 'Edit',
          index: 1,
          currentIndex: currentIndex,
          onPressed: () => onPageSelected(1),
        ),
      ],
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String text;
  final int index;
  final ValueNotifier<int> currentIndex;
  final VoidCallback onPressed;

  const ToggleButton({
    super.key,
    required this.text,
    required this.index,
    required this.currentIndex,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, value, child) {
        final isSelected = index == value;

        return ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              isSelected ? primaryColor : Colors.grey,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? secondColor : Colors.black,
            ),
          ),
        );
      },
    );
  }
}
