class FastCache {
  static final Map<String, Object?> _cache = {};

  static void add<T>(String key, T value) => _cache.addAll({key: value});

  static void remove(String key) => _cache.remove(key);

  static bool has(String key) => _cache.containsKey(key);

  static T get<T>(String key) => _cache.putIfAbsent(key, () => null) as T;

  static void clear() => _cache.clear();
}
