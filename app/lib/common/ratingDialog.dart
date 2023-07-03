import 'package:app/models/review_model..dart';
import 'package:app/services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ViewModels/userViewModel.dart';

class RatingDialog extends ConsumerStatefulWidget {
  const RatingDialog({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RatingDialogState();
}

class _RatingDialogState extends ConsumerState<RatingDialog> {
  var key = GlobalKey<FormState>();
  TextEditingController reviewController = TextEditingController();

  double rating = 5;

  @override
  Widget build(BuildContext context) {
    var userDetails = ref.watch(userProvider);

    return Center(
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 375,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rating Dialog',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: reviewController,
                    decoration: InputDecoration(
                      hintText: 'How was your experience?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorStyle: TextStyle(height: 0),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      itemSize: 40,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        this.rating = rating;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  userDetails.when(
                    data: (data) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 3,
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                        onPressed: () {
                          if (key.currentState!.validate()) {
                            ReviewModel review = ReviewModel(
                              restaurantId: widget.restaurantId,
                              review: reviewController.text,
                              rating: rating,
                              userName: data.data()!["firstName"],
                              userImg: data.data()!["profilePictureUrl"] ??
                                  "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png",
                            );

                            FirestoreService().submitReview(review);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Submit Review",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            )),
                      );
                    },
                    error: (error, stack) {
                      return Center(child: Text(error.toString()));
                    },
                    loading: () =>
                        Center(child: const CircularProgressIndicator()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
