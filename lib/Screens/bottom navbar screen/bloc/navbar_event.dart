part of 'navbar_bloc.dart';

sealed class NavbarEvent extends Equatable {
  const NavbarEvent();
  @override
  List<Object> get props => [];
}

class DashboardNavigateEvent extends NavbarEvent {
  final int index;

  const DashboardNavigateEvent(this.index);

  @override
  List<Object> get props => [index];
}
