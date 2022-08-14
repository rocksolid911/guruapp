// import 'package:meta/meta.dart';
// class Subjectname {
//   final String name;

//  const Subjectname({
//    @required this.name,

// });
// }

class SubjectModel {
  List<Subjects> _subjects;

  SubjectModel({List<Subjects> subjects}) {
    this._subjects = subjects;
  }

  // List<Subjects> get subjects => _subjects;
  // set subjects(List<Subjects> subjects) => _subjects = subjects;

  SubjectModel.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      // ignore: deprecated_member_use
      _subjects = new List<Subjects>();
      json['subjects'].forEach((v) {
        _subjects.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._subjects != null) {
      data['subjects'] = this._subjects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  int _id;
  String _subjectName;
  String _createdAt;
  Null _updatedAt;

  Subjects({int id, String subjectName, String createdAt, Null updatedAt}) {
    this._id = id;
    this._subjectName = subjectName;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  // ignore: unnecessary_getters_setters
  int get id => _id;
  // ignore: unnecessary_getters_setters
  set id(int id) => _id = id;
  // ignore: unnecessary_getters_setters
  String get subjectName => _subjectName;
  // ignore: unnecessary_getters_setters
  set subjectName(String subjectName) => _subjectName = subjectName;
  // ignore: unnecessary_getters_setters
  String get createdAt => _createdAt;
  // ignore: unnecessary_getters_setters
  set createdAt(String createdAt) => _createdAt = createdAt;
  // ignore: unnecessary_getters_setters
  Null get updatedAt => _updatedAt;
  // ignore: unnecessary_getters_setters
  set updatedAt(Null updatedAt) => _updatedAt = updatedAt;

  Subjects.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _subjectName = json['subject_name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['subject_name'] = this._subjectName;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
