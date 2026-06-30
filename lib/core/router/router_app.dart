import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:facepass/features/face_verification/presentasion/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/presentation/screens/admin_home_screen.dart';
import '../../features/admin/presentation/screens/grant_account_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/setup_screen.dart';
import '../../features/face_verification/presentasion/screens/home_screen.dart';
import '../../features/face_verification/presentasion/screens/timeline_screen.dart';
import '../../features/manager/presentation/screens/manager_home_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
//path
final String initialRoute = '/';

final String loginRoute = '/login';
final String registerRoute = '/register';

final String homeRoute = '/home';
final String adminHomeRoute = '/admin-home';
final String grantAccountRoute = '/grant-account';

final String managerHomeRoute = '/manager-home';

final String setupRoute = '/setup';

final String cameraRoute = '/camera';
final String timelineRoute = '/timeline';
//name

final String loginRouteName = 'login';
final String registerRouteName = 'register';

final String setupRouteName = 'setup';

final String homeRouteName = 'home';
final String adminHomeRouteName = 'admin-home';
final String grantAccountRouteName = 'grant-account';

final String managerHomeRouteName = 'manager-home';

final String cameraRouteName = 'camera';
final String timelineRouteName = 'timeline';
final GoRouter router = GoRouter(
  initialLocation: loginRoute,
  routes: [
    GoRoute(
      path: loginRoute,
      name: loginRouteName,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: registerRoute,
      name: registerRouteName,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: homeRoute,
      name: homeRouteName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: adminHomeRoute,
      name: adminHomeRouteName,
      builder: (context, state) => const AdminHomeScreen(),
    ),
    GoRoute(
      path: grantAccountRoute,
      name: grantAccountRouteName,
      builder: (context, state) => GrantAccountScreen(),
    ),
    GoRoute(
      path: setupRoute,
      name: setupRouteName,
      builder: (context, state) {
        final user = state.extra != null && state.extra is Map<String, dynamic>
            ? (state.extra as Map<String, dynamic>)['user'] as User
            : null;
        if (user == null) {
          return LoginScreen();
        }
        return SetupScreen(user: user);
      },
    ),
    GoRoute(
        path: cameraRoute,
        name: cameraRouteName,
        builder: (context, state) {
          final user =
              state.extra != null && state.extra is Map<String, dynamic>
                  ? (state.extra as Map<String, dynamic>)['user'] as User
                  : null;
          final index =
              state.extra != null && state.extra is Map<String, dynamic>
                  ? (state.extra as Map<String, dynamic>)['index'] as int
                  : 1;

          if (user == null) return LoginScreen();

          return CameraScreen(
            index: index,
            user: user,
          );
        }),
    GoRoute(
      path: timelineRoute,
      name: timelineRouteName,
      builder: (context, state) => const TimelineScreen(),
    ),
    GoRoute(
      path: managerHomeRoute,
      name: managerHomeRouteName,
      builder: (context, state) => const ManagerHomeScreen(),
    )
  ],
);
