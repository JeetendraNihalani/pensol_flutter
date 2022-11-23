import 'package:flutter/material.dart';

import '../../../../widgets/app_base_screen.dart';
import '../../../../widgets/app_spacer.dart';

class NotificationDetails extends StatefulWidget {
  const NotificationDetails({
    Key? key,
    this.title,
    this.description,
    this.date,
    this.image}) : super(key: key);

  /// string title of notification
  final String? title;

  /// string description of the notification
  final String? description;

  /// string date of notification
  final String? date;

  /// string image url of notification
  final String? image;



  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {



  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      title: widget.title,
      child: ListView(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Text(widget.date ?? "",maxLines: 1,),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                    child: Image.network(widget.image ?? "https://media.istockphoto.com/photos/yellow-notification-bell-with-one-new-notification-on-blue-background-picture-id1307886792?b=1&k=20&m=1307886792&s=170667a&w=0&h=e9XSgQOrg07WPLajEaN4TFki06d6SZK3kjeDQ0NX1ic=")
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.title ?? "Title",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  AppSpacer.p16(),
                  Text(
                    widget.description ?? "Discription....",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
