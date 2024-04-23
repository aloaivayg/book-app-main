import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemSlideShow extends StatelessWidget {
  ItemSlideShow(
      {Key? key,
      required this.items,
      required this.width,
      required this.heigth,
      this.margin,
      this.selectedIndex = 0})
      : super(key: key);

  final List items;
  final double width;
  final double heigth;
  final EdgeInsetsGeometry? margin;
  final int? selectedIndex;

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (selectedIndex != -1) {
        _pageController.animateToPage(selectedIndex!,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });

    return Container(
      margin: margin,
      height: heigth,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: items
                .map((e) => Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              e.toString(),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.black,
                                    Colors.black45,
                                    Colors.black12,
                                    Colors.black.withOpacity(0)
                                  ])),
                        ),
                      ],
                    ))
                .toList(),
          ),
          Positioned(
              left: 30,
              bottom: 10,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: items.length,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 4,
                  dotWidth: 8,
                  dotHeight: 4,
                  activeDotColor: Colors.white,
                ),
                onDotClicked: (index) {
                  _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
              ))
        ],
      ),
    );
  }
}
