import 'package:ashesi_social_network/constants/defined_fonts.dart';
import 'package:ashesi_social_network/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //initialize variables to grab values from the text fields

  String? _uploadedFileURL;

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
                  const Center(
                    child: Text(
                      "Registration Form",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          //logo image
                          child: _uploadedFileURL != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(_uploadedFileURL!),
                                  maxRadius: 10,
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("images/placeholder.jpg"),
                                  maxRadius: 10,
                                ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.file_upload_outlined),
                          label: const Text("Upload Profile Image"),
                        ),
                      ],
                    ),
                  ),
                  //Email input field
                  const Padding(
                    //space around the field
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 30, bottom: 0),
                    child: TextField(
                      // controller: _username,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',
                      ),
                    ),
                  ),

                  //Email input field
                  const Padding(
                    //space around the field
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 30, bottom: 0),
                    child: TextField(
                      // controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),

                  //password input field
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 30, bottom: 0),
                    child: TextField(
                      // controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),

                  //Phone Number input field
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 30, bottom: 0),
                    child: TextField(
                      // controller: _phone,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                          hintText: 'e.g +263777888000'),
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
                        onPressed: () {},
                        child: const Text(
                          'Sign up',
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
                          logInRoute, (route) => false);
                    },
                    child: const Text(
                      'Already have an account? Log in',
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
