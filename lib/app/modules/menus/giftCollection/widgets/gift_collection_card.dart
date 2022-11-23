import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pensol/app/constants/app_spacing.dart';
import 'package:pensol/app/modules/menus/giftCollection/providers/gift_collection_provider.dart';
import 'package:pensol/app/widgets/app_elevated_button.dart';
import 'package:pensol/app/widgets/app_loading_widget.dart';
import 'package:pensol/core/api/api_constant.dart';
import 'package:pensol/core/services/permission_service.dart';
import 'package:pensol/core/utils/extensions/screen_extension.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

/// This class is a stateless widget that displays a card with a title, subtitle, and image
class GiftCollectionCard extends StatefulWidget {
  GiftCollectionCard({
    Key? key,
    this.redeemedPoints,
    this.giftName,
    this.giftQty,
    required this.index,
    this.claimDate,
    this.claimId,
  }) : super(key: key);

  /// string redemmed points
  final String? redeemedPoints;

  /// string gift name
  final String? giftName;

  /// string quantity of gifts
  final String? giftQty;

  /// string claim date
  final String? claimDate;

  /// string claim id
  final String? claimId;

  int index;
  XFile? currentFile;
  int? currentIndex;

  @override
  State<GiftCollectionCard> createState() => _GiftCollectionCardState();
}

class _GiftCollectionCardState extends State<GiftCollectionCard> {
  List<ImageGet> images = [];

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GiftCollectionProvider>();
    return SizedBox(
      height: 250,
      width: context.width,
      child: Card(
        margin: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            richTextWidget('Points: ', widget.redeemedPoints ?? ''),
            richTextWidget('Gift Name: ', widget.giftName ?? ''),
            richTextWidget('No. of Gift: ', widget.giftQty ?? ''),
            richTextWidget('Claimed Date: ', widget.claimDate ?? ''),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Consumer<GiftCollectionProvider>(
                  builder: (context, value, child) {
                    for(ImageGet object in images){
                      if(object.index == widget.index){
                        widget.currentIndex = object.index;
                        widget.currentFile = object.image;
                          return Image.file(
                            File(object.image?.path ?? ""),
                            height: 60,
                            width: 60,
                          );
                      }
                    }
                    return const Icon(
                      Icons.camera_alt,
                      size: 32,
                    );
                  },
                ),
                onPressed: () => _getFromCamera(context),
              ),
            ),
            Consumer<GiftCollectionProvider>(
              builder: (context, value, child) {
                if (value.buttonState == AppState.loading) {
                  return const AppLoadingWidget();
                }
                return AppElevatedButton(
                  'Collect',
                  onTap: () => provider.collecGift(widget.claimId!,widget.currentFile),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget richTextWidget(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.md, top: AppSpacing.sm),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: key,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Getting the image from the camera.
  _getFromCamera(BuildContext context) async {
    final permission =
        await PermissionService().getPermissionStatus(Permission.camera);
    final permissionDenied = (permission == PermissionStatus.denied ||
        permission == PermissionStatus.restricted);

    if (permissionDenied) {
      await Permission.camera.request();
    }
    if (permission == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    if (permission == PermissionStatus.granted) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        images.add(ImageGet(index : widget.index ,image: image,));
      });
      context.read<GiftCollectionProvider>().setGiftImage(image);
    }
  }
}

class ImageGet{
  int? index;
  XFile? image;

  ImageGet(
  {
    this.index,
    this.image
  });
}
