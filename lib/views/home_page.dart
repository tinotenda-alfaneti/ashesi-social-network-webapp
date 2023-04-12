import 'package:ashesi_social_network/constants/defined_fonts.dart';
import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:ashesi_social_network/services/firebase_controller.dart';
import 'package:ashesi_social_network/services/message_structure.dart';
import 'package:ashesi_social_network/views/message_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseDbService _dBService;

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
            opacity: 0.25,
            child: Image(
              image: AssetImage('images/home_background.jpg'),
              fit: BoxFit.cover,
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
          body: StreamBuilder(
            stream: _dBService.allMessages(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allMessages = snapshot.data as Iterable<Message>;
                    return MessagesListView(
                      messages: allMessages,
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add,
              size: 40,
              color: themeColor,
            ),
          ),
        ),
      ],
    );
  }
}
