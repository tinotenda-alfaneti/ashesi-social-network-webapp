import 'dart:convert';

import 'package:ashesi_social_network/utils/custom_dialogs/show_logout_dialog.dart';
import 'package:ashesi_social_network/utils/custom_styles.dart';
import 'package:ashesi_social_network/services/api_controller.dart';
import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:ashesi_social_network/services/firebase_controller.dart';
import 'package:ashesi_social_network/services/message_structure.dart';
import 'package:ashesi_social_network/utils/custom_widgets/custom_textfield.dart';
import 'package:ashesi_social_network/views/message_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseDbService _dBService;
  final _messageController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _dBService = FirebaseDbService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: 1,
            child: Image(
              image: Image.asset('assets/images/home_background.jpg').image,
              fit: BoxFit.cover,
              // color: themeColor,
              filterQuality: FilterQuality.high,
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: themeColor,
            leading: CircleAvatar(
              backgroundImage:
                  Image.asset('assets/images/ashesi_logo.jpg').image,
              maxRadius: 25,
            ),
            title: Text(
              "Ashesi Social Network",
              style: appBarFont,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    context.go('/home/profile');
                  },
                  child: Text(
                    "Profile",
                    style: navButtonsStyle,
                  )),
              TextButton(
                  onPressed: () async {
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      await FirebaseAuthService().logOut();
                      GoRouter.of(context).go('/');
                    }
                  },
                  child: Text(
                    "Logout",
                    style: navButtonsStyle,
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: StreamBuilder(
                    stream: _dBService.allMessages(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          if (snapshot.hasData) {
                            final allMessages =
                                snapshot.data as Iterable<Message>;
                            final sortedMessages = allMessages.toList();
                            sortedMessages.sort((b, a) =>
                                DateTime.parse(a.dateSend)
                                    .compareTo(DateTime.parse(b.dateSend)));
                            return MessagesListView(
                              messages: sortedMessages,
                              //.toList().sort(((a, b) => ))
                              onTap: (message) {},
                              onDeleteMessage: (message) {},
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        default:
                          return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 15.0),
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: TextField(
                              style: textFieldStyle,
                              controller: _messageController,
                              enableSuggestions: true,
                              autocorrect: false,
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  // hintText: "Type your message",
                                  labelText: "Type your message",
                                  fillColor: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: CustomTextField(
                            labelText: "Enter email address",
                            fieldController: _emailController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.04,
                        // ),
                        Container(
                          height: 40,
                          width: 60,
                          // height: MediaQuery.of(context).size.height * 0.05,
                          // width: MediaQuery.of(context).size.width * 0.08,
                          decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: SingleChildScrollView(
                            child: TextButton(
                              onPressed: () async {
                                if (_messageController.text.isEmpty) {
                                  final snackbar = SnackBar(
                                    content: Text(
                                      'Cannot send an empty post',
                                      style: appBarFont,
                                    ),
                                    backgroundColor: themeColor,
                                    elevation: 5,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                } else if (_emailController.text.isNotEmpty &&
                                    _emailController.text !=
                                        FirebaseAuthService()
                                            .currentUser!
                                            .email) {
                                  final snackbar = SnackBar(
                                    content: Text(
                                      'Email is incorrect, use the one you used for logging in',
                                      style: appBarFont,
                                    ),
                                    backgroundColor: themeColor,
                                    elevation: 5,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                } else {
                                  final user = await ApiController().getUser(
                                      email: FirebaseAuthService()
                                          .currentUser!
                                          .email);
                                  Map<String, dynamic> userData =
                                      jsonDecode(user!.body);
                                  final wasSuccessful = await ApiController()
                                      .createNewMessage(
                                          email: FirebaseAuthService()
                                              .currentUser!
                                              .email,
                                          datePosted:
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .format(DateTime.now())
                                                  .toString(),
                                          messageBody: _messageController.text,
                                          fullName: userData['full-name']);
                                  if (wasSuccessful) {
                                    _messageController.clear();
                                    _emailController.clear();

                                    final snackbar = SnackBar(
                                      duration: const Duration(seconds: 5),
                                      content: Text(
                                        'Posted successfully...',
                                        style: GoogleFonts.ubuntu(
                                          color: themeColor,
                                        ),
                                      ),
                                      backgroundColor: Colors.white,
                                      elevation: 5,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  }
                                }
                              },
                              child: const Text(
                                // textAlign: TextAlign.center,
                                'Post',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
