import 'package:launcher/helper/base_equatable.dart';

class HomePageState extends BaseEquatable {}

class HomePageInitialState extends HomePageState {}

class HomePageErrorState extends HomePageState {
  final String error;
  HomePageErrorState(this.error);
}

class HomePageLoadingState extends HomePageState {}

class HomePageRefreshState extends HomePageState {
  @override
  bool operator ==(Object other) => false;
}
