import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:ashesi_social_network/views/home_page.dart';
import 'package:ashesi_social_network/views/login_page.dart';
import 'package:ashesi_social_network/views/profile_page.dart';
import 'package:ashesi_social_network/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:ashesi_social_network/views/welcome_page.dart';
import 'package:go_router/go_router.dart';

void main() async {
  await FirebaseAuthService().initialize();
  runApp(
    const MyApp(),
  );
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: '/home',
        redirect: (BuildContext context, GoRouterState state) {
          if (FirebaseAuthService().currentUser == null) {
            context.go('/signin');
          } else {
            return null;
          }
        },
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'profile',
            redirect: (BuildContext context, GoRouterState state) {
              if (FirebaseAuthService().currentUser == null) {
                context.go('/signin');
              } else {
                return null;
              }
            },
            builder: (BuildContext context, GoRouterState state) {
              return const ProfilePage();
            },
          ),
        ]),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const EntryPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LogInPage();
          },
        ),
        GoRoute(
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpPage();
          },
        ),
      ],
    )
  ],
);

/// The main app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuthService().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuthService().currentUser;
              if (user != null) {
                return const HomePage();
              } else {
                return const IndexPage();
              }
            default:
              return const IndexPage();
          }
        });
  }
}
