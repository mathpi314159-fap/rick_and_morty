import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/characters/personsScreen.dart';
import 'bloc/bloc.dart';

class PersonProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Provider(
        create: (context) => PersonBloc(),
        child: PersonsScreen());
}