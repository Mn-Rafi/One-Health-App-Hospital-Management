class AllDepartmentsResponseModel {
  List<Department>? department;
  String? message;

  AllDepartmentsResponseModel({this.department, this.message});

  AllDepartmentsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['department'] != null) {
      department = <Department>[];
      json['department'].forEach((v) {
        department!.add(Department.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (department != null) {
      data['department'] = department!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Department {
  String? sId;
  String? name;
  List<String>? doctors;
  int? iV;

  Department({this.sId, this.name, this.doctors, this.iV});

  Department.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    doctors = json['doctors'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['doctors'] = doctors;
    data['__v'] = iV;
    return data;
  }
}
