import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/styles/textStyles.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/settings.dart';

class PersonCell extends StatelessWidget {
  final Person _person;

  PersonCell(this._person);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Settings.cellColor,
      child: Container(
        width: double.infinity,
        height: 170,
        child: Row(
          children: [
            Expanded(
                child: Container(
                  child: Image.network(
                    _person.image ?? "assets/nomen.jpg",
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                flex: 2),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_person.name ?? "unknow name",
                            style: TextStyles.nameTextStyle),
                        Text(
                            (_person.status ?? "unknow status") +
                                " - " +
                                (_person.species ?? "unknow species"),
                            style: TextStyles.helpTextStyle),
                        Text("Last known location:",
                            style: TextStyles.helpGreyTextStyle),
                        Text((_person.location == null) ? "unknow location" : (_person.location!.name ?? "unknow location name"),
                            style: TextStyles.helpTextStyle),
                      ],
                    )),
                flex: 3),
          ],
        ),
      ),
    );
  }
}
