class TopicModel {
  int _statusCode;
  String _message;
  List<Data> _data;

  topicModel({int statusCode, String message, List<Data> data}) {
    this._statusCode = statusCode;
    this._message = message;
    this._data = data;
  }

  // ignore: unnecessary_getters_setters
  int get statusCode => _statusCode;
  // ignore: unnecessary_getters_setters
  set statusCode(int statusCode) => _statusCode = statusCode;
  // ignore: unnecessary_getters_setters
  String get message => _message;
  // ignore: unnecessary_getters_setters
  set message(String message) => _message = message;
  // ignore: unnecessary_getters_setters
  List<Data> get data => _data;
  // ignore: unnecessary_getters_setters
  set data(List<Data> data) => _data = data;

  TopicModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this._statusCode;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int _id;
  int _studentClassId;
  int _subjectId;
  int _teacherId;
  String _className;
  String _subjectName;
  String _teacherName;
  String _videoName;
  String _videoLink;
  Null _videoDescription;
  int _isFree;

  Data(
      {int id,
      int studentClassId,
      int subjectId,
      int teacherId,
      String className,
      String subjectName,
      String teacherName,
      String videoName,
      String videoLink,
      Null videoDescription,
      int isFree}) {
    this._id = id;
    this._studentClassId = studentClassId;
    this._subjectId = subjectId;
    this._teacherId = teacherId;
    this._className = className;
    this._subjectName = subjectName;
    this._teacherName = teacherName;
    this._videoName = videoName;
    this._videoLink = videoLink;
    this._videoDescription = videoDescription;
    this._isFree = isFree;
  }

  // ignore: unnecessary_getters_setters
  int get id => _id;
  // ignore: unnecessary_getters_setters
  set id(int id) => _id = id;
  // ignore: unnecessary_getters_setters
  int get studentClassId => _studentClassId;
  // ignore: unnecessary_getters_setters
  set studentClassId(int studentClassId) => _studentClassId = studentClassId;
  // ignore: unnecessary_getters_setters
  int get subjectId => _subjectId;
  // ignore: unnecessary_getters_setters
  set subjectId(int subjectId) => _subjectId = subjectId;
  // ignore: unnecessary_getters_setters
  int get teacherId => _teacherId;
  // ignore: unnecessary_getters_setters
  set teacherId(int teacherId) => _teacherId = teacherId;
  // ignore: unnecessary_getters_setters
  String get className => _className;
  // ignore: unnecessary_getters_setters
  set className(String className) => _className = className;
  // ignore: unnecessary_getters_setters
  String get subjectName => _subjectName;
  // ignore: unnecessary_getters_setters
  set subjectName(String subjectName) => _subjectName = subjectName;
  // ignore: unnecessary_getters_setters
  String get teacherName => _teacherName;
  // ignore: unnecessary_getters_setters
  set teacherName(String teacherName) => _teacherName = teacherName;
  // ignore: unnecessary_getters_setters
  String get videoName => _videoName;
  // ignore: unnecessary_getters_setters
  set videoName(String videoName) => _videoName = videoName;
  // ignore: unnecessary_getters_setters
  String get videoLink => _videoLink;
  // ignore: unnecessary_getters_setters
  set videoLink(String videoLink) => _videoLink = videoLink;
  // ignore: unnecessary_getters_setters
  Null get videoDescription => _videoDescription;
  // ignore: unnecessary_getters_setters
  set videoDescription(Null videoDescription) =>
      _videoDescription = videoDescription;
  // ignore: unnecessary_getters_setters
  int get isFree => _isFree;
  // ignore: unnecessary_getters_setters
  set isFree(int isFree) => _isFree = isFree;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _studentClassId = json['student_class_id'];
    _subjectId = json['subject_id'];
    _teacherId = json['teacher_id'];
    _className = json['class_name'];
    _subjectName = json['subject_name'];
    _teacherName = json['teacher_name'];
    _videoName = json['video_name'];
    _videoLink = json['video_link'];
    _videoDescription = json['video_description'];
    _isFree = json['is_free'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['student_class_id'] = this._studentClassId;
    data['subject_id'] = this._subjectId;
    data['teacher_id'] = this._teacherId;
    data['class_name'] = this._className;
    data['subject_name'] = this._subjectName;
    data['teacher_name'] = this._teacherName;
    data['video_name'] = this._videoName;
    data['video_link'] = this._videoLink;
    data['video_description'] = this._videoDescription;
    data['is_free'] = this._isFree;
    return data;
  }
}