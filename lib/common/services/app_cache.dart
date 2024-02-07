import 'package:skillspro/features/profile/skills/skill.dart';

class AppCache {
  // Private constructor
  AppCache._privateConstructor();

  // Static instance variable
  static final AppCache _appCache = AppCache._privateConstructor();

  // Getter for the singleton instance
  factory AppCache() {
    return _appCache;
  }

  final Map<String, dynamic> _store = {};

  void save(String key, dynamic value) {
    _store[key] = value;
  }

  dynamic load(String key) {
    return _store[key];
  }


}
