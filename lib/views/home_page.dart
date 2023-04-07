import 'package:ashesi_social_network/constants/defined_fonts.dart';
import 'package:ashesi_social_network/constants/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    Navigator.of(context).pushNamed(profileRoute);
                  },
                  child: Text(
                    "Profile",
                    style: navButtonsStyle,
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Logout",
                    style: navButtonsStyle,
                  )),
            ],
          ),
          body: Column(),
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
