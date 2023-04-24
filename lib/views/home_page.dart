import 'dart:convert';

import 'package:ashesi_social_network/utils/custom_styles.dart';
import 'package:ashesi_social_network/utils/custom_widgets/custom_textfield.dart';
import 'package:ashesi_social_network/services/api_controller.dart';
import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:ashesi_social_network/services/firebase_controller.dart';
import 'package:ashesi_social_network/services/message_structure.dart';
import 'package:ashesi_social_network/views/message_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseDbService _dBService;
  final _messageController = TextEditingController();

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
          child: const Opacity(
            opacity: 1,
            child: Image(
              image: AssetImage('images/home_background.jpg'),
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
            leading: const CircleAvatar(
              backgroundImage: AssetImage('images/ashesi_logo.jpg'),
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
                    context.go('/login');
                    await FirebaseAuthService().logOut();
                  },
                  child: Text(
                    "Logout",
                    style: navButtonsStyle,
                  )),
            ],
          ),
          body: Column(
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
                          sortedMessages.sort((a, b) =>
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
                padding: EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          style: textFieldStyle,
                          controller: _messageController,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: "Type your message",
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.08,
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextButton(
                        onPressed: () async {
                          final user = await ApiController().getUser(
                              email: FirebaseAuthService().currentUser!.email);
                          Map<String, dynamic> userData =
                              jsonDecode(user!.body);
                          final wasSuccessful = await ApiController()
                              .createNewMessage(
                                  email:
                                      FirebaseAuthService().currentUser!.email,
                                  datePosted: DateFormat('yyyy-MM-dd HH:mm:ss')
                                      .format(DateTime.now())
                                      .toString(),
                                  messageBody: _messageController.text,
                                  fullName: userData['full-name']);
                          if (wasSuccessful) {
                            _messageController.clear();
                          }
                        },
                        child: const Text(
                          'Post',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
