import 'package:facepass/core/router/router_app.dart';
import 'package:facepass/features/face_verification/data/datasource/remote/attendance_datasource.dart';
import 'package:facepass/features/face_verification/data/datasource/remote/faces_datasource.dart';
import 'package:facepass/features/face_verification/data/datasource/remote/users_datasource.dart';
import 'package:facepass/features/face_verification/data/repositories/attendance_repository_impl.dart';
import 'package:facepass/features/face_verification/data/repositories/recognized_repository_impl.dart';
import 'package:facepass/features/face_verification/data/repositories/recognizing_repository_impl.dart';
import 'package:facepass/features/face_verification/domain/repositories/recognized_repository.dart';
import 'package:facepass/features/face_verification/domain/repositories/recognizing_repository.dart';
import 'package:facepass/features/face_verification/domain/usecase/resgister_face.dart';
import 'package:facepass/features/face_verification/presentasion/blocs/register_user/user_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/face_verification/domain/repositories/attendace_repository.dart';
import 'features/face_verification/domain/usecase/attendance_uc.dart';
import 'features/face_verification/domain/usecase/registed_face.dart';
import 'features/face_verification/domain/usecase/resgister_user.dart';
import 'features/face_verification/presentasion/blocs/attendance/attendance_bloc.dart';
import 'features/face_verification/presentasion/blocs/recognized_faces/recognized_faces_bloc.dart';
import 'features/face_verification/presentasion/blocs/recognizing_face/recognizing_face_bloc.dart';
import 'features/face_verification/presentasion/cubit/camera_process_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // datasource
  sl.registerLazySingleton<FacesRemoteDataSource>(
    () => FacesRemoteDataSource(),
  );
  sl.registerLazySingleton<UserRemoteDatasource>(() => UserRemoteDatasource());
  sl.registerLazySingleton<AttendanceDatasource>(() => AttendanceDatasource());

  // repository
  sl.registerLazySingleton<RecognizingRepository>(
    () =>
        RecognizingRepositoryImpl(facesDatasource: sl(), userDatasource: sl()),
  );
  sl.registerLazySingleton<RecognizedRepository>(
    () => RecognizedRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AttendaceRepository>(
    () => AttendanceRepositoryImpl(remoteDataSource: sl()),
  );

  // usecase
  sl.registerLazySingleton(
    () => RegisterFaceUseCase(recognizingRepository: sl()),
  );

  sl.registerLazySingleton(
    () => RegisterUserUseCase(recognizingRepository: sl()),
  );
  sl.registerLazySingleton(() => RegistedFace(recognizedRepository: sl()));
  sl.registerLazySingleton(() => PushAttendance(repository: sl()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //tạo firebase
  await Firebase.initializeApp();
  await init();

  runApp(
    MultiBlocProvider(
      providers: [
        //Đăng kí bloc
        BlocProvider(
          create: (_) => RecognizedFacesBloc(
            registerFaceUseCase: sl(),
            registedFace: sl(),
          ),
        ),
        BlocProvider(
          create: (_) => RecognizingFaceBloc(registerFaceUseCase: sl()),
        ),
        BlocProvider(create: (_) => UserBloc(registerUserUseCase: sl())),
        BlocProvider(create: (_) => AttendanceBloc(pushAttendance: sl())),
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
    context.read<RecognizedFacesBloc>().add(LoadRecognizedFacesEvent());
    context.read<AttendanceBloc>().add(FetchAttendancesEvent());
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
