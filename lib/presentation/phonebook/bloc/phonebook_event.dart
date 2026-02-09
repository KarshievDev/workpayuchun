part of 'phonebook_bloc.dart';

abstract class PhoneBookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoMultiSelectionEvent extends PhoneBookEvent {
  final PhoneBookUser phoneBookUser;
  DoMultiSelectionEvent(this.phoneBookUser);
  @override
  List<Object?> get props => [phoneBookUser];
}

class PhoneBookLoadRequest extends PhoneBookEvent {
  PhoneBookLoadRequest();

  @override
  List<Object?> get props => [];
}

class IsMultiSelectionEnabled extends PhoneBookEvent {
  final bool? isMultiSelectionEnabled;
  IsMultiSelectionEnabled(this.isMultiSelectionEnabled);

  @override
  List<Object?> get props => [isMultiSelectionEnabled];
}

class PhoneBookSearchData extends PhoneBookEvent {
  final String? searchText;
  final int? pageCount;
  final int? departmentId;
  final int? designationId;

  PhoneBookSearchData(
      {this.searchText,
      this.pageCount = 1,
      this.departmentId,
      this.designationId});

  @override
  List<Object?> get props =>
      [searchText, pageCount, departmentId, designationId];
}

class PhoneBookLoadRefresh extends PhoneBookEvent {
  PhoneBookLoadRefresh();

  @override
  List<Object?> get props => [];
}

class PhoneBookLoadMore extends PhoneBookEvent {
  PhoneBookLoadMore();

  @override
  List<Object?> get props => [];
}

class SelectDepartmentValue extends PhoneBookEvent {
  final Department departmentsData;

  SelectDepartmentValue(this.departmentsData);

  @override
  List<Object?> get props => [departmentsData];
}

class SelectDesignationValue extends PhoneBookEvent {
  final Department designationData;

  SelectDesignationValue(this.designationData);

  @override
  List<Object?> get props => [designationData];
}

class DirectPhoneCall extends PhoneBookEvent {
  final String phoneNumber;

  DirectPhoneCall(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class DirectMessage extends PhoneBookEvent {
  final String phoneNumber;

  DirectMessage(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class DirectMailTo extends PhoneBookEvent {
  final String email;
  final String userName;

  DirectMailTo(this.email, this.userName);

  @override
  List<Object?> get props => [email, userName];
}

class PhoneBookDetails extends PhoneBookEvent {
  final String userId;

  PhoneBookDetails(this.userId);

  @override
  List<Object?> get props => [userId];
}
