import 'package:flutter/material.dart';

class ListModel<E> extends ChangeNotifier {
  List<E> items = List.empty();
  List<E> filteredResults = List.empty();

  ListModel({required this.items});

  void add(E item) {
    items.add(item);
    _refreshFiltered();
  }

  void init() {
    filteredResults = items;
  }

  void update(List<E> elements) {
    items = elements;
    notifyListeners();
  }

  void remove(E element) {
    items.remove(element);
    notifyListeners();
  }

  void removeAt(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }

  Future<void> filterBy(bool Function(E item) predicate) async {
    filteredResults = items.where(predicate).toList();
    notifyListeners();
  }

  Future<List<E>> filter(String value) async {
    filteredResults = items.where((item) {
      return item.toString().toLowerCase().contains(value.toLowerCase());
    }).toList();
    notifyListeners();
    return filteredResults;
  }

  Future<void> resetFilter() async {
    filteredResults = List.from(items);
    notifyListeners();
  }

  void _refreshFiltered() {
    filteredResults = List.from(items);
    notifyListeners();
  }
}
