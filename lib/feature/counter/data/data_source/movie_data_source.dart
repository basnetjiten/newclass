import 'package:dio/dio.dart';
import 'package:flutter_online_course/feature/counter/data/models/movie_card_model.dart';
import 'package:flutter_online_course/main.dart';

/// Data source where all the api calls are handled

class MovieDataSource implements MovieDataSourceAbs {
  /// initializing dio client
  /// when the object of MovieDataSource is created
  MovieDataSource() {
    _dioClient = getIt<Dio>();
  }

  late Dio _dioClient;

  /// Fetch api using dio client' get method
  @override
  Future<List<MovieCardModel>> fetchUpcomingMovies({required String upcomingMovies}) async {

    /// initializing empty map of json
    Map<String, dynamic> json = {};

    /// initializing empty list of MovieCardModel
    List<MovieCardModel> movieCardModels = [];

    /// getting the api response whose type is Response<Map<String, dynamic>>
    final Response<Map<String, dynamic>> jsonResponse =
        await _dioClient.get(upcomingMovies);

    /// checking if api json is not null
    if (jsonResponse.data != null) {
      json = jsonResponse.data!;
    }

 /// Looping through a list of results-key in a api json
    for (var result in json['results']) {
      final MovieCardModel movieCard = MovieCardModel.fromJson(result);
      movieCardModels.add(movieCard);
    }

    return movieCardModels;
  }
}

abstract class MovieDataSourceAbs {
  Future<List<MovieCardModel>> fetchUpcomingMovies({required String upcomingMovies});
}
