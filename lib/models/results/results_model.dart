class ResultModel {
  ResultModel({
    this.id,
    this.points,
    this.place,
    this.performance,
    this.usersPermissionsUser,
    this.competitor,
  });

  final int id;
  final int points;
  final int place;
  final String performance;
  final dynamic usersPermissionsUser;
  final dynamic competitor;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        id: json["id"],
        points: json["Points"],
        place: json["Place"],
        performance: json["Performance"],
        usersPermissionsUser: json["users_permissions_user"],
        competitor: json["competitor"] == null
            ? null
            : Competitor.fromJson(json["competitor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Points": points,
        "Place": place,
        "Performance": performance,
        "users_permissions_user": usersPermissionsUser,
        "competitor": competitor.toJson(),
      };
}

class Competitor {
  Competitor({
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
    this.profileImage,
  });

  final int id;
  final String fullName;
  final String firstName;
  final String lastName;
  final dynamic cheerCount;
  final dynamic points;
  final dynamic place;
  final String accountApproved;
  final String under18;
  final dynamic email;
  final int eventDivision;
  final String schoolName;
  final String schoolCity;
  final String schoolState;
  final int eventTypeOne;
  final int eventTypeTwo;
  final int eventGrade;
  final String registered;
  final DateTime dateOfBirth;
  final dynamic firstNameParent;
  final dynamic lastNameParent;
  final dynamic emailParent;
  final dynamic phoneNumberParent;
  final dynamic phoneNumber;

  final ProfileImage profileImage;

  factory Competitor.fromJson(Map<String, dynamic> json) => Competitor(
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
        eventDivision: json["eventDivision"],
        schoolName: json["SchoolName"],
        schoolCity: json["SchoolCity"],
        schoolState: json["SchoolState"],
        eventTypeOne: json["eventTypeOne"],
        eventTypeTwo: json["eventTypeTwo"],
        eventGrade: json["eventGrade"],
        registered: json["Registered"],
        dateOfBirth: DateTime.parse(json["DateOfBirth"]),
        firstNameParent: json["FirstNameParent"],
        lastNameParent: json["LastNameParent"],
        emailParent: json["EmailParent"],
        phoneNumberParent: json["PhoneNumberParent"],
        phoneNumber: json["PhoneNumber"],
        profileImage: ProfileImage.fromJson(json["ProfileImage"]),
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
        "eventDivision": eventDivision,
        "SchoolName": schoolName,
        "SchoolCity": schoolCity,
        "SchoolState": schoolState,
        "eventTypeOne": eventTypeOne,
        "eventTypeTwo": eventTypeTwo,
        "eventGrade": eventGrade,
        "Registered": registered,
        "DateOfBirth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "FirstNameParent": firstNameParent,
        "LastNameParent": lastNameParent,
        "EmailParent": emailParent,
        "PhoneNumberParent": phoneNumberParent,
        "PhoneNumber": phoneNumber,
        "ProfileImage": profileImage.toJson(),
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
  final Formats formats;
  final String hash;
  final String ext;
  final String mime;
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
