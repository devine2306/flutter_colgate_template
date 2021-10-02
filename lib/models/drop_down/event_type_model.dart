class EventTypeModel {
  EventTypeModel({
    this.id,
    this.name,
    this.heroImage,
    this.eventDivisions,
  });

  final int id;
  final String name;

  final HeroImage heroImage;
  final List<dynamic> eventDivisions;

  factory EventTypeModel.fromJson(Map<String, dynamic> json) => EventTypeModel(
        id: json["id"],
        name: json["Name"],
        heroImage: HeroImage.fromJson(json["HeroImage"]),
        eventDivisions:
            List<dynamic>.from(json["event_divisions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "HeroImage": heroImage.toJson(),
        "event_divisions": List<dynamic>.from(eventDivisions.map((x) => x)),
      };
}

class HeroImage {
  HeroImage({
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

  factory HeroImage.fromJson(Map<String, dynamic> json) => HeroImage(
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
    this.medium,
    this.small,
  });

  final Medium thumbnail;
  final Medium medium;
  final Medium small;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Medium.fromJson(json["thumbnail"]),
        medium: Medium.fromJson(json["medium"]),
        small: Medium.fromJson(json["small"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "medium": medium.toJson(),
        "small": small.toJson(),
      };
}

class Medium {
  Medium({
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

  factory Medium.fromJson(Map<String, dynamic> json) => Medium(
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
