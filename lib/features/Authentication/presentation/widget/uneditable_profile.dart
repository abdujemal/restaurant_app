import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';

class UnEditableProfile extends StatefulWidget {
  UserModel userModel;
  UnEditableProfile({super.key,required this.userModel});

  @override
  State<UnEditableProfile> createState() => _UnEditableProfileState();
}

class _UnEditableProfileState extends State<UnEditableProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 15.0),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "Account Information".toUpperCase(),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: const Text(
            "Full Name",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            widget.userModel.fullName,
          ),
        ),
        ListTile(
          title: const Text(
            "Email",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            widget.userModel.email,
          ),
        ),
        ListTile(
          title: const Text(
            "Phone",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            widget.userModel.phone,
          ),
        ),
        ListTile(
          title: const Text(
            "Address",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            widget.userModel.address,
          ),
        ),
        ListTile(
          title: const Text(
            "Gender",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            widget.userModel.gender,
          ),
        ),
        ListTile(
          title: const Text(
            "Date of Birth",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            widget.userModel.dateOfBirth,
          ),
        ),
      ],
    );
  }
}
