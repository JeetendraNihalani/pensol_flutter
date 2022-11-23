import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pensol/app/modules/menus/notification/providers/notification_provider.dart';
import 'package:pensol/app/modules/menus/notification/screens/notification_details.dart';
import 'package:pensol/app/modules/menus/notification/widgets/notification_tile_widget.dart';
import 'package:pensol/app/routes/route_names.dart';
import 'package:pensol/app/widgets/app_base_screen.dart';
import 'package:pensol/app/widgets/app_loading_widget.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../../app/widgets/app_spacer.dart';
import '../../../../../../app/widgets/user_info_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NotificationProvider>().getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      title: 'Notifications',
      child: Column(
        children: [
          const UserPointInfo(),
          AppSpacer.p16(),
          Expanded(
            child: Consumer<NotificationProvider>(
              builder: (context, notifications, child) {
                final _notifications = notifications.notifications;
                if (notifications.appState == AppState.loading) {
                  return const AppLoadingWidget();
                }
                if (notifications.appState == AppState.loaded) {
                  if (_notifications.notificationResult?.length != null) {
                    return ListView.builder(
                      itemCount: _notifications.notificationResult?.length,
                      itemBuilder: (context, index) {
                        final _notification =
                        _notifications.notificationResult?[index];
                        final parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                            .parse(_notification?.notificationDate ?? '');
                        final inputDate = DateTime.parse(parseDate.toString());
                        final outputFormat = DateFormat('dd-MMM-yyyy');
                        final notificationDate = outputFormat.format(inputDate);
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationDetails(
                                  title: _notification?.notificationTitle,
                                  description: _notification?.notificationDescription,
                                  image: _notification?.notificationPhoto,
                                  date: notificationDate,
                                ),
                              ),
                            );
                          },
                          child: NotificationTile(
                            title: _notification?.notificationTitle,
                            description: _notification?.notificationDescription,
                            image: _notification?.notificationPhoto,
                            date: notificationDate,
                          ),
                        );
                      },
                    );
                  }
                  else{
                    return Center(child: Lottie.asset('assets/lottie/no_data_found.json'));
                  }
                }
                else{
                  return Center(child: Lottie.asset('assets/lottie/error.json'));
                }


              },
            ),
          )
        ],
      ),
      onRefresh: () async {
      context.read<NotificationProvider>().getNotification();

      },
    );
  }
}
