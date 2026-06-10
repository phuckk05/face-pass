import 'package:facepass/features/face_verification/presentasion/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/face_verification/presentasion/screens/home_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
//path
final String initialRoute = '/';
final String homeRoute = '/home';
final String cameraRoute = '/camera:index';
//name
final String homeRouteName = 'home';
final String cameraRouteName = 'camera';
final GoRouter router = GoRouter(
  initialLocation: homeRoute,
  routes: [
    GoRoute(
      path: homeRoute,
      name: homeRouteName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: cameraRoute,
      name: cameraRouteName,
      builder: (context, state) => CameraScreen(
        index: state.pathParameters['index'] != null
            ? int.parse(state.pathParameters['index']!)
            : 0,
      ),
    ),
  ],
);
