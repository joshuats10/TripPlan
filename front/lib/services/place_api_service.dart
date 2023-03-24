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
