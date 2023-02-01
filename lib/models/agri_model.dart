// To parse this JSON data, do
//
//     final agriApi = agriApiFromJson(jsonString);

import 'dart:convert';

AgriApi agriApiFromJson(String str) => AgriApi.fromJson(json.decode(str));

String agriApiToJson(AgriApi data) => json.encode(data.toJson());

class AgriApi {
  AgriApi({
    required this.success,
    required this.code,
    required this.data,
    required this.meta,
  });

  bool success;
  int code;
  List<Datum> data;
  Meta meta;

  factory AgriApi.fromJson(Map<String, dynamic> json) => AgriApi(
        success: json["success"],
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.language,
    required this.category,
    required this.author,
    required this.title,
    required this.description,
    required this.mediaslug,
    required this.readMoreUrl,
    required this.source,
    this.sponsored,
    this.sponsoredby,
    required this.createdAt,
    this.categories,
    required this.type,
  });

  String id;
  Language language;
  List<int> category;
  Author author;
  String title;
  String description;
  String mediaslug;
  String readMoreUrl;
  String source;
  dynamic sponsored;
  dynamic sponsoredby;
  DateTime createdAt;
  dynamic categories;
  Type type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        language: languageValues.map[json["language"]]!,
        category: List<int>.from(json["category"].map((x) => x)),
        author: authorValues.map[json["author"]]!,
        title: json["title"],
        description: json["description"],
        mediaslug: json["mediaslug"],
        readMoreUrl: json["readMoreUrl"],
        source: json["source"],
        sponsored: json["sponsored"],
        sponsoredby: json["sponsoredby"],
        createdAt: DateTime.parse(json["createdAt"]),
        categories: json["categories"],
        type: typeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": languageValues.reverse[language],
        "category": List<dynamic>.from(category.map((x) => x)),
        "author": authorValues.reverse[author],
        "title": title,
        "description": description,
        "mediaslug": mediaslug,
        "readMoreUrl": readMoreUrl,
        "source": source,
        "sponsored": sponsored,
        "sponsoredby": sponsoredby,
        "createdAt": createdAt.toIso8601String(),
        "categories": categories,
        "type": typeValues.reverse[type],
      };
}

enum Author { AGRISHOTS }

final authorValues = EnumValues({"Agrishots": Author.AGRISHOTS});

enum Language { EN }

final languageValues = EnumValues({"en": Language.EN});

enum Type { ARTICLE }

final typeValues = EnumValues({"article": Type.ARTICLE});

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
    required this.total,
  });

  int currentPage;
  int totalPages;
  int perPage;
  int total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        perPage: json["perPage"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalPages": totalPages,
        "perPage": perPage,
        "total": total,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
