class NotificationModel {
  int? statusCode;
  String? message;
  List<NotificationResult>? notificationResult;
  bool? isSuccess;

  NotificationModel(
      {this.statusCode, this.message, this.notificationResult, this.isSuccess});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Result'] != null) {
      notificationResult = <NotificationResult>[];
      json['Result'].forEach((v) {
        notificationResult!.add(NotificationResult.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StatusCode'] = statusCode;
    data['Message'] = message;
    if (notificationResult != null) {
      data['Result'] = notificationResult!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = isSuccess;
    return data;
  }
}

class NotificationResult {
  String? notificationTitle;
  String? notificationDescription;
  String? notificationPhoto;
  String? notificationDate;

  NotificationResult(
      {this.notificationTitle,
      this.notificationDescription,
      this.notificationPhoto,
      this.notificationDate});

  NotificationResult.fromJson(Map<String, dynamic> json) {
    notificationTitle = json['NotificationTitle'];
    notificationDescription = json['NotificationDescription'];
    notificationPhoto = json['NotificationPhoto'];
    notificationDate = json['NotificationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['NotificationTitle'] = notificationTitle;
    data['NotificationDescription'] = notificationDescription;
    data['NotificationPhoto'] = notificationPhoto;
    data['NotificationDate'] = notificationDate;
    return data;
  }
}
