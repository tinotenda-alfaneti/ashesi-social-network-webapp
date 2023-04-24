import 'package:ashesi_social_network/utils/custom_styles.dart';
import 'package:ashesi_social_network/utils/custom_widgets/custom_textfield.dart';
import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:ashesi_social_network/services/api_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  @override
  void initState() {
    _major = TextEditingController();
    _bestFood = TextEditingController();
    _bestMovie = TextEditingController();
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
            onPressed: () async {},
            icon: const Icon(Icons.edit),
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
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            // height: 180,
                            alignment: const Alignment(0.0, 0.0),
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage("images/default_user1.png"),
                              radius: 80.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${responseData["full-name"]}',
                            style: profileNameStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${responseData["email"]}',
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
                            "D.O.B: ${responseData['dob']}",
                            style: profileOtherStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            CustomTextField(
                              labelText: "Major",
                              fieldController: _major,
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
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 40, bottom: 0),
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: themeColor,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: TextButton(
                                  onPressed: () async {
                                    final wasUpdated =
                                        await ApiController().updateUser(
                                      email: responseData['email'],
                                      studentID: responseData['student-id'],
                                      major: _major.text,
                                      bestFood: _bestFood.text,
                                      bestMovie: _bestMovie.text,
                                    );

                                    if (wasUpdated) {
                                      setState(() {});
                                    }
                                  },
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            // CustomTextField(
                            //   labelText: "Bio",
                            //   fieldController: _bio,
                            //   keyboardType: TextInputType.multiline,
                            // ),

                            // Text(
                            //   'Staying on Campus? : ${responseData["compass-resident"]}', //project name
                            //   style: const TextStyle(
                            //       fontSize: 25.0,
                            //       color: Colors.blueGrey,
                            //       letterSpacing: 0.70,
                            //       fontWeight: FontWeight.w400),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
