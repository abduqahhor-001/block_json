import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../blocs/product_bloc.dart';

class SearchSortBar extends StatefulWidget {
  const SearchSortBar({super.key});

  @override
  State<SearchSortBar> createState() => _SearchSortBarState();
}

class _SearchSortBarState extends State<SearchSortBar> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSort = "title_asc";

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(14);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: borderRadius,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search products...",
                  hintStyle: const TextStyle(fontSize: 14),
                  prefixIcon: const Icon(IconlyLight.search, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                onChanged: (query) {
                  context.read<ProductBloc>().add(SearchProductsEvent(query));
                },
              ),
            ),
          ),




        ],
      ),
    );
  }
}
