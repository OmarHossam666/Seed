/// Base interface for all repositories in the application
abstract class IRepository {
  /// This is a marker interface for all repositories
}

/// Base interface for preferences/storage repositories
abstract class IPreferencesRepository extends IRepository {
  /// Set a boolean value for the given key
  Future<bool> setBool(String key, bool value);

  /// Get a boolean value for the given key
  bool getBool(String key, {bool defaultValue = false});

  /// Set a string value for the given key
  Future<bool> setString(String key, String value);

  /// Get a string value for the given key
  String? getString(String key);

  /// Set an integer value for the given key
  Future<bool> setInt(String key, int value);

  /// Get an integer value for the given key
  int? getInt(String key);

  /// Remove a value for the given key
  Future<bool> remove(String key);

  /// Clear all stored values
  Future<bool> clear();

  /// Check if a key exists
  bool containsKey(String key);
}
