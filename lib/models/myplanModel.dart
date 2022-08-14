class Myplanmodel {
  int id;
  int userId;
  int planId;
  int subjectId;
  int orderId;
  int studentClassId;
  String amount;
  String createdAt;
  String updatedAt;

  Myplanmodel(
      {this.id,
      this.userId,
      this.planId,
      this.subjectId,
      this.orderId,
      this.studentClassId,
      this.amount,
      this.createdAt,
      this.updatedAt});

  Myplanmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planId = json['plan_id'];
    subjectId = json['subject_id'];
    orderId = json['order_id'];
    studentClassId = json['student_class_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['plan_id'] = this.planId;
    data['subject_id'] = this.subjectId;
    data['order_id'] = this.orderId;
    data['student_class_id'] = this.studentClassId;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}