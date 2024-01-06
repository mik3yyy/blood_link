import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';

class CustomListContainer extends StatefulWidget {
  const CustomListContainer(
      {super.key, required this.child, required this.index});

  final Widget child;
  final int index;

  @override
  State<CustomListContainer> createState() => _CustomListContainerState();
}

class _CustomListContainerState extends State<CustomListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 36,
      color: widget.index % 2 == 0
          ? Constants.grey.withOpacity(0.3)
          : Constants.white,
      // width: 400,
      child: widget.child,
    );
  }
}
