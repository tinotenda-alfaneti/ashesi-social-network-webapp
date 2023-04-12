import 'package:ashesi_social_network/constants/defined_fonts.dart';
import 'package:ashesi_social_network/constants/error_dialogs/show_error_dialog.dart';
import 'package:ashesi_social_network/constants/error_dialogs/show_loading_dialog.dart';
import 'package:ashesi_social_network/custom_widgets/custom_textfield.dart';
import 'package:ashesi_social_network/services/api_controller.dart';
import 'package:ashesi_social_network/services/auth_service/auth_exceptions.dart';
import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //initialize variables to grab values from the text fields

  bool _value = false;

  String? _uploadedFileURL;

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _class;
  late final TextEditingController _fullname;
  late final TextEditingController _studentID;
  late final TextEditingController _dob;
  late final TextEditingController _major;
  late final TextEditingController _bestMovie;
  late final TextEditingController _bestFood;
  bool _isLoading = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _class = TextEditingController();
    _fullname = TextEditingController();
    _studentID = TextEditingController();
    _dob = TextEditingController();
    _major = TextEditingController();
    _bestMovie = TextEditingController();
    _bestFood = TextEditingController();
    super.initState();
  }

  creatingUser(
      {required final String email,
      required final String studentID,
      required final String dob,
      required final String major,
      required final String bestMovie,
      required final String bestFood,
      required final String compassRes,
      required final String password,
      required final String yearClass,
      // required final String imageUrl,
      required final String fullName}) async {
    setState(() {
      _isLoading = true;
    });

    final user = await FirebaseAuthService().createUser(
      email: email,
      password: password,
    );

    await ApiController().createNewUser(
      bestFood: bestFood,
      bestMovie: bestMovie,
      compassRes: compassRes,
      dob: dob,
      email: email,
      yearClass: yearClass,
      studentID: studentID,
      password: password,
      major: major,
      fullName: fullName,
      // imageUrl: imageUrl,
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _class.dispose();
    _fullname.dispose();
    _studentID.dispose();
    _dob.dispose();
    _major.dispose();
    _bestMovie.dispose();
    _bestFood.dispose();
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
                  Center(
                    child: Text(
                      "Registration Form",
                      style: textFieldStyle,
                    ),
                  ),

                  //Email input field
                  CustomTextField(
                    labelText: "Full Name",
                    fieldController: _fullname,
                    keyboardType: TextInputType.text,
                  ),

                  CustomTextField(
                    labelText: "Email Address",
                    fieldController: _email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  //password input field
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextField(
                      style: textFieldStyle,
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),

                  CustomTextField(
                    labelText: "Student ID",
                    fieldController: _studentID,
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          labelText: "Class Group",
                          fieldController: _class,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          // space around the field
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 0),
                          child: TextField(
                            style: textFieldStyle,
                            controller: _dob,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),

                              // labelText: 'Date',
                              hintText: "Date Of Birth",
                              suffixIcon: Icon(Icons.calendar_month),
                            ),
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2023),
                                      lastDate: DateTime(2070))
                                  .then(
                                (selectedDate) {
                                  if (selectedDate != null) {
                                    _dob.text = DateFormat.yMMMEd()
                                        .format(selectedDate);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  CustomTextField(
                    labelText: "Major",
                    fieldController: _major,
                    keyboardType: TextInputType.text,
                  ),

                  CustomTextField(
                    labelText: "Best Movie",
                    fieldController: _bestMovie,
                    keyboardType: TextInputType.text,
                  ),
                  //Phone Number input field
                  CustomTextField(
                    labelText: "Favourite Food",
                    fieldController: _bestFood,
                    keyboardType: TextInputType.text,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          child: Text(
                            'Have Campus Residence? ',
                            style: textFieldStyle,
                          ),
                        ), //SizedBox
                        /** Checkbox Widget **/
                        Checkbox(
                          value: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                            });
                          },
                        ), //Checkbox
                      ], //<Widget>[]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextButton(
                        onPressed: () async {
                          final String email = _email.text;
                          final String studentID = _studentID.text;
                          final String dob = _dob.text;
                          final String major = _major.text;
                          final String bestMovie = _bestMovie.text;
                          final String bestFood = _bestFood.text;
                          final String compassRes = _value.toString();
                          final String password = _password.text;
                          final String yearClass = _class.text;
                          // final imageUrl = _uploadedFileURL;
                          final String fullName = _fullname.text;
                          try {
                            await creatingUser(
                              email: email,
                              password: password,
                              // imageUrl: imageUrl!,
                              bestFood: bestFood,
                              bestMovie: bestMovie,
                              compassRes: compassRes,
                              dob: dob,
                              fullName: fullName,
                              major: major,
                              studentID: studentID,
                              yearClass: yearClass,
                            );
                            if (_isLoading) {
                              showLoadingDialog(
                                  context: context, text: "Creating User");
                            }

                            context.go('/login');
                          } on WeakPasswordAuthException {
                            await showErrorDialog(
                              context,
                              "Weak Password",
                            );
                          } on EmailAlreadyInUseAuthException {
                            await showErrorDialog(
                              context,
                              "Email is already in use",
                            );
                          } on InvalidEmailAuthException {
                            await showErrorDialog(
                              context,
                              "Invalid email",
                            );
                          } on GenericAuthException {
                            debugPrint(password);
                            debugPrint(email);
                            await showErrorDialog(
                              context,
                              "Failed to register",
                            );
                          }
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),

                  //adding button to switch to register screen
                  TextButton(
                    onPressed: () {
                      context.go('/login');
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
