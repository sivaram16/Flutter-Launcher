import 'package:device_apps/device_apps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launcher/home_page/cubit/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  List<Application> apps = [];
  List<Application> filteredApps = [];
  HomePageCubit() : super(HomePageInitialState());

  void init() {
    getAppsFromDevice();
  }

  void getAppsFromDevice() async {
    emit(HomePageLoadingState());
    try {
      apps = await DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          onlyAppsWithLaunchIntent: true,
          includeSystemApps: true);
      filteredApps.addAll(apps);
    } catch (e) {
      emit(HomePageErrorState(e.toString()));
    }
    emit(HomePageRefreshState());
  }

  void openApp(Application application) {
    DeviceApps.openApp(application.packageName);
  }

  void onSearch(String value) {
    filteredApps.clear();
    for (Application application in apps) {
      if (application.appName.toLowerCase().contains(value.toLowerCase())) {
        filteredApps.add(application);
      }
    }

    emit(HomePageRefreshState());
  }
}
