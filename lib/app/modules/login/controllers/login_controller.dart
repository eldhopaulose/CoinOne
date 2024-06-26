import 'package:coin_one/app/modules/home/views/home_view.dart';
import 'package:coin_one/app/modules/login/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import

class LoginController extends GetxController {
  //input controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final keepMeLoggedIn = false.obs;
  final passwordVisible = true.obs;

//inzialize firebase auth
  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    super.onInit();
    // Check if user is already logged in and redirect accordingly
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? keepLoggedIn = prefs.getBool('keepLoggedIn');
    if (keepLoggedIn != null && keepLoggedIn) {
      firebaseUser = Rx<User?>(auth.currentUser);
      firebaseUser.bindStream(auth.userChanges());
      ever(firebaseUser, _setInitialScreen);
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Check if user is already logged in and redirect accordingly
    SharedPreferences.getInstance().then((prefs) {
      bool? keepLoggedIn = prefs.getBool('keepLoggedIn');
      if (keepLoggedIn != null && keepLoggedIn) {
        firebaseUser = Rx<User?>(auth.currentUser);
        firebaseUser.bindStream(auth.userChanges());
        ever(firebaseUser, _setInitialScreen);
      }
    });
  }

// set initial screen
  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginView());
    } else {
      Get.offAll(() => HomeView());
    }
  }

//login logic
  void loginLogic(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('keepLoggedIn', keepMeLoggedIn.value);
      Get.offAll(() => HomeView());
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "invalid-credential":
          errorMessage = "Your password is wrong.";
          break;
        default:
          errorMessage = "An undefined error happened.";
      }

      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Failed with error code: ${e.code}');
      print(e.message);
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

//validate login
  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and password cannot be empty',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    } else {
      loginLogic(email, password);
    }
  }
}
