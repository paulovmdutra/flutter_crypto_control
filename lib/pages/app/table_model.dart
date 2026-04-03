// Modelo TableModel para gerenciar dados
import 'package:flutter/material.dart';

class TableModel<E> extends ChangeNotifier {
  int pageSize = 10;
  int currentPage = 0;

  List<E> items = [];
  List<E> filteredResults = [];
  Set<int> selectedIndexes = {};

  TableModel({required List<E> initialItems}) {
    items = initialItems;
    filteredResults = List.from(items);
  }

  void add(E item) {
    items.add(item);
    _refreshFiltered();
  }

  void addItem(E newItem) {
    items.add(newItem);
    notifyListeners();
  }

  void update(List<E> newItems) {
    items = newItems;
    _refreshFiltered();
  }

  void remove(E item) {
    items.remove(item);
    _refreshFiltered();
  }

  void removeAt(int index) {
    items.removeAt(index);
    _refreshFiltered();
  }

  void removeSelected() {
    selectedIndexes.toList()
      ..sort((b, a) => a.compareTo(b))
      ..forEach((index) {
        if (index >= 0 && index < items.length) {
          items.removeAt(index);
        }
      });
    clearSelection();
    _refreshFiltered();
  }

  void clear() {
    items.clear();
    filteredResults.clear();
    selectedIndexes.clear();
    notifyListeners();
  }

  void selectRow(int index) {
    selectedIndexes.add(index);
    notifyListeners();
  }

  void unselectRow(int index) {
    selectedIndexes.remove(index);
    notifyListeners();
  }

  void toggleRowSelection(int index) {
    if (selectedIndexes.contains(index)) {
      unselectRow(index);
    } else {
      selectRow(index);
    }
  }

  void clearSelection() {
    selectedIndexes.clear();
    notifyListeners();
  }

  Future<void> filterBy(bool Function(E item) predicate) async {
    filteredResults = items.where(predicate).toList();
    notifyListeners();
  }

  void resetFilter() {
    filteredResults = List.from(items);
    notifyListeners();
  }

  void _refreshFiltered() {
    filteredResults = List.from(items);
    notifyListeners();
  }

  List<E> get paginatedRows {
    final start = currentPage * pageSize;
    final end = (start + pageSize).clamp(0, items.length);
    return items.sublist(start, end);
  }

  void nextPage() {
    if ((currentPage + 1) * pageSize < items.length) {
      currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      notifyListeners();
    }
  }
}
