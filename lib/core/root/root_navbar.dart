import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../features/product/data/models/product_model.dart';
import '../../features/product/presentation/screens/add_product_screen.dart';
import '../../features/product/presentation/screens/product_list_screen.dart';
import '../../features/product/presentation/screens/update_product_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  // Sample product to test update/delete pages from navbar
  final ProductModel dummyProduct = ProductModel(
    id: 1,
    title: 'Dummy Product',
    description: 'Demo for testing',
    price: 99.99,
    thumbnail: '',
    rating: 4.5,
    category: 'demo',
    brand: 'DemoBrand',
    images: [],
  );

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const ProductListScreen(),
      const AddProductScreen(),
      UpdateProductPage(product: dummyProduct),

    ];
  }

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(IconlyLight.plus), label: "Add"),
    BottomNavigationBarItem(icon: Icon(IconlyLight.edit), label: "Update"),
    BottomNavigationBarItem(icon: Icon(IconlyLight.delete), label: "Delete"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: _navItems,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }
}
