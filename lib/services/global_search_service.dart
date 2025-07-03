class GlobalSearchService {
  static final GlobalSearchService _instance = GlobalSearchService._internal();

  factory GlobalSearchService() => _instance;

  GlobalSearchService._internal();

  final List<String> _history = [];

  List<String> get history => List.unmodifiable(_history);

  void add(String query) {
    if (query.trim().isEmpty) return;
    _history.remove(query); // Remove duplicates
    _history.insert(0, query.trim());
  }

  void clear() => _history.clear();
}
