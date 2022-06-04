abstract class NavigationState {}

class NavigationLoaded extends NavigationState {
  String path;
  NavigationLoaded({required this.path});
}
