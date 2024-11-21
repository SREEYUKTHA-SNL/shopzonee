import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/model/subcatmodel.dart';
import 'package:shopzonee/view/subcatproductspage.dart';
import 'package:shopzonee/view_model/fetchproduct_viewmodel.dart';

class SubcategoryScreen extends StatefulWidget {
  final int categoryId;

  const SubcategoryScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  _SubcategoryScreenState createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch subcategories when the widget is initialized
    _fetchSubcategories();
  }

  void _fetchSubcategories() {
    print("Fetching subcategories for category ID: ${widget.categoryId}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<ProductProvider>(context, listen: false).fetchSubcategories(widget.categoryId);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Consumer<ProductProvider>(
  builder: (context, provider, child) {
    if (provider.isLoadings) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessages != null) {
      return Center(child: Text(provider.errorMessages!));
    }

    // Print the subcategoriesList to see if it's populated
    print("Displaying subcategories: ${provider.subcategoryData}");

    SubcategoryCategory? subcategories = provider.subcategoryData;

    if (subcategories == null) {
      return const Center(child: Text('No subcategories available.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: subcategories.data!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubcatproductPage(
                    categoryId: widget.categoryId,
                    subcategoryId: subcategories.data![index].id!,
                  ),
                ),
              );
            },
            child: SubcategoryCard(
              imageUrl: subcategories.data![index].subcategoryImage ?? '',
              subcategoryName: subcategories.data![index].subcategoryname ?? 'Unknown',
            ),
          );
        },
      ),
    );
  },
),

    );
  }
}

// Example SubcategoryCard widget
class SubcategoryCard extends StatelessWidget {
  final String imageUrl;
  final String subcategoryName;

  const SubcategoryCard({
    Key? key,
    required this.imageUrl,
    required this.subcategoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity, 
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error), 
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              subcategoryName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
