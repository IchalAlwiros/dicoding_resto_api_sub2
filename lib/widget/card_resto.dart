import 'package:dicoding_submission_restoapi/data/api/ApiService.dart';
import 'package:dicoding_submission_restoapi/theme/theme.dart';
import 'package:dicoding_submission_restoapi/ui/restaurant_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_submission_restoapi/data/model/restaurant_list_model.dart';

class CardTopResto extends StatelessWidget {
  final Restaurants restaurant;

  CardTopResto({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestoDetailPage(id: restaurant.id!),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: 250,
          margin: EdgeInsets.only(right: 20, left: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3.0, 6.0),
                blurRadius: 8.0,
                //spreadRadius: 1.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // add this

            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                    ("${ApiService.baseUrlImage}${restaurant.pictureId}"),
                    height: 120,
                    fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 2, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${restaurant.name!}\n',
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: restaurant.city,
                              style: titleStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 2, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.star_fill,
                          size: 16,
                          color: Colors.amberAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('(${restaurant.ratings})')
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
