import 'package:dicoding_submission_restoapi/data/api/ApiService.dart';
import 'package:dicoding_submission_restoapi/data/model/restaurant_%20detail_model.dart';
import 'package:dicoding_submission_restoapi/theme/theme.dart';
import 'package:dicoding_submission_restoapi/widget/form_detail.dart';
import 'package:dicoding_submission_restoapi/widget/menus_list_card.dart';
import 'package:dicoding_submission_restoapi/widget/shimmer/skeleton_shimmer.dart';
import 'package:dicoding_submission_restoapi/widget/shimmer_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestoDetailPage extends StatelessWidget {
  final String id;
  RestoDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              mainImage(context),
              scrollContent(context),
              buttonTop(context),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavbar(context),
      ),
    );
  }

  Widget scrollContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 550),
              child: contentResto(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonTop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                  )),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.share_solid,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainImage(BuildContext context) {
    var _detailRestoProvider = Provider.of<ApiService>(context);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<RestaurantDetailResult>(
              future: _detailRestoProvider.getDetailResto(id: id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  RestaurantDetailResult data = snapshot.data!;
                  return Image.network(
                    '${ApiService.baseUrlImage}${data.restaurant!.pictureId}',
                    height: 600,
                    fit: BoxFit.cover,
                  );
                } else if (!snapshot.hasError) {
                  return DetailImageSkelton();
                }

                return Text('');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget contentResto(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(3.0, 2.0),
              blurRadius: 20,
              spreadRadius: 6.0,
              color: Colors.black.withOpacity(0.6),
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          )),
      child: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      contentRestoName(context),
                      SizedBox(height: 8),
                      contentLocation(context),
                    ],
                  ),
                  Spacer(),
                  contentRatings(context)
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  contentDrinkMenus(context),
                  SizedBox(height: 15),
                  contentFoodMenus(context),
                ],
              ),
            ),
            contentDescription(context)
          ],
        ),
      ),
    );
  }

  Widget contentRestoName(BuildContext context) {
    var _detailRestoProvider = Provider.of<ApiService>(context);
    return FutureBuilder<RestaurantDetailResult>(
      future: _detailRestoProvider.getDetailResto(id: id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          RestaurantDetailResult data = snapshot.data!;
          return Text('${data.restaurant!.name}',
              style: titleStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ));
        } else if (!snapshot.hasError) {
          return SizedBox(
            height: 50,
            width: 160,
            child: Row(
              children: [
                Row(
                  children: [
                    const Skeleton(
                      width: 100,
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return Text('');
      },
    );
  }

  Widget contentRatings(BuildContext context) {
    var _detailRestoProvider = Provider.of<ApiService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Icon(
              CupertinoIcons.star_fill,
              color: Colors.amber,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            FutureBuilder<RestaurantDetailResult>(
              future: _detailRestoProvider.getDetailResto(id: id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  RestaurantDetailResult data = snapshot.data!;
                  return Text('${data.restaurant!.rating}',
                      style: titleStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ));
                } else if (!snapshot.hasError) {
                  return SizedBox(height: 50, width: 20, child: SkeltonWrite());
                }
                return Text('');
              },
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Ratings',
          style: titleStyle.copyWith(fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget contentLocation(BuildContext context) {
    var _detailRestoProvider = Provider.of<ApiService>(context);
    return Row(
      children: [
        Icon(
          CupertinoIcons.location_solid,
          color: Colors.redAccent,
          size: 20,
        ),
        SizedBox(width: 8),
        FutureBuilder<RestaurantDetailResult>(
          future: _detailRestoProvider.getDetailResto(id: id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              RestaurantDetailResult data = snapshot.data!;
              return Text(
                '${data.restaurant!.address}',
                style: titleStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              );
            } else if (!snapshot.hasError) {
              return SizedBox(
                height: 50,
                width: 160,
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Skeleton(
                          width: 100,
                          height: 20,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            return Text('');
          },
        ),
      ],
    );
  }

  Widget contentFoodMenus(BuildContext context) {
    var _detailRestoProvider = Provider.of<ApiService>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.local_drink,
              size: 15,
            ),
            SizedBox(width: 10),
            Text(
              'Menu Minuman',
              style: titleStyle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 60,
          child: FutureBuilder<RestaurantDetailResult>(
            future: _detailRestoProvider.getDetailResto(id: id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                RestaurantDetailResult data = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: data.restaurant!.menus!.drinks!.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        CategoryMenus(
                            menus:
                                '${data.restaurant!.menus!.drinks![index].name}')
                      ],
                    );
                  },
                );
              } else if (!snapshot.hasError) {
                return SizedBox(height: 50, width: 20, child: SkeltonWrite());
              }
              return Text('');
            },
          ),
        ),
      ],
    );
  }

  Widget contentDrinkMenus(BuildContext context) {
    var _detailRestoProvider = Provider.of<ApiService>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.fastfood,
              size: 15,
            ),
            SizedBox(width: 10),
            Text(
              'Menu Makanan',
              style: titleStyle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 60,
          child: FutureBuilder<RestaurantDetailResult>(
            future: _detailRestoProvider.getDetailResto(id: id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                RestaurantDetailResult data = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: data.restaurant!.menus!.foods!.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        CategoryMenus(
                            menus:
                                '${data.restaurant!.menus!.foods![index].name}')
                      ],
                    );
                  },
                );
              } else if (!snapshot.hasError) {
                return SizedBox(height: 50, width: 20, child: SkeltonWrite());
              }
              return Text('');
            },
          ),
        ),
      ],
    );
  }

  Widget contentDescription(BuildContext context) {
    var _detailRestoProvider = Provider.of<ApiService>(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style:
                titleStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          FutureBuilder<RestaurantDetailResult>(
            future: _detailRestoProvider.getDetailResto(id: id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                RestaurantDetailResult data = snapshot.data!;
                return Text('${data.restaurant!.description}',
                    style: titleStyle);
              } else if (!snapshot.hasError) {
                return SizedBox(
                  height: 50,
                  width: 160,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Skeleton(
                            width: 100,
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return Text('');
            },
          ),
          SizedBox(height: 20),
          contetCategories(context),
          SizedBox(height: 20),
          FormReviewContent(id: id),
        ],
      ),
    );
  }

  Widget contetCategories(BuildContext context) {
    var _detailRestoProvider = Provider.of<ApiService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        FutureBuilder<RestaurantDetailResult>(
          future: _detailRestoProvider.getDetailResto(id: id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              RestaurantDetailResult data = snapshot.data!;
              return SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: data.restaurant!.categories!.length,
                  itemBuilder: (contex, index) {
                    return Text('${data.restaurant!.categories![index].name}',
                        style: titleStyle);
                  },
                ),
              );
            } else if (!snapshot.hasError) {
              return SizedBox(
                height: 50,
                width: 160,
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Skeleton(
                          width: 100,
                          height: 20,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            return Text('');
          },
        ),
      ],
    );
  }

  Widget bottomNavbar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(3.0, 6.0),
          blurRadius: 20,
          //spreadRadius: 1.0,
          color: Colors.grey,
        )
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: (){},
                child: Icon(
                  Icons.bookmark,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(60, 60),
                    primary: Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            SizedBox(
              width: 70,
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Book now',
                  style: titleStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: Color(0xff000000),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
