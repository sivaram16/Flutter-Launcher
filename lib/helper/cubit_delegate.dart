import 'package:flutter_bloc/flutter_bloc.dart';

class EchoCubitDelegate extends BlocObserver {
  @override
  void onChange(BlocBase cubit, Change change) {
    super.onChange(cubit, change);
    print(change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}
