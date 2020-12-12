class DataModel {
  String id;
  String title;
  String description;
  String link;
  List<dynamic> categories;
  List<dynamic> sources;
  List<dynamic> geometries;

  DataModel({
    this.id,
    this.title,
    this.description,
    this.link,
    this.categories,
    this.sources,
    this.geometries,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      link: json['link'],
      categories:
          json['categories'].map((data) => Category.fromJson(data)).toList(),
      sources: json['sources'].map((data) => Source.fromJson(data)).toList(),
      geometries:
          json['geometries'].map((data) => Geometry.fromJson(data)).toList(),
    );
  }
}

class Category {
  int id;
  String title;

  Category({
    this.id,
    this.title,
  });
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
    );
  }
}

class Geometry {
  String date;
  String type;
  List<dynamic> coordinates;

  Geometry({
    this.date,
    this.type,
    this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      date: json['date'],
      type: json['type'],
      coordinates: json['coordinates'].toList(),
    );
  }
}

class Source {
  String id;
  String url;

  Source({
    this.id,
    this.url,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      url: json['url'],
    );
  }
}
