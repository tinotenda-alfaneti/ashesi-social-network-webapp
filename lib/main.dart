import 'package:ashesi_social_network/constants/routes.dart';
import 'package:ashesi_social_network/views/home_page.dart';
import 'package:ashesi_social_network/views/login_page.dart';
import 'package:ashesi_social_network/views/profile_page.dart';
import 'package:ashesi_social_network/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:ashesi_social_network/views/welcome_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const IndexPage(),
      routes: {
        homeRoute: (context) => const HomePage(),
        signUpRoute: (context) => const SignUpPage(),
        logInRoute: (context) => const LogInPage(),
        profileRoute: (context) => ProfilePage()
      },
    ),
  );
}
