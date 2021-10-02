class UsersModel {
  UsersModel({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.role,
    this.userType,
    this.profileImage,
  });

  final int id;
  final String username;
  final String email;
  final String provider;
  final bool confirmed;
  final bool blocked;
  final Role role;

  final List<UserType> userType;

  final ProfileImage profileImage;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        role: Role.fromJson(json["role"]),
        userType: List<UserType>.from(
            json["userType"].map((x) => UserType.fromJson(x))),
        profileImage: json["profileImage"] == null
            ? null
            : ProfileImage.fromJson(json["profileImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "role": role.toJson(),
        "userType": List<dynamic>.from(userType.map((x) => x.toJson())),
        "profileImage": profileImage.toJson(),
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

enum Ext { JPEG }

final extValues = EnumValues({".jpeg": Ext.JPEG});

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

class Role {
  Role({
    this.id,
    this.name,
    this.description,
    this.type,
  });

  final int id;
  final String name;
  final String description;
  final String type;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
      };
}

class UserType {
  UserType({
    this.component,
    this.id,
    this.phoneNumberParent,
    this.lastName,
    this.registered,
    this.cheerCount,
    this.points,
    this.firstNameParent,
    this.emailParent,
    this.place,
    this.eventDivision,
    this.lastNameParent,
    this.eventTypeOne,
    this.phoneNumber,
    this.eventTypeTwo,
    this.dateOfBirth,
    this.fullName,
    this.firstName,
    this.eventGrade,
    this.under18,
    this.userType,
    this.address,
    this.school,
  });

  final String component;
  final int id;
  final dynamic phoneNumberParent;
  final String lastName;
  final String registered;
  final dynamic cheerCount;
  final dynamic points;
  final dynamic firstNameParent;
  final dynamic emailParent;
  final dynamic place;
  final EventDivision eventDivision;
  final dynamic lastNameParent;
  final EventType eventTypeOne;
  final String phoneNumber;
  final EventType eventTypeTwo;
  final DateTime dateOfBirth;
  final String fullName;
  final String firstName;
  final EventGrade eventGrade;
  final String under18;
  final String userType;
  final Address address;
  final School school;

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        component: json["__component"],
        id: json["id"],
        phoneNumberParent: json["phoneNumberParent"],
        lastName: json["lastName"],
        registered: json["registered"],
        cheerCount: json["cheerCount"],
        points: json["points"],
        firstNameParent: json["firstNameParent"],
        emailParent: json["emailParent"],
        place: json["place"],
        eventDivision: json["eventDivision"] == null
            ? null
            : EventDivision.fromJson(json["eventDivision"]),
        lastNameParent: json["lastNameParent"],
        eventTypeOne: json["eventTypeOne"] == null
            ? null
            : EventType.fromJson(json["eventTypeOne"]),
        phoneNumber: json["phoneNumber"],
        eventTypeTwo: json["eventTypeTwo"] == null
            ? null
            : EventType.fromJson(json["eventTypeTwo"]),
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        fullName: json["fullName"],
        firstName: json["firstName"],
        eventGrade: json["eventGrade"] == null
            ? null
            : EventGrade.fromJson(json["eventGrade"]),
        under18: json["under18"],
        userType: json["userType"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        school: json["school"] == null ? null : School.fromJson(json["school"]),
      );

  Map<String, dynamic> toJson() => {
        "__component": component,
        "id": id,
        "phoneNumberParent": phoneNumberParent,
        "lastName": lastName,
        "registered": registered,
        "cheerCount": cheerCount,
        "points": points,
        "firstNameParent": firstNameParent,
        "emailParent": emailParent,
        "place": place,
        "eventDivision": eventDivision.toJson(),
        "lastNameParent": lastNameParent,
        "eventTypeOne": eventTypeOne.toJson(),
        "phoneNumber": phoneNumber,
        "eventTypeTwo": eventTypeTwo.toJson(),
        "dateOfBirth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "fullName": fullName,
        "firstName": firstName,
        "eventGrade": eventGrade.toJson(),
        "under18": under18,
        "address": address.toJson(),
        "school": school.toJson(),
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
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.heroImage,
  });

  final int id;
  final String name;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Image heroImage;

  factory EventType.fromJson(Map<String, dynamic> json) => EventType(
        id: json["id"],
        name: json["Name"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        heroImage: Image.fromJson(json["HeroImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "HeroImage": heroImage.toJson(),
      };
}

class School {
  School({
    this.id,
    this.schoolName,
    this.schoolCity,
    this.schoolState,
  });

  final int id;
  final String schoolName;
  final String schoolCity;
  final String schoolState;

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        schoolName: json["schoolName"],
        schoolCity: json["schoolCity"],
        schoolState: json["schoolState"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schoolName": schoolName,
        "schoolCity": schoolCity,
        "schoolState": schoolState,
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
