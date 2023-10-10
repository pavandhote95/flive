import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/sub_cate_controller.dart';

import '../../Utils/colors.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SubCategoryController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text('Sub-Category'),
        ),

      );
    },);
  }
}
