class ThrottleFilter<T> {
  DateTime lastEventDateTime = DateTime.now();
  final Duration duration;

  ThrottleFilter(this.duration);

  bool call(T e) {
    final now = DateTime.now();
    if (now.difference(lastEventDateTime) > duration) {
      lastEventDateTime = now;
      return true;
    }
    return false;
  }
}
