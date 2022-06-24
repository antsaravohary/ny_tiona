String twoDigit(int n) {
  return n >= 10 ? '$n' : '0$n';
}

String playerTime(Duration duration) {
  String time = '';
  int hours = duration.inHours.remainder(Duration.hoursPerDay);
  // add only hour if it have value
  if (hours > 0) time += '${twoDigit(hours)}:';
  int minutes = duration.inMinutes.remainder(Duration.minutesPerHour);
  time += twoDigit(minutes);
  int seconds = duration.inSeconds.remainder(Duration.secondsPerMinute);
  time += ':${twoDigit(seconds)}';
  return time;
}
