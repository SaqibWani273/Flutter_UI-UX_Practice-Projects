import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/view/dashboard.dart';
import 'package:flutter_application_1/view_model/auth_bloc/auth_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Repository/data_repo.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'view/error_screen.dart';
import 'view/loading_screen.dart';
import 'view/login_screen.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => DataRepo(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBlocBloc>(
                create: (context) =>
                    AuthBlocBloc(dataRepo: context.read<DataRepo>())
                      ..add(CheckAuthEvent()))
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          ),
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(builder: (context, state) {
      if (state is AuthenticatedState) {
        return Dashboard();
      }
      if (state is UnAuthenticatedState) {
        return LoginScreen();
      }
      if (state is AuthErrorState) {
        return ErrorScreen(
            error: "Error in Authentication. Please try again !");
      }
      return LoadingScreen();
    });
  }
}
