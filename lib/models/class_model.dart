class Classmodel {
	List<Classes> _classes;

	Classmodel(userclass, {List<Classes> classes}) {
   this._classes = classes;
}

	Classmodel.fromJson(Map<String, dynamic> json) {
		if (json['classes'] != null) {
   // ignore: deprecated_member_use
			_classes = new List<Classes>();
			json['classes'].forEach((v) { _classes.add(new Classes.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this._classes != null) {
      data['classes'] = this._classes.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Classes {
	int _id;
	int _class;
	String _createdAt;
	Null _updatedAt;

	Classes({int id, int classs, String createdAt, Null updatedAt}) {
this._id = id;
this._class = classs;
this._createdAt = createdAt;
this._updatedAt = updatedAt;
}

 // ignore: unnecessary_getters_setters
	int get id => _id;
 // ignore: unnecessary_getters_setters
	set id(int id) => _id = id;
	
	set classs(int classs) => _class = classs;
 // ignore: unnecessary_getters_setters
	String get createdAt => _createdAt;
 // ignore: unnecessary_getters_setters
	set createdAt(String createdAt) => _createdAt = createdAt;
 // ignore: unnecessary_getters_setters
	Null get updatedAt => _updatedAt;
 // ignore: unnecessary_getters_setters
	set updatedAt(Null updatedAt) => _updatedAt = updatedAt;

	Classes.fromJson(Map<String, dynamic> json) {
		_id = json['id'];
		_class = json['class'];
		_createdAt = json['created_at'];
		_updatedAt = json['updated_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this._id;
		data['class'] = this._class;
		data['created_at'] = this._createdAt;
		data['updated_at'] = this._updatedAt;
		return data;
	}
}