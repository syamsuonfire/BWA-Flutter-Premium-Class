part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_watch_monetization_types=flatrate";

    client ??= http.Client();
    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetail(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apiKey&language=en-US";

    client ??= http.Client();
    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) return null;

    var data = (json.decode(response.body) as Map<String, dynamic>);

    List genres = (data['genres'] as List)
        .map((e) => (e as Map<String, dynamic>)['name'].toString())
        .toList();
    String language = localeToCountryName(data['original_language']);

    return movieID != null
        ? MovieDetail(Movie.fromJson(data), language: language, genres: genres)
        : MovieDetail(movie, language: language, genres: genres);
  }

  static Future<List<Credit>> getCredits(int movieID,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$apiKey&language=en-US";

    client ??= http.Client();
    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) return null;

    var data = (json.decode(response.body) as Map<String, dynamic>);

    return (data['cast'] as List)
        .map((e) => Credit(
              name: (e as Map<String, dynamic>)['name'],
              profilePath: (e as Map<String, dynamic>)['profile_path'],
            ))
        .take(8)
        .toList();
  }
}
