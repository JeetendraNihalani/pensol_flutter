



import '../notification_domain.dart';

abstract class NotificationRepository {

  factory NotificationRepository() => NotificationService();

  
  Future getNotification();
}