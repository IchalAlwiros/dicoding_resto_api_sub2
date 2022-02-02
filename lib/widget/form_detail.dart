import 'package:dicoding_submission_restoapi/data/api/ApiService.dart';
import 'package:dicoding_submission_restoapi/data/model/restaurant_post_model.dart';
import 'package:dicoding_submission_restoapi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormReviewContent extends StatefulWidget {
  final String id;
  FormReviewContent({required this.id});

  @override
  _FormReviewContentState createState() => _FormReviewContentState();
}

class _FormReviewContentState extends State<FormReviewContent> {
  Future<RestaurantPostResult>? _futurePostResto;
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _textControllerName;
  TextEditingController? _textControllerReview;

  @override
  void initState() {
    _textControllerReview = TextEditingController();
    _textControllerName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textControllerName!.dispose();
    _textControllerReview!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Beri Review Resto',
          style: titleStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        contentFormReview(),
        SizedBox(height: 20),
        contentListReview(context)
      ],
    );
  }

  Widget contentFormReview() {
    return Form(
      key: _formKey,
      child: Container(
        height: 280,
        decoration: BoxDecoration(
            //color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2.0, color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: _textControllerName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ("Please Enter Your Name");
                  }

                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter Name',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _textControllerReview,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ("Please Enter Your Review");
                  }

                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter Review',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Email: ${_textControllerName!.text}');
                    print('Password: ${_textControllerReview!.text}');

                    setState(() {
                      _futurePostResto = ApiService().createPostReview(
                          id: widget.id,
                          name: _textControllerName!.text,
                          review: _textControllerReview!.text);
                    });
                  }
                  _textControllerName!.clear();
                  _textControllerReview!.clear();
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black)),
                child: Text(
                  'Beri Review',
                  style: titleStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentListReview(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width * 2 / 2,
      child: Container(
        //color: Colors.amber,
        child: FutureBuilder<RestaurantPostResult>(
          future: _futurePostResto,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              RestaurantPostResult data = snapshot.data!;
              return ListView.separated(
                  separatorBuilder: (context, index) => VerticalDivider(
                        color: Colors.grey[300],
                        thickness: 2.0,
                        indent: 20.0,
                        endIndent: 20.0,
                        //width: 20,
                      ),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.customerReviews!.length,
                  itemBuilder: (context, index) => Container(
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${data.customerReviews![index].name}',
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '"${data.customerReviews![index].review}"',
                              style: titleStyle.copyWith(
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${data.customerReviews![index].date}',
                              style: titleStyle.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                      ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return Center(
                child: Text(
              'Berikan Riview Anda',
              style: titleStyle,
            ));
          },
        ),
      ),
    );
  }
}
