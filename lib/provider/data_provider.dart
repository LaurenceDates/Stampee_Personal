import 'dart:async';
import 'package:stampee_personal/component/user.dart';

class DataProvider {
  static DataProvider _instance = DataProvider();
  static DataProvider get instance => _instance;
  static AppUser initialData = AppUser.instance;

  final StreamController<AppUser> _controller = StreamController<AppUser>.broadcast();
  Stream<AppUser> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
