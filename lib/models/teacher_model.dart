// ignore: camel_case_types
class teacher_model {
  Data _data;

  teacher_model({Data data}) {
    this._data = data;
  }

  // ignore: unnecessary_getters_setters
  Data get data => _data;
  // ignore: unnecessary_getters_setters
  set data(Data data) => _data = data;

  teacher_model.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class Data {
  List<Teachers> _teachers;

  Data({List<Teachers> teachers}) {
    this._teachers = teachers;
  }

  // List<Teachers> get teachers => _teachers;
  // set teachers(List<Teachers> teachers) => _teachers = teachers;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['teachers'] != null) {
      // ignore: deprecated_member_use
      _teachers = new List<Teachers>();
      json['teachers'].forEach((v) {
        _teachers.add(new Teachers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._teachers != null) {
      data['teachers'] = this._teachers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teachers {
  int _id;
  String _teacherName;
  Null _deletedAt;
  String _createdAt;
  String _updatedAt;

  Teachers(
      {int id,
      String teacherName,
      Null deletedAt,
      String createdAt,
      String updatedAt}) {
    this._id = id;
    this._teacherName = teacherName;
    this._deletedAt = deletedAt;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  // ignore: unnecessary_getters_setters
  int get id => _id;
  // ignore: unnecessary_getters_setters
  set id(int id) => _id = id;
  // ignore: unnecessary_getters_setters
  String get teacherName => _teacherName;
  // ignore: unnecessary_getters_setters
  set teacherName(String teacherName) => _teacherName = teacherName;
  // ignore: unnecessary_getters_setters
  Null get deletedAt => _deletedAt;
  // ignore: unnecessary_getters_setters
  set deletedAt(Null deletedAt) => _deletedAt = deletedAt;
  // ignore: unnecessary_getters_setters
  String get createdAt => _createdAt;
  // ignore: unnecessary_getters_setters
  set createdAt(String createdAt) => _createdAt = createdAt;
  // ignore: unnecessary_getters_setters
  String get updatedAt => _updatedAt;
  // ignore: unnecessary_getters_setters
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  Teachers.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _teacherName = json['teacher_name'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['teacher_name'] = this._teacherName;
    data['deleted_at'] = this._deletedAt;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}