// To parse this JSON data, do
//
//     final cityNames = cityNamesFromJson(jsonString);

import 'dart:convert';

CityNames cityNamesFromJson(String str) => CityNames.fromJson(json.decode(str));

String cityNamesToJson(CityNames data) => json.encode(data.toJson());

class CityNames {
    CityNames({
        this.status,
        this.message,
        this.data,
    });

    final int? status;
    final String? message;
    final Data? data;

    factory CityNames.fromJson(Map<String, dynamic> json) => CityNames(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.record,
        this.pageToken,
        this.totalPages,
        this.currentPage,
        this.previousPage,
    });

    final List<Record>? record;
    final int? pageToken;
    final int? totalPages;
    final int? currentPage;
    final dynamic previousPage;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        record: List<Record>.from(json["Record"].map((x) => Record.fromJson(x))),
        pageToken: json["pageToken"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        previousPage: json["previousPage"],
    );

    Map<String, dynamic> toJson() => {
        "Record": List<dynamic>.from(record!.map((x) => x.toJson())),
        "pageToken": pageToken,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "previousPage": previousPage,
    };
}

class Record {
    Record({
        this.id,
        this.recordId,
        this.name,
        this.state,
        this.country,
        this.coord,
    });

    final String? id;
    final int? recordId;
    final String? name;
    final State? state;
    final String? country;
    final Coord? coord;

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["_id"],
        recordId: json["id"],
        name: json["name"],
        state: stateValues.map?[json["state"] ?? ""],
        country: json["country"],
        coord: Coord.fromJson(json["coord"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id": recordId,
        "name": name,
        "state": stateValues.reverse[state],
        "country": country,
        "coord": coord!.toJson(),
    };
}

class Coord {
    Coord({
        this.lon,
        this.lat,
    });

    final double? lon;
    final double? lat;

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
    };
}

enum State { EMPTY, GA, IA }

final stateValues = EnumValues({
    "": State.EMPTY,
    "GA": State.GA,
    "IA": State.IA
});

class EnumValues<T> {
    Map<String, T>? map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map!.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
