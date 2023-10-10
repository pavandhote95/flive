import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/home_controller.dart';
import '../../Widgets/star_rating.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            title: const Text('Home'),
            actions: [
              InkWell(
                  onTap: () {
                    Get.toNamed(favoriteScreen);
                  },
                  child: const Icon(Icons.favorite_border)),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: InkWell(
                    onTap: () {
                      controller.onTapNotification();
                    },
                    child: const Icon(Icons.notifications)),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    controller.getCurrentLoc();
                  },
                  child: Container(
                    color: AppColors.whit,
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            controller.currentAddress.text == ""
                                ? "Get Current Location"
                                : controller.currentAddress.text,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // controller.isBusy
                //     ? const Center(
                //   child: CircularProgressIndicator(
                //     color: AppColors.secondary,
                //   ),
                // ) :
                controller.categoryListData.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                        backgroundColor: AppColors.primary,
                      ))
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 10),
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width / 1,
                          color: AppColors.whit,
                          child: ListView.builder(
                            itemCount: controller.categoryListData == ''
                                ? 0
                                : controller.categoryListData.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              print(
                                  '-------yyyyyyy${controller.categoryListData[index].catImage}');
                              return InkWell(
                                onTap: () {
                                  controller.onTapCategoryScreen();
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(controller
                                                    .categoryListData[index]
                                                    .catImage ==
                                                ""
                                            ? "assets/images/lucknowi_chickankari.jpg"
                                            : controller.categoryListData[index]
                                                .catImage),
                                      ),
                                    ),
                                    Text(controller
                                        .categoryListData[index].catTitle)
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 500),
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        controller.currentIndex = index;
                      },
                      height: 500.0),
                  items: controller.sliderData.map((img) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              img['sliderImage'],
                              fit: BoxFit.fill,
                            ));
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 4,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Container(
                      height: 4,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Container(
                      height: 4,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Container(
                      height: 4,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(40)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        'All',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // controller.isBusy
                //     ? const Center(
                //   child: CircularProgressIndicator(
                //     color: AppColors.secondary,
                //   ),
                // ) :
                controller.productListData.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                        backgroundColor: AppColors.primary,
                      ))
                    : Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1,
                          width: MediaQuery.of(context).size.width / 1,
                          child: GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.productListData.isEmpty
                                ? 0
                                : controller.productListData.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 3,
                                    childAspectRatio: 0.62,
                                    mainAxisSpacing: 5),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 5,
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print(
                                                  "uuuuuuuuuu${controller.productListData[index].id}");
                                              controller.prodId = controller
                                                  .productListData[index].id
                                                  .toString();
                                              controller.onTapProduct(index);
                                              String slugId = controller
                                                  .productListData[index].slug;
                                              controller
                                                  .onTapProductScreen(slugId);
                                            },
                                            child: Container(
                                              height: 350,
                                              width: 250,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: controller
                                                              .productListData[
                                                                  index]
                                                              .productImage ==
                                                          ""
                                                      ? Image.asset(
                                                          'assets/images/formal_image1.jpg',
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Image.network(
                                                          controller
                                                              .productListData[
                                                                  index]
                                                              .productImage,
                                                          fit: BoxFit.fill,
                                                        )),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 120,
                                            child: InkWell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  controller
                                                          .productListData[
                                                              index]
                                                          .isFavorite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: controller
                                                          .productListData[
                                                              index]
                                                          .isFavorite
                                                      ? AppColors.red
                                                      : AppColors.primary,
                                                  size: 20,
                                                ),
                                              ),
                                              onTap: () {
                                                controller
                                                    .onTapGetFavoriteStatus(
                                                        index);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 0,
                                        ),
                                        child: Container(
                                            width: 160,
                                            child: Text(
                                              controller.productListData[index]
                                                  .productTitle,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10),
                                        child: Row(
                                          children: [
                                            const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Price: ',
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'offer : ',
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Special Price : ',
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                StarDisplay(value: 3)
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                      .productListData[index]
                                                      .productPrice,
                                                  style: const TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  controller
                                                              .productListData[
                                                                  index]
                                                              .offer ==
                                                          ""
                                                      ? "10%"
                                                      : controller
                                                          .productListData[
                                                              index]
                                                          .offer,
                                                  style: const TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                controller
                                                    .calculationDiscount(index),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
