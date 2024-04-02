import 'dart:async';


import 'app_routes.dart';
enum NavigationType {
  Push,
  PushReplacement,
  Pop,
  PopUntil
  // Add more navigation types as needed
}
abstract class INavigation{
 AppRoute? appRoute;
  Object? data;
  NavigationType? navigationType;
}

class Navigation extends INavigation{
final AppRoute? appRoute;
 final Object? data;
 final NavigationType? navigationType;
 Navigation({this.data,this.navigationType,this.appRoute});
}

mixin NavigationMixin {
  final StreamController<INavigation> _navigationController = StreamController<INavigation>.broadcast();
  Stream<INavigation> get navigationStream => _navigationController.stream;
  Sink<INavigation> get navigationSink => _navigationController.sink;

  void dispose() {
    _navigationController.close();
  }
}
