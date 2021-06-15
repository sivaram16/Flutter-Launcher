import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launcher/helper/cubit_delegate.dart';
import 'package:launcher/my_app.dart';

void main() {
  runApp(MyApp());
  Bloc.observer = EchoCubitDelegate();
}
