import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/character/characterScreen.dart';
import 'package:rick_and_morty/character/characterScreenArguments.dart';
import 'package:rick_and_morty/characters/bloc/states.dart';
import 'package:rick_and_morty/characters/widgets/personCell.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

import 'bloc/actions.dart';
import 'bloc/bloc.dart';

class PersonsScreen extends StatefulWidget {
  final String title = "All characters";

  @override
  _PersonsScreenState createState() => _PersonsScreenState();
}

class _PersonsScreenState extends State<PersonsScreen> {
  var _bloc;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    _bloc = Provider.of<PersonBloc>(context, listen: false);
    _bloc.mapEventToState(GetInitialPersonListAction());
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PersonState>(
        initialData: _bloc.state,
        stream: _bloc.blocStream.stream,
        builder: (context, snapShot) {
          if (snapShot.data is SuccessfulDownloadState) {
            return DraggableScrollbar.arrows(
                padding: EdgeInsets.only(right: 4.0),
                controller: controller,
                child: ListView.builder(
                  itemCount: _bloc.repo.data.persons.length,
                  controller: controller,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, CharacterScreen.routeName,
                              arguments: CharacterScreenArguments(
                                  _bloc.repo.data.persons[index].id));
                        },
                        child: PersonCell(_bloc.repo.data.persons[index]));
                  },
                ));
          }
          return Center(child: CircularProgressIndicator());
        },
      );

  void _scrollListener() {
    //print(controller.position.extentAfter);
    if ((controller.position.extentAfter < 1000) && (!_bloc.repo.isLoading)) {
      _bloc.repo.isLoading = true;
      _bloc.mapEventToState(GetPersonListAction());
    }
  }
}
