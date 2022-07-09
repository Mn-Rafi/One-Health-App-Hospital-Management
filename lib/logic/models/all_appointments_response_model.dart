class UserAppointmentsResponseModel {
  List<Appointment>? appointment;
  String? message;

  UserAppointmentsResponseModel({this.appointment, this.message});

  UserAppointmentsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['appointment'] != null) {
      appointment = <Appointment>[];
      json['appointment'].forEach((v) {
        appointment!.add(Appointment.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appointment != null) {
      data['appointment'] = appointment!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Appointment {
  String? sId;
  String? userId;
  String? paymentId;
  String? doctorId;
  String? user;
  String? doctor;
  String? status;
  String? reason;
  String? date;
  String? time;
  int? fee;
  int? age;
  String? gender;
  String? phone;
  bool? active;
  int? iV;

  Appointment(
      {this.sId,
      this.userId,
      this.paymentId,
      this.doctorId,
      this.user,
      this.doctor,
      this.status,
      this.reason,
      this.date,
      this.time,
      this.fee,
      this.age,
      this.gender,
      this.phone,
      this.active,
      this.iV});

  Appointment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    paymentId = json['paymentId'];
    doctorId = json['doctorId'];
    user = json['user'];
    doctor = json['doctor'];
    status = json['status'];
    reason = json['reason'];
    date = json['date'];
    time = json['time'];
    fee = json['fee'];
    age = json['age'];
    gender = json['gender'];
    phone = json['phone'];
    active = json['active'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['paymentId'] = paymentId;
    data['doctorId'] = doctorId;
    data['user'] = user;
    data['doctor'] = doctor;
    data['status'] = status;
    data['reason'] = reason;
    data['date'] = date;
    data['time'] = time;
    data['fee'] = fee;
    data['age'] = age;
    data['gender'] = gender;
    data['phone'] = phone;
    data['active'] = active;
    data['__v'] = iV;
    return data;
  }
}
