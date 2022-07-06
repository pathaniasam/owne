class CancelledAppointmentRequest {
  String? status;
  String? reason;

  CancelledAppointmentRequest({this.status, this.reason});

  CancelledAppointmentRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['reason'] = this.reason;
    return data;
  }
}
