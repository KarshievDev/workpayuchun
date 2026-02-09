import 'package:flutter_test/flutter_test.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';

main(){
  group('HomeEvent', () {
    group('LoadSettings equality', () {
      test('Support LoadSettings equality', (){
        expect(LoadSettings(), equals(LoadSettings()));
      });
      test('LoadSettings props correct', (){
        expect(LoadSettings().props, equals([]));
      });
    });

  });
}