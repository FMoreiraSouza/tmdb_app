class MovieModel {
  final int id;
  final String title;
  final double voteAverage;
  final String? posterPath;
  final int? runtime;

  MovieModel({
    required this.id,
    required this.title,
    required this.voteAverage,
    this.posterPath,
    this.runtime,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      posterPath: json['poster_path'],
      runtime: json['runtime'] as int?,
    );
  }
}
