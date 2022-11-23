import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pensol/app/constants/app_spacing.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    this.title,
    this.description,
    this.date,
    this.image,
  }) : super(key: key);

  /// string title of notification
  final String? title;

  /// string description of the notification
  final String? description;

  /// string date of notification
  final String? date;

  /// string image url of notification
  final String? image;
  @override
  Widget build(BuildContext context) {
    final _random = Random();
    return ListTile(
      tileColor: Colors.primaries[_random.nextInt(Colors.primaries.length)]
              [_random.nextInt(9) * 100]
          ?.withOpacity(0.2),
      leading: Material(
        elevation: 5.0,
        shape: CircleBorder(),
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(image ?? 'https://picsum.photos/200'),
        ),
      ),
      title: Text(title ?? 'Title'),
      subtitle: Column(
        children: [
          Text(description ?? '',maxLines: 2,),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(date ?? "",maxLines: 1,),
          ),
        ],
      )
      
    );
  }
}
