import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/cate_controller.dart';

import '../../Route_managements/routes.dart';
import '../../Utils/colors.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<bool> categoryVisibility = List.generate(
      3, (index) => false); // Initialize with false values for 3 categories

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CategoryController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            title: const Text('Categories'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: controller.categoryListData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: InkWell(
                            onTap: () {
                              controller.curIndex = index;
                              controller.update();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: controller.curIndex == index
                                          ? AppColors.primary
                                          : AppColors.whit,
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: AppColors.primary)),
                                  child: Center(
                                    child: Text(
                                      controller
                                          .categoryListData[index].catTitle,
                                      style: TextStyle(
                                        color: controller.curIndex == index
                                            ? AppColors.whit
                                            : AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: controller.curIndex ==
                      0, // Show this ListView.builder for index 0
                  ///categoryVisibility[0]
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.menCategoryData.length,
                    itemBuilder: (context, index) {
                      var item = controller.menCategoryData[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(subCateScreen);
                          // Handle the onTap event for this list
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17.0, right: 17),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width / 1,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 20),
                                    child: Container(
                                      height: 60,
                                      width: 100,
                                      child: Text(
                                        controller.menCategoryData[index]
                                            ['name'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        controller.menCategoryData[index]
                                            ['categoryImage'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: controller.curIndex ==
                      1, // Show this ListView.builder for index 1
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.womenCategoryData.length,
                    itemBuilder: (context, index) {
                      var item = controller.womenCategoryData[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(subCateScreen);

                          // Handle the onTap event for this list
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17.0, right: 17),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width / 1,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30.0, top: 20),
                                    child: Container(
                                      height: 60,
                                      width: 120,
                                      child: Text(
                                        controller.womenCategoryData[index]
                                            ['name'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        controller.womenCategoryData[index]
                                            ['categoryImage'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: controller.curIndex ==
                      2, // Show this ListView.builder for index 1
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.kidsCategoryData.length,
                    itemBuilder: (context, index) {
                      var item = controller.womenCategoryData[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(subCateScreen);

                          // Handle the onTap event for this list
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17.0, right: 17),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width / 1,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30.0, top: 20),
                                    child: Container(
                                      height: 60,
                                      width: 120,
                                      child: Text(
                                        controller.kidsCategoryData[index]
                                            ['name'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        controller.kidsCategoryData[index]
                                            ['categoryImage'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
