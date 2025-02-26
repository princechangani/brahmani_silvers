part of 'navbar_bloc.dart';

sealed class NavbarState extends Equatable {
  const NavbarState();
  @override
  List<Object> get props => [];
}

final class NavbarInitial extends NavbarState {

}


class DashboardPageChanged extends NavbarState {
  final int currentIndex;

  const DashboardPageChanged(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
