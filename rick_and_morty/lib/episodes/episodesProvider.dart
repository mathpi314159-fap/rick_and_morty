import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';
import 'episodesScreen.dart';

class EpisodesProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Provider(
      create: (context) => EpisodesBloc(),
      child: EpisodesScreen());
}