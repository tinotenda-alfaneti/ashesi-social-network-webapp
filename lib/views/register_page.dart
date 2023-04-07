import 'package:ashesi_social_network/constants/defined_fonts.dart';
import 'package:ashesi_social_network/constants/routes.dart';
import 'package:ashesi_social_network/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //initialize variables to grab values from the text fields

  final TextEditingController _controller = TextEditingController();

  bool _value = false;

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
                  Center(
                    child: Text(
                      "Registration Form",
                      style: textFieldStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
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
                          label: Text(
                            "Upload Profile Image",
                            style: textFieldStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Email input field
                  CustomTextField(
                    labelText: "Full Name",
                    fieldController: _controller,
                    keyboardType: TextInputType.text,
                  ),

                  CustomTextField(
                    labelText: "Email Address",
                    fieldController: _controller,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  //password input field
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextField(
                      style: textFieldStyle,
                      controller: _controller,
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
                    fieldController: _controller,
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          labelText: "Class Group",
                          fieldController: _controller,
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
                            controller: _controller,
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
                                    debugPrint(DateFormat.yMMMEd()
                                        .format(selectedDate));
                                    // _date.text =
                                    //     DateFormat.yMMMEd().format(selectedDate);
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
                    fieldController: _controller,
                    keyboardType: TextInputType.text,
                  ),

                  CustomTextField(
                    labelText: "Best Movie",
                    fieldController: _controller,
                    keyboardType: TextInputType.text,
                  ),
                  //Phone Number input field
                  CustomTextField(
                    labelText: "Favourite Food",
                    fieldController: _controller,
                    keyboardType: TextInputType.text,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Have Campus Residence? ',
                          style: textFieldStyle,
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

//                   //r student ID number, name, email, date of birth, year
// group, major, whether or not they have campus residence, their best food, and their best
// movie.

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
                        onPressed: () {},
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),

                  // //adding empty space
                  // const SizedBox(
                  //   height: 50,
                  // ),

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
