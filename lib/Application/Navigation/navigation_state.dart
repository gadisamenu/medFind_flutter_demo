abstract class NavigationState {}

class NavigationLoading extends NavigationState {}

class NavigationLoaded extends NavigationState {
  String path;
  NavigationLoaded({required this.path});
}
