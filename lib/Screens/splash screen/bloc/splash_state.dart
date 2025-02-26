part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {

}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  final bool isUserLoggedIn;

  SplashLoaded(this.isUserLoggedIn);
}

class SplashCompleted extends SplashState{}
class SplashError extends SplashState {
  final String message;

  SplashError(this.message);
}
