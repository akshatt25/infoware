import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/bloc/audio_bloc.dart';
import 'package:infoware/bloc/auth_bloc.dart';
import 'package:infoware/bloc/product_bloc.dart';
import 'package:infoware/screens/bottom_nav.dart';
import 'package:infoware/screens/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
        BlocProvider<AudioBloc>(
          create: (context) => AudioBloc()..add(LoadAudioNames()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNav(),
      ),
    );
  }
}
