import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopzonee/view/subcategorypage.dart';
import 'package:shopzonee/view_model/category_viewmodel.dart';

class DiscoverPage extends StatefulWidget {
  DiscoverPage({
    super.key,
  });

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryViewmodel>().fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = context.watch<CategoryViewmodel>();
    final isLoading = categoryViewModel.isLoading;
    final categories = categoryViewModel.categories;

    // List of image paths
    final List<String> imagePaths = [
      'assets/images/Frame 33149.png',

      'assets/images/Frame 33123.png',

      'assets/images/Frame 33124.png',
      'assets/images/Frame 33148.png',
      // Add more images if needed
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu_sharp),
        title: Text('Discover'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // Search bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 231, 223, 223)
                              .withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                          ),
                        ),
                      ),
                    ),
                    // List of items based on categories
                    SizedBox(height: 20),
                    ...categories.asMap().entries.map((entry) {
                      int index = entry.key;
                      var category = entry.value;
                      String imagePath = index < imagePaths.length
                          ? imagePaths[index]
                          : imagePaths.last;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubcategoryScreen(
                                categoryId: category.id!,
                              ),
                            ),
                          );
                        },
                        child: _buildImageWithText(
                            imagePath, category.categoryname ?? 'Category'),
                      );
                    }).toList(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildImageWithText(String imagePath, String text) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imagePath),
        ),
        Positioned(
          bottom: 50,
          left: 30,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
