import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/add_address_controller.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddAddressController(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.textFieldClr,
        appBar: AppBar(
          centerTitle: true,
          title:const Text('Add Address'),
          backgroundColor: AppColors.primary,
        ),
        body:Padding(
          padding: const EdgeInsets.only(left:10.0,right:10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                controller.setUserName(context),
                controller.setMobileNo(context),
                controller.setAddress(context),
                controller.setLandmark(),
                controller.setCities(context),
                controller.setArea(context),
                controller.setPincode(context),
                controller.setStateField(),
                controller.setCountry(),
                controller.typeOfAddress(),
                controller.defaultAdd(),
                controller.saveButton('Save', () {

                })

              ],
            ),
          ),
        ),
      );
    },);
  }
}
