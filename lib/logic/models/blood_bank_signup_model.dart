class BloodBankRegisterModel {
  final String name;
  final String age;
  final String bloodGroup;
  final String contactNumberOne;
  final String contactNumberTwo;
  final String? lastDateofDonation;
  final String location;
  final String? latitude;
  final String? longitude;
  BloodBankRegisterModel({
    required this.name,
    required this.age,
    required this.bloodGroup,
    required this.contactNumberOne,
    required this.contactNumberTwo,
    this.lastDateofDonation,
    required this.location,
    this.latitude,
    this.longitude,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'blood_group': bloodGroup,
        'contact_number_one': contactNumberOne,
        'contact_number_two': contactNumberTwo,
        'last_date_of_donation': lastDateofDonation,
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
      };
  static BloodBankRegisterModel fromJson(Map<String, dynamic> json) =>
      BloodBankRegisterModel(
        name: json['name'],
        age: json['age'],
        bloodGroup: json['blood_group'],
        contactNumberOne: json['contact_number_one'],
        contactNumberTwo: json['contact_number_two'],
        lastDateofDonation: json['last_date_of_donation'].toString(),
        location: json['location'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
}

class AmbulanceBookingResponse {
  final bool isRequested;
  final String dateTime;
  final String id;
  final String address;
  final bool? isrejected;
  AmbulanceBookingResponse(
      {required this.isRequested,
      required this.dateTime,
      required this.id,
      required this.address,
      this.isrejected});
  Map<String, dynamic> toJson() => {
        'requsted': isRequested,
        'datetime': dateTime,
        'id': id,
        'address': address,
        'isrejected': isrejected
      };
  static AmbulanceBookingResponse fromJson(Map<String, dynamic> json) =>
      AmbulanceBookingResponse(
        isRequested: json['requsted'],
        dateTime: json['datetime'],
        id: json['id'],
        address: json['address'],
        isrejected: json['isrejected'],
      );
}
