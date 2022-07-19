class UserPrescriptonsResponseModel {
  List<Prescription>? prescription;
  String? message;

  UserPrescriptonsResponseModel({this.prescription, this.message});

  UserPrescriptonsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['prescription'] != null) {
      prescription = <Prescription>[];
      json['prescription'].forEach((v) {
        prescription!.add(Prescription.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (prescription != null) {
      data['prescription'] = prescription!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Prescription {
  String? sId;
  String? userId;
  String? doctorId;
  String? doctor;
  String? user;
  List<String>? prescribedFor;
  List<String>? medicine;
  String? date;
  List<String>? dosage;
  int? iV;

  Prescription(
      {this.sId,
      this.userId,
      this.doctorId,
      this.doctor,
      this.user,
      this.prescribedFor,
      this.medicine,
      this.date,
      this.dosage,
      this.iV});

  Prescription.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    doctorId = json['doctorId'];
    doctor = json['doctor'];
    user = json['user'];
    prescribedFor = json['prescribedFor'].cast<String>();
    medicine = json['medicine'].cast<String>();
    date = json['date'];
    dosage = json['dosage'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['doctorId'] = doctorId;
    data['doctor'] = doctor;
    data['user'] = user;
    data['prescribedFor'] = prescribedFor;
    data['medicine'] = medicine;
    data['date'] = date;
    data['dosage'] = dosage;
    data['__v'] = iV;
    return data;
  }
}
