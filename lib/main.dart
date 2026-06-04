import 'package:facepass/core/router/router_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/face_verification/presentasion/blocs/recognized_faces/recognized_faces_bloc.dart';
import 'features/face_verification/presentasion/blocs/recognizing_face/recognizing_face_bloc.dart';
import 'features/face_verification/presentasion/cubit/camera_process_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        //Đăng kí bloc
        BlocProvider(create: (_) => RecognizedFacesBloc()),
        BlocProvider(create: (_) => RecognizingFaceBloc()),
        //Đăng kí cubit
        BlocProvider(create: (_) => CameraProcessCubit()),
      ],
      child: const FacePass(),
    ),
  );
}

class FacePass extends StatelessWidget {
  const FacePass({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // builder: DevicePreview.appBuilder,
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      routerConfig: router,
      title: 'FacePass',
      debugShowCheckedModeBanner: false,
    );
  }
}
