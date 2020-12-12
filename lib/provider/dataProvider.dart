import 'package:flutter/cupertino.dart';
import 'package:wildfire_tracker/services/dataFetchService.dart';

class DataProvider with ChangeNotifier {
  final _nasaService = NasaService();
  Stream<List<dynamic>> allCordinates() async* {
    yield await _nasaService.getData();
  }
}
