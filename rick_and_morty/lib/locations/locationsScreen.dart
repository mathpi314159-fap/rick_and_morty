import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:rick_and_morty/location/locationScreen.dart';
import 'package:rick_and_morty/location/locationScreenArguments.dart';
import 'package:rick_and_morty/locations/widgets/locationsCell.dart';

import 'bloc/actions.dart';
import 'bloc/states.dart';
import 'bloc/bloc.dart';

class LocationsScreen extends StatefulWidget {
  @override
  _LocationsScreenState createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  var _bloc;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    _bloc = Provider.of<LocationsBloc>(context, listen: false);
    _bloc.mapEventToState(GetInitialLocationsListAction());
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<LocationsState>(
      initialData: _bloc.state,
      stream: _bloc.blocStream.stream,
      builder: (context, snapShot) {
        if (snapShot.data is SuccessfulDownloadState) {
          return DraggableScrollbar.arrows(
              padding: EdgeInsets.only(right: 4.0),
              controller: controller,
              alwaysVisibleScrollThumb: true,
              child: ListView.builder(
                itemCount: _bloc.repo.data.locations.length, // _bloc.repo.persons.length,
                controller: controller,
                itemBuilder: (context, index) {
                  return InkWell(onTap: () {
                    Navigator.pushNamed(
                        context, LocationScreen.routeName,
                        arguments: LocationScreenArguments(
                            _bloc.repo.data.locations[index].id));
                  },child: LocationsCell(_bloc.repo.data.locations[index]));
                },
              ));
        }
        return Center(child: CircularProgressIndicator());
      });

  void _scrollListener() {
    //print(controller.position.extentAfter);
    if ((controller.position.extentAfter < 1000) && (!_bloc.repo.isLoading)) {
      _bloc.repo.isLoading = true;
      _bloc.mapEventToState(GetLocationsListAction());
    }
  }
}
