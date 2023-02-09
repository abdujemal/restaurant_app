import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';
import 'package:restaurant_app/features/Authentication/presentation/widget/auth_input.dart';
import 'package:restaurant_app/features/Database/data/models/review_model.dart';

import '../../../Authentication/presentation/bloc/login_controller/login_bloc.dart';
import '../../data/models/food_model.dart';
import '../controller/food controlelr/food_bloc.dart';

class AddReviewBottomSheet extends StatefulWidget {
  FoodModel foodModel;
  AddReviewBottomSheet({super.key, required this.foodModel});

  @override
  State<AddReviewBottomSheet> createState() => _AddReviewBottomSheetState();
}

class _AddReviewBottomSheetState extends State<AddReviewBottomSheet> {
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Add Review",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          AuthInput(
              isObsqure: false,
              controller: reviewController,
              prefixIconData: Icons.chat,
              hint: "What do you think"),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<FoodBloc, FoodState>(
            listener: (context, state) {
              if (state.addReviewState == RequestState.error) {
                Constants.toast(state.addReviewError, ToastType.error);
              }

              if (state.addReviewState == RequestState.loaded) {
                Constants.toast(
                    "You have added your review", ToastType.success);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return state.addReviewState == RequestState.loading
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    )
                  : TextButton(
                      onPressed: () {
                        UserModel currentUser =
                            context.read<LoginBloc>().state.currentUser!;

                        DateTime dateTime = DateTime.now();
                        String date =
                            DateFormat("MMMM dd, yyyy").format(dateTime);
                        context.read<FoodBloc>().add(AddReviewEvent(ReviewModel(
                            image: currentUser.image,
                            date: date,
                            name: currentUser.fullName,
                            text: reviewController.text,
                            id: "",
                            foodId: widget.foodModel.id)));
                      },
                      child: const Text("Save"));
            },
          )
        ],
      ),
    );
  }
}
