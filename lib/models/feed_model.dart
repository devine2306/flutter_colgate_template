class FeedModel {
  FeedModel({
    this.id,
    this.title,
    this.credit,
    this.date,
    this.featurePost,
    this.content,
    this.heroImage,
  });

  final int id;
  final String title;
  final String credit;
  final DateTime date;
  final bool featurePost;

  final List<Content> content;
  final HeroImage heroImage;

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        id: json["id"],
        title: json["Title"],
        credit: json["Credit"],
        date: DateTime.parse(json["Date"]),
        featurePost: json["FeaturePost"],
        content:
            List<Content>.from(json["Content"].map((x) => Content.fromJson(x))),
        heroImage: HeroImage.fromJson(json["HeroImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Title": title,
        "Credit": credit,
        "Date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "FeaturePost": featurePost,
        "Content": List<dynamic>.from(content.map((x) => x.toJson())),
        "HeroImage": heroImage.toJson(),
      };
}

class Content {
  Content({
    this.component,
    this.id,
    this.externalUrl,
    this.date,
    this.credit,
    this.text,
  });

  final String component;
  final int id;
  final String externalUrl;
  final dynamic date;
  final dynamic credit;
  final String text;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        component: json["__component"],
        id: json["id"],
        externalUrl: json["ExternalUrl"] == null ? null : json["ExternalUrl"],
        date: json["Date"],
        credit: json["Credit"],
        text: json["Text"] == null ? null : json["Text"],
      );

  Map<String, dynamic> toJson() => {
        "__component": component,
        "id": id,
        "ExternalUrl": externalUrl == null ? null : externalUrl,
        "Date": date,
        "Credit": credit,
        "Text": text == null ? null : text,
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
  });

  final Thumbnail thumbnail;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
      };
}

class Thumbnail {
  Thumbnail({
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

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
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
