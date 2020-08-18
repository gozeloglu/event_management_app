import 'file:///C:/Users/gozel/OneDrive/Desktop/event_management_app/event_management_app/lib/pages/participant/profile.dart';
import 'package:event_management_app/pages/sign_up.dart';
import 'file:///C:/Users/gozel/OneDrive/Desktop/event_management_app/event_management_app/lib/pages/participant/home_page.dart';
import 'package:event_management_app/pages/login.dart';
import 'package:flutter/material.dart';

class Routes {
  static String get splash => "/";

  static String get home => "/home";

  static String get login => "/login";

  static String get signUp => "/signUp";

  static String get profile => "/profile";
}

Map<String, Widget> routes = {
  Routes.home: HomePage(),
  Routes.signUp: SignUp(),
  Routes.login: Login(),
  Routes.profile: Profile(),
};
