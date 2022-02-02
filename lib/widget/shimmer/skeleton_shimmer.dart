import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({ required this.height, required this.width});
  final double height, width;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            borderRadius: const BorderRadius.all(Radius.circular(16.0))),
      ),
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!);
}
