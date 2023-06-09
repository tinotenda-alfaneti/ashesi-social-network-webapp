import 'package:ashesi_social_network/utils/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: 0.25,
            child: Image(
              image: Image.asset('assets/images/home_background.jpg').image,
              // image: AssetImage('images/home_background.jpg'),
              fit: BoxFit.cover,
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
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Welcome",
                    style: headingStyle,
                  ),
                ),
                Center(
                  child: Text(
                    "to",
                    style: headingStyle,
                  ),
                ),
                Center(
                  child: Text(
                    softWrap: true,
                    textAlign: TextAlign.center,
                    "Ashesi Social Network",
                    style: headingStyle,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 10.0,
                    top: 30,
                    bottom: 15,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 20,
                      shadowColor: Colors.red,
                      padding: const EdgeInsets.all(15.0),
                      backgroundColor: themeColor,
                    ),
                    onPressed: () {
                      context.go('/signup');
                    },
                    child: Text(
                      "Sign up",
                      style: buttonsStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
