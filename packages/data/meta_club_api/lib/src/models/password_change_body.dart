class PasswordChangeBody {
  int? userId;
  String? currentPassword;
  String? password;
  String? passwordConfirmation;

  PasswordChangeBody({
    this.userId,
    this.currentPassword,
    this.password,
    this.passwordConfirmation,
  });
  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "current_password": currentPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}
