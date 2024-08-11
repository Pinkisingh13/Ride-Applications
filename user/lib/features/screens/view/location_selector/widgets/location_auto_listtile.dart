import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocationAutoListtile extends StatelessWidget {
  const LocationAutoListtile(
      {super.key, required this.onTap, required this.location});

  final VoidCallback onTap;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          horizontalTitleGap: 0,
          leading: Image(
            image: AssetImage("assets/images/drop_off.png"),
            height: 60,
          ),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
        ),
      ],
    );
  }
}
