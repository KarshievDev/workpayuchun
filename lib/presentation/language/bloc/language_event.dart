part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {}

class SelectLanguage extends LanguageEvent {
  final int selectIndex;
  final BuildContext context;
  SelectLanguage(this.context, this.selectIndex);
  @override
  List<Object> get props => [selectIndex];
}
