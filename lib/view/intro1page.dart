import 'package:flutter/material.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/view/signuppage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shopzonee/widget/button.dart';

class Intro1page extends StatefulWidget {
  const Intro1page({super.key});

  @override
  _Intro1pageState createState() => _Intro1pageState();
}

class _Intro1pageState extends State<Intro1page> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: [
              _buildPageContent(
                title: 'Discover something new',
                subtitle: 'Special new arrivals just for you',
                imagePath: 'assets/images/kisspng-model-fashion-trousers-leather-european-and-american-fashion-beautiful-models-5aa8c749eb0b75 1.png',
              ),
              _buildPageContent(
                title: 'Find Your Style',
                subtitle: 'Trendy collections available now',
                imagePath: 'assets/images/Group 33078.png',
              ),
              _buildPageContent(
                title: 'Get the Best Deals',
                subtitle: 'Exclusive discounts for you',
                imagePath: 'assets/images/Frame 33091.png',
              ),
            ],
          ),
        
          Positioned(
            bottom: 190,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  spacing: 16,
                  activeDotColor: Colors.black,
                ),
              ),
            ),
          ),
         
          if (_currentPageIndex == 2)
            Positioned(
              bottom: 80,
              left: 65,
              child: CustomButton(
                text: 'Shopping now',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signupPage);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPageContent({required String title, required String subtitle, required String imagePath}) {
    return Stack(
      children: [
  
        Positioned(
          top: 80,
          left: 20,
          right: 20,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          top: 120,
          left: 20,
          right: 20,
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Main container at the bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 350,
            width: 500,
            color: const Color(0xff464447),
          ),
        ),
       
        Positioned(
          bottom: 250,
          left: 70,
          right: 70,
          child: Container(
            width: 300,
            height: 380,
            decoration: BoxDecoration(
              color: const Color(0xffE7E8E9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Image.asset(
                    imagePath,
                    height: 330,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
