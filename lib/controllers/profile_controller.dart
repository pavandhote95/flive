
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Route_managements/routes.dart';

class ProfileController extends AppBaseController{


  void onTapBackforAsk(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: const Text("Are you sure you want to Logout.??"),
          actions: <Widget>[
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(primary: AppColors.primary),
              child: const Text("YES"),
              onPressed: () {
                onTapDelete();
                // exit(0);
                // SystemNavigator.pop();
              },
            ),
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(primary: AppColors.primary),
              child: const Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> onTapDelete() async {
    // Remove the user token from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('user_id');
    prefs.remove('user_id');
    Get.offAllNamed(loginScreen);

  }





}