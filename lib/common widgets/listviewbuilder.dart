// import 'package:flutter/material.dart';

// // Define a custom reusable ListViewBuilder widget
// class CustomListViewBuilder extends StatelessWidget {
//   final int itemCount;
//   final IndexedWidgetBuilder itemBuilder;
//   final ScrollPhysics? physics;
//   final EdgeInsetsGeometry? padding;
//   final bool shrinkWrap;

//   const CustomListViewBuilder({
//     Key? key,
//     required this.itemCount,
//     required this.itemBuilder,
//     this.physics,
//     this.padding,
//     this.shrinkWrap = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: itemCount,
//       itemBuilder: itemBuilder,
//       physics: physics,
//       padding: padding,
//       shrinkWrap: shrinkWrap,
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomListViewBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final Axis scrollDirection;
  final ScrollController? controller;

  const CustomListViewBuilder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.physics,
    this.padding,
    this.shrinkWrap = false,
    this.scrollDirection = Axis.vertical,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      controller: controller,
      physics: physics,
      padding: padding,
      shrinkWrap: shrinkWrap,
      scrollDirection: scrollDirection,
    );
  }
}
