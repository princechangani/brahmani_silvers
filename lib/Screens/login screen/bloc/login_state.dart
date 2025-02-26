part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final bool isLoginSuccess;

  const LoginSuccess({required this.isLoginSuccess});
}
class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure({required this.errorMessage});
}
