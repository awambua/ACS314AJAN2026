import 'package:get/get.dart';

class LoginController extends GetxController {
  var username = "".obs;
  var password = "".obs;
  var isLoggedIn = false.obs;

  
  bool login(String user, String pass) {
    username.value = user;
    password.value = pass;
    
    if (username.value == "admin" && password.value == "123") {
      isLoggedIn.value = true;
      return true;  
    } else {
      isLoggedIn.value = false;
      return false; 
    }
  }

  void togglePassword() {
    if (password.value == "123") {
      password.value = "abc";
    } else {
      password.value = "123";
    }
  }

  void logout() {
    isLoggedIn.value = false;
    username.value = "";
    password.value = "";
  }
}