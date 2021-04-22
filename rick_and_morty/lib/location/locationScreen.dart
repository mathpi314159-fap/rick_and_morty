import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/character/characterScreen.dart';
import 'package:rick_and_morty/character/characterScreenArguments.dart';
import 'package:rick_and_morty/common/errorAllert.dart';
import 'package:rick_and_morty/common/styles/textStyles.dart';
import 'package:rick_and_morty/main.dart';
import 'package:rick_and_morty/models/location.dart';
import 'package:rick_and_morty/settings.dart';

import 'bloc/actions.dart';
import 'bloc/bloc.dart';
import 'bloc/states.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = '/toLocation';

  final _id;

  LocationScreen(this._id);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var _bloc;
  Widget? _body;
  late String _title;

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<LocationBloc>(context, listen: false);
    _bloc.mapEventToState(LoadAction(widget._id));
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<LocationState>(
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
          _title = "Loading a location";
        } else {
          _body = _bodyEpisode(_bloc.repo.data.location);
          _title = _bloc.repo.data.location.name;
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

  Container _bodyEpisode(Location location) {
    print(_bloc.repo.data.persons.length);
    return Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(location.type ?? "unknown type",
                  style: TextStyles.helpGreyTextStyle),
              Text(location.dimension ?? "unknown dimension",
                  style: TextStyles.helpTextStyle),
              Text(
                "Characters",
                style: TextStyles.nameTextStyle,
              ),
              SizedBox(
                  height: 500,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                    ),
                    itemCount: _bloc.repo.data.persons.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CharacterScreen.routeName,
                                    arguments: CharacterScreenArguments(
                                        _bloc.repo.data.persons[index].id));
                              },
                              child: FadeInImage.assetNetwork(
                                  placeholder: "assets/nomen.jpg",
                                  image:
                                      _bloc.repo.data.persons[index].image)));
                    },
                  ))
            ],
          ),
        ));
  }
}
