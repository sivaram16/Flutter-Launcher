import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launcher/home_page/cubit/home_page_cubit.dart';
import 'package:launcher/home_page/home_page.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LauncherScreenLayout(),
    );
  }
}

class _LauncherScreenLayout extends StatelessWidget {
  const _LauncherScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dy > sensitivity) {
          // Down Swipe
        } else if (details.delta.dy < -sensitivity) {
          // Up Swipe
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => BlocProvider(
                  create: (context) {
                    return HomePageCubit()..init();
                  },
                  child: MyHomePage(),
                ),
              ));
        }
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/launcher.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 50,
            right: 50,
            left: 50,
            child: Icon(
              Icons.arrow_drop_up_sharp,
              color: Colors.white,
              size: 58,
            ),
          )
        ],
      ),
    );
  }
}
