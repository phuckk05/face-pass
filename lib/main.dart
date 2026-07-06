import 'package:facepass/features/admin/data/data_source/users_datasource.dart';
import 'package:facepass/features/admin/data/repository/user_repository_impl.dart';
import 'package:facepass/features/admin/domain/usecase/user_usecase.dart';
import 'package:facepass/features/admin/domain/repository/user_repository.dart'
    as admin_repo;
import 'package:facepass/features/admin/presentation/cubits/role_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'core/router/router_app.dart';
import 'features/admin/presentation/blocs/users/users_bloc.dart';
import 'features/auth/data/data_source/users_datasource.dart';
import 'features/auth/data/repository/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart' as auth_repo;
import 'features/auth/domain/usecase/user_usecase.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'features/face_verification/data/datasource/remote/attendance_datasource.dart';
import 'features/face_verification/data/datasource/remote/faces_datasource.dart';
import 'features/face_verification/data/datasource/remote/users_datasource.dart';
import 'features/face_verification/data/repositories/attendance_repository_impl.dart';
import 'features/face_verification/data/repositories/recognized_repository_impl.dart';
import 'features/face_verification/data/repositories/recognizing_repository_impl.dart';
import 'features/face_verification/domain/repositories/attendace_repository.dart';
import 'features/face_verification/domain/repositories/recognized_repository.dart';
import 'features/face_verification/domain/repositories/recognizing_repository.dart';
import 'features/face_verification/domain/usecase/attendance_uc.dart';
import 'features/face_verification/domain/usecase/registed_face.dart';
import 'features/face_verification/domain/usecase/resgister_face.dart';
import 'features/face_verification/domain/usecase/resgister_user.dart';
import 'features/face_verification/presentasion/blocs/attendance/attendance_bloc.dart';
import 'features/face_verification/presentasion/blocs/recognized_faces/recognized_faces_bloc.dart';
import 'features/face_verification/presentasion/blocs/recognizing_face/recognizing_face_bloc.dart';
import 'features/face_verification/presentasion/blocs/register_user/user_bloc.dart';
import 'features/face_verification/presentasion/cubit/camera_process_cubit.dart';

final sl = GetIt.instance;

const firebaseWebOptions = FirebaseOptions(
  apiKey: 'AIzaSyAe8exOjTKkFsz_SAKI0asULgRCw49Bai4',
  appId: '1:354030554787:android:7078ff32f8dceff821b916',
  messagingSenderId: '354030554787',
  projectId: 'autoshop-a65e1',
  databaseURL:
      'https://autoshop-a65e1-default-rtdb.asia-southeast1.firebasedatabase.app',
  storageBucket: 'autoshop-a65e1.firebasestorage.app',
);

Future<void> init() async {
  // datasource
  sl.registerLazySingleton<FacesRemoteDataSource>(
    () => FacesRemoteDataSource(),
  );
  sl.registerLazySingleton<UserRemoteDatasource>(() => UserRemoteDatasource());
  sl.registerLazySingleton<AttendanceDatasource>(() => AttendanceDatasource());
  sl.registerLazySingleton<UserAuthRemoteDatasource>(
    () => UserAuthRemoteDatasource(),
  );
  sl.registerLazySingleton<UserAdminRemoteDatasource>(
    () => UserAdminRemoteDatasource(),
  );

  // repository
  sl.registerLazySingleton<admin_repo.UserRepository>(
    () => UserAdminRepositoryImpl(userDatasource: sl()),
  );
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
  sl.registerLazySingleton<auth_repo.UserRepository>(
    () => UserRepositoryImpl(userDatasource: sl()),
  );

  // usecase
  sl.registerLazySingleton(
    () => UserAdminUsecase(userRepository: sl()),
  );
  sl.registerLazySingleton(
    () => RegisterFaceUseCase(recognizingRepository: sl()),
  );

  sl.registerLazySingleton(
    () => RegisterUserUseCase(recognizingRepository: sl()),
  );
  sl.registerLazySingleton(() => RegistedFace(recognizedRepository: sl()));
  sl.registerLazySingleton(() => PushAttendance(repository: sl()));
  sl.registerLazySingleton(() => UserUsecase(userRepository: sl()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //tạo firebase
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: kIsWeb ? firebaseWebOptions : null,
  );
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
        BlocProvider(
          create: (_) => AuthBloc(userUsecase: sl()),
        ),
        BlocProvider(
          create: (_) => UsersBloc(userAdminUsecase: sl()),
        ),
        //Đăng kí cubit
        BlocProvider(create: (_) => CameraProcessCubit()),
        BlocProvider(create: (_) => RoleCubit()),
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
    context.read<UsersBloc>().add(GetAllUsersEvent());

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
