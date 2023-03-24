import 'package:dio/dio.dart';

Future<void> addPlace(String name) async {
  final dio = Dio();
  final url = 'http://127.0.0.1:8000/api/places/add/';
  final data = {'name': name};

  try {
    final response = await dio.post(url, data: data);
    print(response.data);
  } catch (error) {
    print(error);
  }
}

Future<List<Map<String, dynamic>>> getPlaces() async {
  final dio = Dio();
  final url = 'http://127.0.0.1:8000/api/places/';

  try {
    final Response response = await dio.get(url);
    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(response.data);
    return data;
  } catch (error) {
    print(error);
    throw Exception('Failed to get places');
  }
}
