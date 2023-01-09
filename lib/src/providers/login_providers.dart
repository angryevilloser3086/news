// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_reader/src/utils/app_utils.dart';
import 'package:news_reader/src/utils/loading_indicator.dart';
import 'package:news_reader/src/view/signup/login_screen.dart';

import '../view/home/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController get eController => emailController;
  TextEditingController get pController => passController;
  TextEditingController get nController => nameController;


  
  void auth(BuildContext context) async {
    if (_auth.currentUser == null) {
      AppConstants.moveNextstl(context, const LoginScreen());
      notifyListeners();
    } else {
      _auth.currentUser!.getIdToken().then((value) {
        AppConstants.moveNextstl(context, const HomeScreen());
      }).catchError((e) {
        AppConstants.moveNextstl(context, const LoginScreen());
      });
      notifyListeners();
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }


  Future<void> createUser(
      BuildContext context, String uid, String username, String email) async {
    await db
        .collection("users")
        .doc(uid)
        .set({'email': email, 'name': username}).then((value) {
      Navigator.of(context, rootNavigator: true).pop();
      AppConstants.moveNextstl(context, const HomeScreen());
      AppConstants.showSnackBar(context, "Succesfully loggedIn");
    }).catchError((e) {
      Navigator.of(context, rootNavigator: true).pop();
      AppConstants.showSnackBar(context, "$e");
    });
  }

  //SIGN UP METHOD
  Future signUp(
      BuildContext context, String name, String email, String password) async {
    DialogBuilder(context).showLoadingIndicator("");
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      createUser(context, result.user!.uid, name, email);

      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      AppConstants.showSnackBar(context, "$e");
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn(BuildContext context, String email, String password) async {
    DialogBuilder(context).showLoadingIndicator("");
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      result.user!.getIdToken().then((value) {
        // print("called${value}");
        Navigator.of(context, rootNavigator: true).pop();
        AppConstants.moveNextstl(context, const HomeScreen());
      });
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      AppConstants.showSnackBar(context, "$e");

      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
  }
}
