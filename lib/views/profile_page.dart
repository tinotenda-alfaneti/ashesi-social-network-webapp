import 'package:ashesi_social_network/utils/custom_dialogs/show_error_dialog.dart';
import 'package:ashesi_social_network/utils/custom_dialogs/show_logout_dialog.dart';
import 'package:ashesi_social_network/utils/custom_styles.dart';
import 'package:ashesi_social_network/utils/custom_widgets/custom_textfield.dart';
import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:ashesi_social_network/services/api_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _major;
  late final TextEditingController _bestFood;
  late final TextEditingController _bestMovie;
  late http.Response _response;
  late final TextEditingController _value;
  late final TextEditingController _class;
  late final TextEditingController _dob;
  @override
  void initState() {
    _major = TextEditingController();
    _bestFood = TextEditingController();
    _bestMovie = TextEditingController();
    _value = TextEditingController();
    _class = TextEditingController();
    _dob = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        centerTitle: true,
        title: Text(
            // _project!.projectName.toUpperCase(),
            "MY PROFILE",
            style: appBarFont),
        actions: [
          IconButton(
            onPressed: () async {
              final shouldLogout = await showLogOutDialog(context);
              if (shouldLogout) {
                await FirebaseAuthService().logOut();
                GoRouter.of(context).go('/');
              }
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: FutureBuilder(
        future: ApiController()
            .getUser(email: FirebaseAuthService().currentUser!.email),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.done:
              if (snapshot.hasData) {
                final profileData = snapshot.data;

                Map<String, dynamic> responseData =
                    jsonDecode(profileData!.body);
                _major.text = responseData['major'];
                _bestFood.text = responseData["best-food"];
                _bestMovie.text = responseData["best-movie"];
                _value.text =
                    responseData["compass-resident"] == "true" ? "yes" : "no";
                _class.text = responseData['class'];
                // _dob.text = responseData['dob'];
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                // height: 180,
                                alignment: const Alignment(0.0, 0.0),
                                child: CircleAvatar(
                                  backgroundImage: Image.asset(
                                          'assets/images/default_user1.png')
                                      .image,
                                  radius: 80.0,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${responseData["full-name"]}',
                                        style: profileNameStyle,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Email address: ${responseData["email"]}',
                                        style: profileOtherStyle,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Student ID: ${responseData['student-id']}",
                                        style: profileOtherStyle,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Class of ${responseData['class']}",
                                        style: profileOtherStyle,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "D.O.B: ${responseData['dob']}",
                                        style: profileOtherStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, bottom: 15.0, right: 15.0, left: 15.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CustomTextField(
                                  labelText: "Major",
                                  fieldController: _major,
                                  keyboardType: TextInputType.text,
                                ),
                                CustomTextField(
                                  labelText: "Class",
                                  fieldController: _class,
                                  keyboardType: TextInputType.text,
                                ),
                                CustomTextField(
                                  labelText: "Best Food",
                                  fieldController: _bestFood,
                                  keyboardType: TextInputType.text,
                                ),
                                CustomTextField(
                                  labelText: "Best Movie",
                                  fieldController: _bestMovie,
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  // space around the field
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 15,
                                      bottom: 0),
                                  child: TextField(
                                    style: textFieldStyle,
                                    controller: _dob,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Date Of Birth',
                                      suffixIcon: Icon(Icons.calendar_month),
                                    ),
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime(2000),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2030))
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
                                CustomTextField(
                                  labelText: "Staying on Campus?",
                                  fieldController: _value,
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 40,
                                      bottom: 0),
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: themeColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: TextButton(
                                      onPressed: () async {
                                        if (_major.text.isEmpty ||
                                            _bestFood.text.isEmpty ||
                                            _bestMovie.text.isEmpty ||
                                            _value.text.isEmpty ||
                                            _class.text.isEmpty) {
                                          await showErrorDialog(
                                            context,
                                            "Cannot update with empty field(s)",
                                          );
                                        } else if (_value.text.toLowerCase() !=
                                                "yes" &&
                                            _value.text.toLowerCase() != "no") {
                                          await showErrorDialog(
                                            context,
                                            "Staying on Campus should be yes or no",
                                          );
                                        } else {
                                          final dateOfBirth = _dob.text.isEmpty
                                              ? responseData['dob']
                                              : _dob.text;
                                          final wasUpdated =
                                              await ApiController().updateUser(
                                            email: responseData['email'],
                                            studentID:
                                                responseData['student-id'],
                                            major: _major.text,
                                            bestFood: _bestFood.text,
                                            bestMovie: _bestMovie.text,
                                            campusResident: _value.text,
                                            yearClass: _class.text,
                                            dob: dateOfBirth,
                                          );

                                          if (wasUpdated) {
                                            setState(() {
                                              final snackbar = SnackBar(
                                                content: Text(
                                                  'Profile updated Successfully',
                                                  style: appBarFont,
                                                ),
                                                backgroundColor: themeColor,
                                                elevation: 5,
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackbar);
                                            });
                                          }
                                        }
                                        // setState(() {});
                                      },
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              debugPrint('default');
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
