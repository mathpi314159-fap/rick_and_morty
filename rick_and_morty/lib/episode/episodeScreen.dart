import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/character/characterScreen.dart';
import 'package:rick_and_morty/character/characterScreenArguments.dart';
import 'package:rick_and_morty/common/errorAllert.dart';
import 'package:rick_and_morty/common/styles/textStyles.dart';
import 'package:rick_and_morty/episode/bloc/actions.dart';
import 'package:rick_and_morty/main.dart';
import 'package:rick_and_morty/models/episode.dart';
import 'package:rick_and_morty/settings.dart';

import 'bloc/bloc.dart';
import 'bloc/states.dart';

class EpisodeScreen extends StatefulWidget {
  static const routeName = '/toEpisode';

  final _id;

  EpisodeScreen(this._id);

  @override
  _EpisodeScreenState createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  var _bloc;
  Widget? _body;
  late String _title;

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<EpisodeBloc>(context, listen: false);
    _bloc.mapEventToState(LoadAction(widget._id));
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<EpisodeState>(
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
          _title = "Loading a episode";
        } else {
          _body = _bodyEpisode(_bloc.repo.data.episode);
          _title = _bloc.repo.data.episode.name;
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

  Container _bodyEpisode(Episode episode) {
    print(_bloc.repo.data.persons.length);
    return Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(episode.airDate ?? "unknown air date",
                  style: TextStyles.helpGreyTextStyle),
              Text(episode.episode ?? "unknown air episode",
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
                                  placeholder: "nomen.jpg",
                                  image:
                                      _bloc.repo.data.persons[index].image)));
                    },
                  ))
            ],
          ),
        ));
  }
}
