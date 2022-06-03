abstract class NavigationEvent {
  String path;
  NavigationEvent({required this.path});
}

class Navigate extends NavigationEvent {
  Navigate({required String path}) : super(path: path);
}
