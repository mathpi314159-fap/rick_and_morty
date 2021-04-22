import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/styles/textStyles.dart';
import 'package:rick_and_morty/models/episode.dart';
import 'package:rick_and_morty/settings.dart';

class EpisodeCell extends StatefulWidget {
  final Episode _episode;

  EpisodeCell(this._episode);

  @override
  _EpisodeCellState createState() => _EpisodeCellState();
}

class _EpisodeCellState extends State<EpisodeCell> {
  @override
  Widget build(BuildContext context) => Card(
        color: Settings.cellColor,
        child: Container(
          width: double.infinity,
          //height: 70,
          padding: EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget._episode.name ?? "unknown name", style: TextStyles.nameTextStyle),
              Text(widget._episode.airDate ?? "unknown air date", style: TextStyles.helpGreyTextStyle),
              Text(widget._episode.episode ?? "unknown air episode", style: TextStyles.helpTextStyle),
            ],
          )

        ),
      );
}
