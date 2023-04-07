import 'package:ashesi_social_network/constants/defined_fonts.dart';
import 'package:ashesi_social_network/constants/routes.dart';
import 'package:ashesi_social_network/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    TextEditingController _controller = TextEditingController();
    return Scaffold(
      backgroundColor: themeColor,
      body: Center(
        child: Card(
          shadowColor: Colors.white,
          // margin: const EdgeInsets.only(top: 5.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          color: Theme.of(context).cardColor,
          elevation: 18,
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              maxHeight: double.infinity,
              maxWidth: MediaQuery.of(context).size.width * 0.3,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/ashesi_logo.jpg'),
                    maxRadius: 70,
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  Center(
                    child: Text(
                      "Welcome",
                      style: textFieldStyle,
                    ),
                  ),

                  CustomTextField(
                    labelText: "Email Address",
                    fieldController: _controller,
                    keyboardType: TextInputType.text,
                  ),

                  //password input field
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 30, bottom: 0),
                    child: TextField(
                      // controller: _password,
                      style: textFieldStyle,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),

                  //Register button and forgot passwod button

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 30, bottom: 0),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              homeRoute, (route) => false);
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),

                  //adding empty space
                  const SizedBox(
                    height: 50,
                  ),

                  //adding button to switch to register screen
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          signUpRoute, (route) => false);
                    },
                    child: const Text(
                      'Not registered yet? Sign up',
                      style: TextStyle(
                          color: themeColor, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
