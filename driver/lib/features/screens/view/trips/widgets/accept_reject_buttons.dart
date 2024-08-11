import 'package:driver/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class AcceptAndRejectButtons extends StatelessWidget {
  const AcceptAndRejectButtons({
    super.key,
    required this.onTapAccept,
    required this.onTapReject,
    this.text1 = "Accept",
    this.text2 = "Reject",
    this.gapBtwButtons= TSizes.spaceBtwItems*2,
    this.width = 90,

    this.bottomPaddidng = 10,
    this.topPadding = 10,
    this.leftPadding = 0,
    this.rightPadding = 0,
  });

  final VoidCallback onTapAccept, onTapReject;
  final String text1, text2;
  final double gapBtwButtons, width, topPadding, bottomPaddidng, leftPadding, rightPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Accept
        ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.green[200]!),
                    fixedSize: Size.fromWidth(width),
                    padding:  EdgeInsets.only(top: topPadding, bottom: bottomPaddidng, left: leftPadding , right: rightPadding,),
                    backgroundColor: Colors.green[400],
                  ),
                  onPressed: onTapAccept,
                  child: Text(
                    text1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.white),
                  ),
                ),
       SizedBox(
          width: gapBtwButtons,
        ),

        /// Reject
        ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.red[200]!),
                    fixedSize:  Size.fromWidth(width),
                    padding: EdgeInsets.only(top: topPadding, bottom: bottomPaddidng, left: leftPadding, right: rightPadding,),
                    backgroundColor: Colors.red[400],
                  ),
                  onPressed: onTapReject,
                  child: Text(
                    text2,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.white),
                  ),
                )
      ],
    );
  }
}
