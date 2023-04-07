import 'package:ashesi_social_network/constants/defined_fonts.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
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
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                // height: 180,
                alignment: const Alignment(0.0, 0.0),
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/default_user.png"),
                  radius: 80.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Name: Tinotenda Rodney Alfaneti', //project name
                style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.blueGrey,
                    letterSpacing: 0.70,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "Primary email: talfaneti@gmail.com",
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                "Student ID: 69352024",
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                "D.O.B: 12/12/1960",
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Name: Tinotenda Rodney Alfaneti', //project name
                style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.blueGrey,
                    letterSpacing: 0.70,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "Primary email: talfaneti@gmail.com",
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                "Student ID: 69352024",
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                "D.O.B: 12/12/1960",
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
