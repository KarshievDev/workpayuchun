import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Today Model Test', () {
    final day1Json = {
      'image': 'image1',
      'title': 'title1',
      'number': 1,
      'slug': 'leave',
    };

    final day2Json = {
      'image': 'image2',
      'title': 'title2',
      'number': 2,
      'slug': 'meeting',
    };

    Today day1 =
        const Today(image: 'image1', title: 'title1', number: 1, slug: 'leave');

    Today day2 = const Today(
        image: 'image2', title: 'title2', number: 2, slug: 'meeting');

    test('day1 and day2 data class is not equal', () {
      expect(day1 == day2, isFalse);
    });

    test('day1 and day1 data class is  equal', () {
      expect(day1 == day1, isTrue);
    });

    test('Parse and compare day1Json with day1 data class return true', () {
      expect(Today.fromJson(day1Json), day1);
    });

    test('Parse and compare day2Json with day1 data class return true', () {
      expect(Today.fromJson(day2Json), day2);
    });

    test('day1Json and day1.toJson are equal', () {
      expect(day1.toJson(), day1Json);
    });

    test('day2Json and day2.toJson are equal', () {
      expect(day2.toJson(), day2Json);
    });
  });

  group('Current Month Test', () {
    final month1Json = {
      'image': 'image1',
      'title': 'title1',
      'number': 1,
      'slug': 'leave',
    };

    final month2Json = {
      'image': 'image2',
      'title': 'title2',
      'number': 2,
      'slug': 'meeting',
    };

    CurrentMonth month1 = const CurrentMonth(
        image: 'image1', title: 'title1', number: 1, slug: 'leave');

    CurrentMonth month2 = const CurrentMonth(
        image: 'image2', title: 'title2', number: 2, slug: 'meeting');

    test('month1 and month2 data class is not equal', () {
      expect(month1 == month2, isFalse);
    });

    test('month1 and month1 data class is equal', () {
      expect(month2 == month2, isTrue);
    });

    test('Parse and compare month1Json with month1 data class return true', () {
      expect(CurrentMonth.fromJson(month1Json), month1);
    });

    test('Parse and compare month2Json with month2 data class return true', () {
      expect(CurrentMonth.fromJson(month2Json), month2);
    });

    test('month1Json and month1.toJson are equal', () {
      expect(month1.toJson(), month1Json);
    });

    test('month2Json and month2.toJson are equal', () {
      expect(month2.toJson(), month2Json);
    });
  });
}
