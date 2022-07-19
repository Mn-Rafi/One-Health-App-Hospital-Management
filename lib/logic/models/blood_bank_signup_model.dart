class BloodBankRegisterModel {
  final String name;
  final String age;
  final String bloodGroup;
  final String contactNumberOne;
  final String contactNumberTwo;
  final DateTime? lastDateofDonation;
  final String location;
  BloodBankRegisterModel({
    required this.name,
    required this.age,
    required this.bloodGroup,
    required this.contactNumberOne,
    required this.contactNumberTwo,
    this.lastDateofDonation,
    required this.location,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'blood_group': bloodGroup,
        'contact_number_one': contactNumberOne,
        'contact_number_two': contactNumberTwo,
        'last_date_of_donation': lastDateofDonation,
        'location': location,
      };
  BloodBankRegisterModel fromJson(Map<String, dynamic> json) =>
      BloodBankRegisterModel(
        name: json['name'],
        age: json['age'],
        bloodGroup: json['blood_group'],
        contactNumberOne: json['contact_number_one'],
        contactNumberTwo: json['contact_number_two'],
        lastDateofDonation: json['last_date_of_donation'],
        location: json['location'],
      );
}
