import 'package:equatable/equatable.dart';

class BaseEquatable extends Equatable {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    // ignore: no_runtimetype_tostring
    return runtimeType.toString();
  }
}
