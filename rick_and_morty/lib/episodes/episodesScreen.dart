import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:rick_and_morty/episode/episodeScreen.dart';
import 'package:rick_and_morty/episode/episodeScreenArguments.dart';
import 'package:rick_and_morty/episodes/widgets/episodeCell.dart';

import 'bloc/actions.dart';
import 'bloc/states.dart';
import 'bloc/bloc.dart';

class EpisodesScreen extends StatefulWidget {
  @override
  _EpisodesScreenState createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  var _bloc;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    _bloc = Provider.of<EpisodesBloc>(context, listen: false);
    _bloc.mapEventToState(GetInitialEpisodeListAction());
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<EpisodesState>(
      initialData: _bloc.state,
      stream: _bloc.blocStream.stream,
      builder: (context, snapShot) {
        if (snapShot.data is SuccessfulDownloadState) {
          return DraggableScrollbar.arrows(
              padding: EdgeInsets.only(right: 4.0),
              controller: controller,
              alwaysVisibleScrollThumb: true,
              child: ListView.builder(
                itemCount: _bloc.repo.data.episodes.length, // _bloc.repo.persons.length,
                controller: controller,
                itemBuilder: (context, index) {
                  return InkWell(onTap: () {
                    Navigator.pushNamed(
                        context, EpisodeScreen.routeName,
                        arguments: EpisodeScreenArguments(
                            _bloc.repo.data.episodes[index].id));
                  },child: EpisodeCell(_bloc.repo.data.episodes[index]));
                },
              ));
        }
        return Center(child: CircularProgressIndicator());
      });

  void _scrollListener() {
    //print(controller.position.extentAfter);
    if ((controller.position.extentAfter < 1000) && (!_bloc.repo.isLoading)) {
      _bloc.repo.isLoading = true;
      _bloc.mapEventToState(GetEpisodeListAction());
    }
  }
}
