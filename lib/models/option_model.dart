class OptionModel {
  OptionModel({
    this.id,
    this.eventDivision,
  });

  final int id;
  final EventDivision eventDivision;

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
        id: json["id"],
        eventDivision: EventDivision.fromJson(json["event_division"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_division": eventDivision.toJson(),
      };
}

class EventDivision {
  EventDivision({
    this.id,
    this.name,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.eventType,
    this.image,
  });

  final int id;
  final String name;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int eventType;
  final Image image;

  factory EventDivision.fromJson(Map<String, dynamic> json) => EventDivision(
        id: json["id"],
        name: json["Name"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        eventType: json["event_type"],
        image: Image.fromJson(json["Image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "event_type": eventType,
        "Image": image.toJson(),
      };
}

class Image {
  Image({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
  });

  final int id;
  final String name;
  final String alternativeText;
  final String caption;
  final int width;
  final int height;
  final Formats formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final dynamic previewUrl;
  final String provider;
  final dynamic providerMetadata;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
      };
}

class Formats {
  Formats({
    this.thumbnail,
    this.large,
    this.medium,
    this.small,
  });

  final Large thumbnail;
  final Large large;
  final Large medium;
  final Large small;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Large.fromJson(json["thumbnail"]),
        large: Large.fromJson(json["large"]),
        medium: Large.fromJson(json["medium"]),
        small: Large.fromJson(json["small"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "large": large.toJson(),
        "medium": medium.toJson(),
        "small": small.toJson(),
      };
}

class Large {
  Large({
    this.name,
    this.hash,
    this.ext,
    this.mime,
    this.width,
    this.height,
    this.size,
    this.path,
    this.url,
  });

  final String name;
  final String hash;
  final String ext;
  final String mime;
  final int width;
  final int height;
  final double size;
  final dynamic path;
  final String url;

  factory Large.fromJson(Map<String, dynamic> json) => Large(
        name: json["name"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}
