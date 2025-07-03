import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  String _query = '';
  List<String> _history = [];

  String get query => _query;
  List<String> get history => List.unmodifiable(_history);

  void updateQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }

  void submitQuery() {
    if (_query.trim().isEmpty) return;
    _history.insert(0, _query.trim());
    _query = '';
    notifyListeners();
  }

  void clearQuery() {
    _query = '';
    notifyListeners();
  }
}
