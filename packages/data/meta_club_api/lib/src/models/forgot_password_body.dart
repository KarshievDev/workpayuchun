class ForgotPasswordBody {
  String? email;
  String? code;
  String? password;
  String? passwordConfirmation;

  ForgotPasswordBody({
    this.email,
    this.code,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}
