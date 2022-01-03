class ConfPoolPlayerResult {
  String name;
  String name_appendage;
  int rank;
  String rank_dsply;
  int points;

  ConfPoolPlayerResult(
      this.name, this.name_appendage, this.rank, this.rank_dsply, this.points);

  factory ConfPoolPlayerResult.fromJson(dynamic json) {
    return ConfPoolPlayerResult(
        json['name'] as String,
        json['name_appendage'] as String,
        json['rank'] as int,
        json['rank_dsply'] as String,
        json['points'] as int);
  }
}

class ConfPoolResult {
  String title;
  String message;
  List<ConfPoolPlayerResult> results;

  ConfPoolResult(this.title, this.message, [this.results]);

  factory ConfPoolResult.fromJSON(dynamic json) {
    if (json['results'] != null) {
      var resultsObjJson = json['results'] as List;
      List<ConfPoolPlayerResult> _results = resultsObjJson
          .map((resultsJson) => ConfPoolPlayerResult.fromJson(resultsJson))
          .toList();

      return ConfPoolResult(
          json['title'] as String, json['msg'] as String, _results);
    } else {
      return ConfPoolResult(json['title'] as String, json['msg'] as String);
    }
  }
  @override
  String toString() {
    return '{${this.title}, ${this.message}, ${this.results}}';
  }
}
