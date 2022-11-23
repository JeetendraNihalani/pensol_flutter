import 'package:flutter/material.dart';
import '../../app/constants/app_spacing.dart';

/// This class is a stateless widget that displays a quantity of a product
class AppQuantityWidget extends StatelessWidget {
  const AppQuantityWidget({Key? key, this.qty, this.onQtyIncrement, this.onQtyDecrement}) : super(key: key);

  /// function onQtyChanged
  final Function()? onQtyIncrement;

   /// function onQtyChanged
  final Function()? onQtyDecrement;

  /// int quantity
  final int? qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onQtyDecrement,
            child: const Icon(
              Icons.remove,
              color: Colors.white,
              size: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
            ),
            child: Text(
              '$qty',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          InkWell(
              onTap: onQtyIncrement,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              )),
        ],
      ),
    );
  }
}
