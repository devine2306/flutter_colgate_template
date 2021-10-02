class CompetitorModel {
  CompetitorModel({
    this.id,
    this.fullName,
    this.firstName,
    this.lastName,
    this.cheerCount,
    this.points,
    this.place,
    this.accountApproved,
    this.under18,
    this.email,
    this.eventDivision,
    this.schoolName,
    this.schoolCity,
    this.schoolState,
    this.eventTypeOne,
    this.eventTypeTwo,
    this.eventGrade,
    this.registered,
    this.dateOfBirth,
    this.firstNameParent,
    this.lastNameParent,
    this.emailParent,
    this.phoneNumberParent,
    this.phoneNumber,
    this.regId,
    this.address,
    this.profileImage,
  });

  final int id;
  final String fullName;
  final String firstName;
  final String lastName;
  final int cheerCount;
  final String points;
  final int place;
  final String accountApproved;
  final String under18;
  final dynamic email;
  final EventDivision eventDivision;
  final String schoolName;
  final String schoolCity;
  final String schoolState;
  final EventType eventTypeOne;
  final EventType eventTypeTwo;
  final EventGrade eventGrade;
  final String registered;
  final DateTime dateOfBirth;
  final String firstNameParent;
  final String lastNameParent;
  final String emailParent;
  final String phoneNumberParent;
  final String phoneNumber;
  final dynamic regId;
  final Address address;
  final ProfileImage profileImage;

  factory CompetitorModel.fromJson(Map<String, dynamic> json) =>
      CompetitorModel(
        id: json["id"],
        fullName: json["FullName"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        cheerCount: json["CheerCount"],
        points: json["Points"],
        place: json["Place"],
        accountApproved: json["AccountApproved"],
        under18: json["Under18"],
        email: json["Email"],
        eventDivision: EventDivision.fromJson(json["eventDivision"]),
        schoolName: json["SchoolName"],
        schoolCity: json["SchoolCity"],
        schoolState: json["SchoolState"],
        eventTypeOne: json["eventTypeOne"] == null
            ? null
            : EventType.fromJson(json["eventTypeOne"]),
        eventTypeTwo: json["eventTypeTwo"] == null
            ? null
            : EventType.fromJson(json["eventTypeTwo"]),
        eventGrade: json["eventGrade"] == null
            ? null
            : EventGrade.fromJson(json["eventGrade"]),
        registered: json["Registered"],
        dateOfBirth: json["DateOfBirth"] == null
            ? null
            : DateTime.parse(json["DateOfBirth"]),
        firstNameParent: json["FirstNameParent"],
        lastNameParent: json["LastNameParent"],
        emailParent: json["EmailParent"],
        phoneNumberParent: json["PhoneNumberParent"],
        phoneNumber: json["PhoneNumber"],
        regId: json["regId"],
        address:
            json["Address"] == null ? null : Address.fromJson(json["Address"]),
        profileImage: json["ProfileImage"] == null
            ? null
            : ProfileImage.fromJson(json["ProfileImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "FullName": fullName,
        "FirstName": firstName,
        "LastName": lastName,
        "CheerCount": cheerCount,
        "Points": points,
        "Place": place,
        "AccountApproved": accountApproved,
        "Under18": under18,
        "Email": email,
        "eventDivision": eventDivision.toJson(),
        "SchoolName": schoolName,
        "SchoolCity": schoolCity,
        "SchoolState": schoolState,
        "eventTypeOne": eventTypeOne.toJson(),
        "eventTypeTwo": eventTypeTwo.toJson(),
        "eventGrade": eventGrade.toJson(),
        "Registered": registered,
        "DateOfBirth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "FirstNameParent": firstNameParent,
        "LastNameParent": lastNameParent,
        "EmailParent": emailParent,
        "PhoneNumberParent": phoneNumberParent,
        "PhoneNumber": phoneNumber,
        "regId": regId,
        "Address": address.toJson(),
        "ProfileImage": profileImage.toJson(),
      };
}

class Address {
  Address({
    this.id,
    this.addressStreet,
    this.addressCity,
    this.addressState,
    this.addressZipCode,
    this.addressApartmentNo,
  });

  final int id;
  final String addressStreet;
  final String addressCity;
  final String addressState;
  final int addressZipCode;
  final String addressApartmentNo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        addressStreet: json["AddressStreet"],
        addressCity: json["AddressCity"],
        addressState: json["AddressState"],
        addressZipCode: json["AddressZipCode"],
        addressApartmentNo: json["AddressApartmentNo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "AddressStreet": addressStreet,
        "AddressCity": addressCity,
        "AddressState": addressState,
        "AddressZipCode": addressZipCode,
        "AddressApartmentNo": addressApartmentNo,
      };
}

class EventDivision {
  EventDivision({
    this.id,
    this.name,
    this.eventType,
    this.image,
  });

  final int id;
  final String name;

  final int eventType;
  final Image image;

  factory EventDivision.fromJson(Map<String, dynamic> json) => EventDivision(
        id: json["id"],
        name: json["Name"],
        eventType: json["event_type"],
        image: json["Image"] == null ? null : Image.fromJson(json["Image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
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
  final ImageFormats formats;
  final String hash;
  final Ext ext;
  final Mime mime;
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
        formats: ImageFormats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
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
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
      };
}

enum Ext { JPEG }

final extValues = EnumValues({".jpeg": Ext.JPEG});

class ImageFormats {
  ImageFormats({
    this.thumbnail,
    this.large,
    this.medium,
    this.small,
  });

  final Thumbnail thumbnail;
  final Thumbnail large;
  final Thumbnail medium;
  final Thumbnail small;

  factory ImageFormats.fromJson(Map<String, dynamic> json) => ImageFormats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        large: json["large"] == null ? null : Thumbnail.fromJson(json["large"]),
        medium: Thumbnail.fromJson(json["medium"]),
        small: Thumbnail.fromJson(json["small"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "large": large == null ? null : large.toJson(),
        "medium": medium.toJson(),
        "small": small.toJson(),
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
  final Ext ext;
  final Mime mime;
  final int width;
  final int height;
  final double size;
  final dynamic path;
  final String url;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        name: json["name"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}

enum Mime { IMAGE_JPEG }

final mimeValues = EnumValues({"image/jpeg": Mime.IMAGE_JPEG});

class EventGrade {
  EventGrade({
    this.id,
    this.grade,
    this.eventDivision,
  });

  final int id;
  final String grade;
  final int eventDivision;

  factory EventGrade.fromJson(Map<String, dynamic> json) => EventGrade(
        id: json["id"],
        grade: json["Grade"],
        eventDivision: json["event_division"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Grade": grade,
        "event_division": eventDivision,
      };
}

class EventType {
  EventType({
    this.id,
    this.name,
    this.heroImage,
  });

  final int id;
  final String name;
  final Image heroImage;

  factory EventType.fromJson(Map<String, dynamic> json) => EventType(
        id: json["id"],
        name: json["Name"],
        heroImage: json["HeroImage"] == null
            ? null
            : Image.fromJson(json["HeroImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "HeroImage": heroImage.toJson(),
      };
}

class ProfileImage {
  ProfileImage({
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
  final ProfileImageFormats formats;
  final String hash;
  final Ext ext;
  final Mime mime;
  final double size;
  final String url;
  final dynamic previewUrl;
  final String provider;
  final dynamic providerMetadata;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: ProfileImageFormats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
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
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
      };
}

class ProfileImageFormats {
  ProfileImageFormats({
    this.thumbnail,
  });

  final Thumbnail thumbnail;

  factory ProfileImageFormats.fromJson(Map<String, dynamic> json) =>
      ProfileImageFormats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
