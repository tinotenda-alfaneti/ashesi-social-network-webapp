import 'package:ashesi_social_network/utils/constants.dart';
import 'package:ashesi_social_network/utils/custom_styles.dart';
import 'package:ashesi_social_network/utils/custom_dialogs/show_error_dialog.dart';
import 'package:ashesi_social_network/utils/custom_widgets/custom_textfield.dart';
import 'package:ashesi_social_network/services/auth_service/auth_exceptions.dart';
import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

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
              maxWidth: MediaQuery.of(context).size.width * 0.5,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        Image.asset('assets/images/ashesi_logo.jpg').image,
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
                    fieldController: _email,
                    keyboardType: TextInputType.text,
                  ),

                  //password input field
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 30, bottom: 0),
                    child: TextField(
                      controller: _password,
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
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;

                          if (email.isEmpty || password.isEmpty) {
                            await showErrorDialog(
                              context,
                              "All fields are required",
                            );
                          } else if (emailRegex.hasMatch(email) == false) {
                            await showErrorDialog(
                              context,
                              "Invalid email address",
                            );
                          } else {
                            try {
                              final snackbar = SnackBar(
                                // duration: const Duration(seconds: 5),
                                content: Text(
                                  'Almost done, Please wait...',
                                  style: GoogleFonts.ubuntu(
                                    color: themeColor,
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                elevation: 5,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              await FirebaseAuthService().logIn(
                                email: email,
                                password: password,
                              );
                              context.go('/home');
                            } on UserNotFoundAuthException {
                              await showErrorDialog(
                                context,
                                "User not found",
                              );
                            } on WrongPasswordAuthException {
                              await showErrorDialog(
                                context,
                                "Wrong password",
                              );
                            } on GenericAuthException {
                              await showErrorDialog(
                                context,
                                'Authentication error',
                              );
                            }
                          }
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
                      context.go('/signup');
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
