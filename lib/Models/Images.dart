// To parse this JSON data, do
//
//     final images = imagesFromJson(jsonString);

import 'dart:convert';

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));

String imagesToJson(Images data) => json.encode(data.toJson());

class Images {
    Images({
        this.id,
        this.profiles,
    });

    int id;
    List<Profile> profiles;

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        profiles: List<Profile>.from(json["profiles"].map((x) => Profile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profiles": List<dynamic>.from(profiles.map((x) => x.toJson())),
    };
}

class Profile {
    Profile({
        this.aspectRatio,
        this.filePath,
        this.height,
        this.iso6391,
        this.voteAverage,
        this.voteCount,
        this.width,
    });

    double aspectRatio;
    String filePath;
    int height;
    dynamic iso6391;
    double voteAverage;
    int voteCount;
    int width;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "file_path": filePath,
        "height": height,
        "iso_639_1": iso6391,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
    };
}
