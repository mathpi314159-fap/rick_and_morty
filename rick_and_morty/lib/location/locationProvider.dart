import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';
import 'locationScreen.dart';

class LocationProvider extends StatelessWidget {
  final int _id;

  LocationProvider(this._id);

  @override
  Widget build(BuildContext context) => Provider(
      create: (context) => LocationBloc(),
      child: LocationScreen(_id));
}