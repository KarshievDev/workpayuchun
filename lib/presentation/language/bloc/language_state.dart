part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final int? selectedIndex;

  const LanguageState({this.selectedIndex});

  LanguageState copy({
    int? selectedIndex,
  }) {
    return LanguageState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}
