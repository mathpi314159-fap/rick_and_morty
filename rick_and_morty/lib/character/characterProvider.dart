import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';
import 'characterScreen.dart';

class CharacterProvider extends StatefulWidget {
  final int _id;

  CharacterProvider(this._id);

  @override
  _CharacterProviderState createState() => _CharacterProviderState();
}

class _CharacterProviderState extends State<CharacterProvider> {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => CharacterBloc(),
        child: CharacterScreen(widget._id));
  }
}