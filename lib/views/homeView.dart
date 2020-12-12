import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' show LatLng;
import 'package:provider/provider.dart';
import 'package:wildfire_tracker/models/dataModel.dart';
import 'package:wildfire_tracker/provider/dataProvider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _showModel(BuildContext context, DataModel data) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 200,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(0.0),
                  color: Colors.purpleAccent,
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      data.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'ID: ${data.id}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  final MapController _mapController = MapController();

  List<Marker> _getAllMarkers(List data) {
    List<Marker> _list = <Marker>[];
    data.forEach((element) {
      try {
        _list.add(
          Marker(
            point: LatLng(element.geometries[0].coordinates[1],
                element.geometries[0].coordinates[0]),
            builder: (context) => Container(
              child: InkWell(
                onTap: () {
                  _mapController.move(
                    LatLng(
                      element.geometries[0].coordinates[1],
                      element.geometries[0].coordinates[0],
                    ),
                    17,
                  );
                  _showModel(context, element);
                },
                child: Image.asset(
                  'images/flame.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
        );
      } catch (e) {}
    });
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: _dataProvider.allCordinates(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FlutterMap(
              mapController: _mapController,
              options: new MapOptions(
                maxZoom: 17,
                zoom: 2,
                interactive: true,
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate:
                      'Map-Box Third Party URL here',
                  additionalOptions: {
                    'accessToken':
                        'Your Api-Token Here',
                    'id': 'Mapbox Map id here'
                  },
                ),
                MarkerLayerOptions(
                  markers: [
                    ..._getAllMarkers(snapshot.data),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error Occoured Wile Fetch Data: ${snapshot.error}');
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
