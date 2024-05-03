import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider extends ChangeNotifier {
  late Stream<QuerySnapshot> _stream;
  late String _selectedAge;
  late String _searchQuery;

  HomeProvider() {
    _selectedAge = '';
    _searchQuery = '';
    _stream = FirebaseFirestore.instance.collection("users").snapshots();
  }
  Stream<QuerySnapshot> get stream => _stream;

  String get selectedAge => _selectedAge;
  void setSelectedAge(option) {
    _selectedAge = option;
    notifyListeners();
  }

  String get searchQuery => _searchQuery;
  void setSearchQuery(query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Map> filterItems(List<Map> items) {
    if (searchQuery.isNotEmpty) {
      items = items
          .where((item) =>
              item['name']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item['age']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    if (selectedAge == 'Older') {
      items = items
          .where((item) => int.parse(item['age'].toString()) >= 60)
          .toList();
    } else if (selectedAge == 'Younger') {
      items = items
          .where((item) => int.parse(item['age'].toString()) <= 59)
          .toList();
    }

    return items;
  }
}
