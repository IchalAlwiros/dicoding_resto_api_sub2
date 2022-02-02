import 'package:dicoding_submission_restoapi/theme/theme.dart';
import 'package:flutter/material.dart';

class CategoryMenus extends StatelessWidget {
  final String menus;
  CategoryMenus({
    required this.menus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 120,
      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              menus,
              style: titleStyle.copyWith(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
