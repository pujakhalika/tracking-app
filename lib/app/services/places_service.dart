import 'package:besafe/app/models/place.dart';
import 'package:besafe/app/models/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyAfv7QfxslIG1PgvBzJSyrGXH4wHGimclw';

  Future<Iterable> getAutoComplete(String search) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=%28cities%29&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    // ignore: avoid_print
    print(json);
    var jsonResults = json['predictions'] as List;
    // ignore: avoid_print
    print("results");
    // ignore: avoid_print
    print(jsonResults.map((place) => PlaceSearch.fromJson(place)).toList());
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String? placeId) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(
      double lat, double lng, String placeType) async {
    var url =
        Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?'
            'type=$placeType&location=$lat,$lng&rankby=distance&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
