import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attira/services/products/firebase/_product_service.dart';

class SearchCategories extends StatefulWidget {
  const SearchCategories({super.key});

  @override
  _SearchCategoriesState createState() => _SearchCategoriesState();
}

class _SearchCategoriesState extends State<SearchCategories> {
  final FirebaseProductService _productService = FirebaseProductService();
  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();

    // Listen to changes in the search input
    _searchController.addListener(_filterCategories);
  }

  // Fetch categories from Firebase
  void _loadCategories() {
    _productService.getCategories().listen((categories) {
      setState(() {
        _allCategories = categories;
        _filteredCategories = categories;
      });
    });
  }

  // Filter categories based on search input
  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = _allCategories
          .where((category) =>
          category.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: theme.surface,
        statusBarIconBrightness: theme.brightness,
        systemNavigationBarColor: theme.surface,
        systemNavigationBarIconBrightness: theme.brightness));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back)),
                Expanded(
                  child: Container(
                    height: 55,
                    margin: EdgeInsets.only(right: 20, left: 5),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(
                                fontSize: 13, color: theme.onSurface),
                            decoration: InputDecoration(
                              hintText: 'Search Product Categories',
                              hintStyle: TextStyle(
                                color:
                                theme.onSurface.withOpacity(.5),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: _filteredCategories.isNotEmpty
                  ? ListView.builder(
                itemCount: _filteredCategories.length,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  final category = _filteredCategories[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: theme.primary.withOpacity(.1)
                    ),
                    child: ListTile(
                      title: Text(category.name),
                      onTap: () {

                      },
                    ),
                  );
                },
              )
                  : const Center(
                child: Text('No categories found'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
