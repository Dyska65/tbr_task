import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_tbr/country.dart';

Future<List<Country>> getCountries() async {
  try {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    return jsonDecode(response.body)
        .cast<Map<String, dynamic>>()
        .map<Country>((json) => Country.fromJson(json))
        .toList();
  } catch (e) {
    print("Error: $e");
  }
  return [];
}
