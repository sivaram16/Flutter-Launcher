import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:launcher/helper/app_utils.dart';
import 'package:launcher/home_page/cubit/home_page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launcher/home_page/cubit/home_page_state.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final HomePageCubit homePageCubit = context.read<HomePageCubit>();

    return Scaffold(
      body: BlocListener(
        bloc: homePageCubit,
        listener: (BuildContext context, HomePageState state) {
          if (state is HomePageErrorState) {
            AppUtils.showToast(state.error);
          }
        },
        child: _MyHomeLayout(),
      ),
    );
  }
}

class _MyHomeLayout extends StatelessWidget {
  const _MyHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageCubit homePageCubit = context.read<HomePageCubit>();
    context.select((HomePageCubit cubit) => cubit.state);
    if (homePageCubit.state is HomePageLoadingState) {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/launcher.jpg'),
            fit: BoxFit.cover,
          )),
          child: Center(child: CircularProgressIndicator()));
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              image: DecorationImage(
                image: AssetImage('assets/launcher.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.multiply),
              )),
          child: _HomePageAppList());
    }
  }
}

class _HomePageAppList extends StatelessWidget {
  const _HomePageAppList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageCubit homePageCubit = context.read<HomePageCubit>();
    context.select(
        (HomePageCubit homePageCubit) => homePageCubit.filteredApps.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            textAlign: TextAlign.center,
            onChanged: (String value) {
              homePageCubit.onSearch(value);
            },
            decoration: InputDecoration(
              hintText: "Search Apps",
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (homePageCubit.filteredApps.isNotEmpty)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Application",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: homePageCubit.filteredApps.isEmpty
                ? Center(
                    child: Text(
                    "No Application found",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ))
                : Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 20,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: homePageCubit.filteredApps
                        .map((e) => _HomePageListItem(e))
                        .toList()),
          ),
        ),
      ],
    );
  }
}

class _HomePageListItem extends StatelessWidget {
  final Application application;
  const _HomePageListItem(this.application);

  @override
  Widget build(BuildContext context) {
    final HomePageCubit homePageCubit = context.read<HomePageCubit>();
    ApplicationWithIcon applicationWithIcon =
        application as ApplicationWithIcon;
    return SizedBox(
      height: 120,
      width: 120,
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                homePageCubit.openApp(application);
              },
              child: Container(
                  height: 80, child: Image.memory(applicationWithIcon.icon))),
          const SizedBox(
            height: 10,
          ),
          Text(
            applicationWithIcon.appName,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
