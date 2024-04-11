import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';

/*
This file contains all the routes used in the app. You can add more routes here and delete the /sample route.
*/

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => SignInScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, _) {
            GoRouter.of(context).pushReplacement("/profile");
          }),
        ],
        showPasswordVisibilityToggle: true,
      ),
    ),
    GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(
              actions: [
                SignedOutAction((context) {
                  GoRouter.of(context).pushReplacement("/");
                }),
              ],
            )),
  ],
);
