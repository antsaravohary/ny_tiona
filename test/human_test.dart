import 'package:flutter_test/flutter_test.dart';
import 'package:ny_tiona/tools/human.dart';

void main() {
  test('Should show human duration for player', () {
    expect(
      playerTime(const Duration(days: 1, hours: 2, minutes: 34, seconds: 11)),
      '02:34:11',
    );
    expect(
      playerTime(const Duration(hours: 0, minutes: 4, seconds: 1)),
      '04:01',
    );
  });
}
