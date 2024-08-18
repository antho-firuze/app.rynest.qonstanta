import 'package:qonstanta/helpers/extensions.dart';
import 'package:qonstanta/enums/reference.dart';

class Profile {
  int? id;
  String? memberId;
  String? cardNo;
  String? fullName;
  String? placeOfBirth;
  DateTime? dateOfBirth;
  String? gender;
  String? phone;
  String? email;
  bool? isActivated;
  String? photo;
  String? photoIdCard;
  String? photoEnc;

  Profile({
    this.id,
    this.memberId,
    this.cardNo,
    this.fullName,
    this.placeOfBirth,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.email,
    this.isActivated,
    this.photo,
    this.photoIdCard,
    this.photoEnc,
  });

  factory Profile.fromJson(Map<dynamic, dynamic> json) => Profile(
        id: json['id'] ?? 0,
        memberId: json['member_id'] ?? '',
        cardNo: json['identity_card'] ?? '',
        fullName: json['fullname'],
        placeOfBirth: json['place_of_birth'],
        dateOfBirth: [null, ''].contains(json['date_of_birth'])
            ? null
            : DateTime.parse(json['date_of_birth']),
        gender: [null, ''].contains(json['gender'])
            ? ''
            : listGender[json['gender'] is String
                ? int.parse(json['gender'])
                : json['gender']],
        phone: json['phone'] ?? '',
        email: json['email'] ?? '',
        photo: json['photo'] ?? '',
        photoEnc: json['photo_enc'] ?? '',
        photoIdCard: json['photo_idcard'] ?? '',
        isActivated: json['is_activated'] == '1',
      );

  Map<String, dynamic> toJson() => {
        // "member_id": memberId,
        // "identity_card": cardNo,
        "fullname": fullName,
        "place_of_birth": placeOfBirth,
        "date_of_birth": dateOfBirth!.asFormatDBDate(),
        "gender": listGender.indexOf(gender!),
        "phone": phone,
        "email": email,
      };

  Map<String, dynamic> toJsonLocal() => {
        "id": id,
        "fullname": fullName,
        "place_of_birth": placeOfBirth == null ? '' : placeOfBirth,
        "date_of_birth": [null, ''].contains(dateOfBirth)
            ? ''
            : dateOfBirth!.asFormatDBDate(),
        "gender":
            [null, ''].contains(gender) ? '' : listGender.indexOf(gender!),
        "phone": [null, ''].contains(phone) ? '' : phone,
        "email": [null, ''].contains(email) ? '' : email,
        "photo_enc": [null, ''].contains(photoEnc) ? '' : photoEnc,
      };

  Profile initialize() {
    return Profile(fullName: '', email: '', photo: '', photoEnc: '');
  }
}
