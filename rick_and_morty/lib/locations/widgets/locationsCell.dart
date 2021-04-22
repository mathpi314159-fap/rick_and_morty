import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/styles/textStyles.dart';
import 'package:rick_and_morty/models/location.dart';
import 'package:rick_and_morty/settings.dart';

class LocationsCell extends StatefulWidget {
  final Location _location;

  LocationsCell(this._location);

  @override
  _LocationsCellState createState() => _LocationsCellState();
}

class _LocationsCellState extends State<LocationsCell> {
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
            Text(widget._location.name ?? "unknow location name", style: TextStyles.nameTextStyle),
            Text("Type: " + (widget._location.type ?? "unknown air date"), style: TextStyles.helpGreyTextStyle),
            Text("Dimension: " + (widget._location.dimension ?? "unknown dimension"), style: TextStyles.helpGreyTextStyle),
            // Text(widget._location.episode ?? "unknown air episode", style: TextStyles.helpTextStyle),
          ],
        )

    ),
  );
}
