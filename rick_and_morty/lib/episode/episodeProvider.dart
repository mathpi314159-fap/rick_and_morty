import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';
import 'episodeScreen.dart';

class EpisodeProvider extends StatelessWidget {
  final int _id;

  EpisodeProvider(this._id);

  @override
  Widget build(BuildContext context) => Provider(
      create: (context) => EpisodeBloc(),
      child: EpisodeScreen(_id));
}