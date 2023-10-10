import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';

import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            title: const Text('My Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 70),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: AppColors.whit,
                  height: 100,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 20),
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 1.0, color: AppColors.whit)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.asset(
                              "assets/images/man_image1.jpg",
                              fit: BoxFit.fill,
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Ajay Malviya',
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Mob : 7688775566',
                            style: TextStyle(color: AppColors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                // Order history section
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: AppColors.black,
                    ),
                    title: const Text('My Order',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      Get.toNamed(myOrderScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(
                      Icons.place_outlined,
                      color: AppColors.black,
                    ),
                    title: const Text('Manage Address',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      Get.toNamed(manageAddressScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(
                      Icons.wallet,
                      color: AppColors.black,
                    ),
                    title: const Text('My Wallet',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      Get.toNamed(walletScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(
                      Icons.transfer_within_a_station,
                      color: AppColors.black,
                    ),
                    title: const Text('My Transaction',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      Get.toNamed(transactionScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(
                      Icons.password_outlined,
                      color: AppColors.black,
                    ),
                    title: const Text('Change Password',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      Get.toNamed(forgetScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(
                      Icons.contact_support_outlined,
                      color: AppColors.black,
                    ),
                    title: const Text('Customer Support',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      Get.toNamed(customerSupportScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_box_outlined,
                      color: AppColors.black,
                    ),
                    title: const Text('About Us',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      Get.toNamed(aboutUsScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(
                      Icons.contact_mail_outlined,
                      color: AppColors.black,
                    ),
                    title: const Text('Contact Us',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      Get.toNamed(contactUsScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(
                      Icons.privacy_tip_outlined,
                      color: AppColors.black,
                    ),
                    title: const Text('Privacy Policy',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      Get.toNamed(privacyScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Settings section
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.logout_outlined,
                        color: AppColors.black),
                    title: const Text('Logout',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: AppColors.black),
                    onTap: () {
                      controller.onTapBackforAsk(context);
                      // Navigate to the settings page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
