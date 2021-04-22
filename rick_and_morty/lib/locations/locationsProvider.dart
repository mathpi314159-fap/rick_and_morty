import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';
import 'locationsScreen.dart';

class LocationsProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Provider(
      create: (context) => LocationsBloc(),
      child: LocationsScreen());
}