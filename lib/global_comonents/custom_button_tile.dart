import 'package:flutter/material.dart';

import '../settings/constants.dart';

class ButtonTile extends StatelessWidget {
  const ButtonTile({
    super.key,
    required this.title,
    this.leading,
    this.traling,
    required this.onTap,
    this.color,
  });

  final String title;
  final Widget? leading;
  final Widget? traling;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: Container(
        // width: MediaQuery.of(context).size.width *,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: color ?? Color(0xFFEFF2F5),
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   color: Constants.white,
          // ),
        ),
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            minVerticalPadding: 0.0,
            leading: leading,
            title: Container(
              width: 100,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color != null ? Constants.white : null,
                ),
                // maxLines: 2,
              ),
            ),
            trailing: traling,
          ),
        ),
      ),
    );
  }
}
