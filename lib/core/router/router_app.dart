import 'package:facepass/features/face_verification/presentasion/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final String initialRoute = '/';
final String cameraRoute = '/camera';
final GoRouter router = GoRouter(
  initialLocation: cameraRoute,
  routes: [
    GoRoute(
      path: cameraRoute,
      builder: (context, state) => const CameraScreen(),
    ),
  ],
);
