import 'dart:async';
import 'dart:convert';
import 'package:wildfire_tracker/models/dataModel.dart';
import 'package:http/http.dart' as http;

class NasaService {
  final _url = 'https://eonet.sci.gsfc.nasa.gov/api/v2.1/events';

  Future<List<dynamic>> getData() async {
    List<dynamic> _data;
    http.Response res = await http.get(_url);
    var events = json.decode(res.body)['events'];
    _data = events.map((data) => DataModel.fromJson(data)).toList();
    return _data.where((item) => item.categories[0].title == 'Wildfires').toList();
  }
}
