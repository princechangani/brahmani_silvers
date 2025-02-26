part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends LoginEvent{
  final String phone;
  final String pin;
  LoginRequested( {required this.phone, required this.pin});
}
