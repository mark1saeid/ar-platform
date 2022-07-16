import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';

Future<void> main() async {
  // await Firebase.initializeApp();
  test('data api', () async {
    UserService userService = UserService();
    await userService.getAllUsers();
    expect("Success", "Success");
  });
}
