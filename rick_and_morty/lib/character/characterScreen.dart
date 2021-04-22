import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/character/widgets/CharacterCell.dart';
import 'package:rick_and_morty/common/errorAllert.dart';
import 'package:rick_and_morty/common/styles/textStyles.dart';
import 'package:rick_and_morty/episode/episodeScreen.dart';
import 'package:rick_and_morty/episode/episodeScreenArguments.dart';
import 'package:rick_and_morty/episodes/widgets/episodeCell.dart';
import 'package:rick_and_morty/location/locationScreen.dart';
import 'package:rick_and_morty/location/locationScreenArguments.dart';
import 'package:rick_and_morty/main.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/settings.dart';

import 'bloc/actions.dart';
import 'bloc/bloc.dart';
import 'bloc/states.dart';

class CharacterScreen extends StatefulWidget {
  static const routeName = '/toCharacter';

  final _id;

  CharacterScreen(this._id);

  @override
  _CharacterState createState() => _CharacterState();
}

class _CharacterState extends State<CharacterScreen> {
  var _bloc;
  Widget? _body;
  late String _title;

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<CharacterBloc>(context, listen: false);
    _bloc.mapEventToState(LoadCharacter(widget._id));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CharacterState>(
        initialData: _bloc.state,
        stream: _bloc.blocStream.stream,
        builder: (context, snapShot) {
          if (snapShot.data is FailedDownload) {
            var state = snapShot.data as FailedDownload;
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              showErrorAlertDialog(context, state.message, () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            });
            return Container(color: Settings.backgroundColor);
          }

          if (snapShot.data is InitState) {
            _body = Center(child: CircularProgressIndicator());
            _title = "Loading a character";
          } else {
            _body = _bodyCharacter(_bloc.repo.data.person);
            _title = _bloc.repo.data.person.name;
          }

          return Scaffold(
            backgroundColor: Settings.backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text(_title),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(Routes.toHome));
                  },
                )
              ],
            ),
            body: _body,
          );
        });
  }

  SingleChildScrollView _bodyCharacter(Person person) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 8, top: 8),
              child: Image.network(
                person.image ?? "assets/nomen.jpg",
                width: double.infinity,
                fit: BoxFit.fill,
              )),
          CharacterCell(
              "status", person.status ?? "unknow status", null, false),
          CharacterCell(
              "species", person.species ?? "unknow species", null, false),
          CharacterCell("type", person.type ?? "unknow type", null, false),
          CharacterCell(
              "gender", person.gender ?? "unknow gender", null, false),
          (person.origin != null)
              ? CharacterCell("origin location",
                  person.origin!.name ?? "unknow origin name", () {
                  if (person.origin!.url != null) {
                    var parts = person.origin!.url!.split('/');
                    var id = parts.last;
                    if (id.isNotEmpty) {
                      Navigator.pushNamed(context, LocationScreen.routeName,
                          arguments: LocationScreenArguments(int.parse(id)));
                    }
                  }
                }, true)
              : CharacterCell(
                  "origin location", "unknow location name", () {}, false),
          (person.location != null)
              ? CharacterCell("last known location",
                  person.location!.name ?? "unknow location name", () {
                  if (person.location!.url != null) {
                    var parts = person.location!.url!.split('/');
                    var id = parts.last;
                    if (id.isNotEmpty) {
                      Navigator.pushNamed(context, LocationScreen.routeName,
                          arguments: LocationScreenArguments(int.parse(id)));
                    }
                  }
                }, true)
              : CharacterCell(
                  "last known location", "unknow location name", () {}, false),
          Divider(
            color: Colors.white,
          ),
          Text(
            "Episodes",
            style: TextStyles.nameTextStyle,
          ),
          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: _bloc.repo.data.person.episodes.length,
              // _bloc.repo.persons.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, EpisodeScreen.routeName,
                          arguments: EpisodeScreenArguments(
                              _bloc.repo.data.person.episodes[index].id));
                    },
                    child: EpisodeCell(_bloc.repo.data.person.episodes[index]));
              },
            ),
          )
        ],
      ),
    );
  }
}
