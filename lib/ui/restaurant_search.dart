import 'package:dicoding_submission_restoapi/data/api/ApiService.dart';
import 'package:dicoding_submission_restoapi/data/model/restaurant_search_model.dart';
import 'package:dicoding_submission_restoapi/theme/theme.dart';
import 'package:dicoding_submission_restoapi/ui/restaurant_details.dart';
import 'package:dicoding_submission_restoapi/widget/shimmer_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchUser extends SearchDelegate {
  //ApiService _userSearch = ApiService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.cancel_outlined),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        size: 20,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var searchRestoProvider = Provider.of<ApiService>(context);
    return FutureBuilder<List<RestaurantSearchResult>>(
        future: searchRestoProvider.getSearchResto(name: query),
        builder: (context, snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return ListView.separated(
                itemBuilder: (context, index) => RestoCardSkelton(),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: 6);
          } else {
            if (snapshot.hasData) {
              List<RestaurantSearchResult> data = snapshot.data!;
              print('ini data dari snapshot $searchRestoProvider');
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                          height: 100,
                          width: 70,
                          image: NetworkImage(
                              "${ApiService.baseUrlImage}${searchRestoProvider.data[index]['pictureId']}"),
                        ),
                      ),
                      title: Text(
                        '${searchRestoProvider.data[index]['name']}',
                        style: titleStyle.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_solid,
                            size: 20,
                            color: Colors.redAccent,
                          ),
                          Text(
                            '${searchRestoProvider.data[index]['city']}',
                            style: titleStyle,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestoDetailPage(
                                    id: searchRestoProvider.data[index]['id'])));
                      },
                    );
                  },
                ),
              );
            } else if (!snapshot.hasError) {
              print('ini adalah ${searchRestoProvider.data}');
              return ListView.separated(
                  itemBuilder: (context, index) => RestoCardSkelton(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: 6);
            } else {
              return Text('');
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Search-bro.png',
                scale: 6.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  TextStyle get searchFieldStyle => titleStyle.copyWith(fontSize: 16);

  @override
  String get searchFieldLabel => 'Find the resto';

}



