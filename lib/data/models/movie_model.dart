class MovieModel {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final double? popularity;
  final int? runtime;

  MovieModel({
    required this.id,
    required this.title,
    this.posterPath,
    required this.voteAverage,
    this.popularity,
    this.runtime,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      runtime: json['runtime'] as int?,
    );
  }
}
