import 'package:get/get.dart';

class LoginController extends GetxController {
  bool isValidEmail(String email) {
    // Simple email validation using regex
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  RxBool isShowPassword = false.obs;
}
