import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmerku extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[300]!,
        period: Duration(seconds: 2),
        child: Container(
          width: 10,
          height: 10,
          decoration: ShapeDecoration(
            color: Colors.grey[400],
            shape: CircleBorder(),
          ),
        ),
      );
}
