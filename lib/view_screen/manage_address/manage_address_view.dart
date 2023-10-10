import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';

import '../../Utils/colors.dart';
import '../../controllers/manage_address_controller.dart';

class ManageAddress extends StatefulWidget {
  const ManageAddress({Key? key}) : super(key: key);

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ManageAddressController(),
      builder: (controller) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          Get.toNamed(addAddressScreen);
          },
          foregroundColor: AppColors.primary,
          backgroundColor:AppColors.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: const Icon(Icons.add,color: AppColors.whit,),
        ),
        appBar: AppBar(
          centerTitle : true,
          backgroundColor: AppColors.primary,
          title:const Text('Manage Address'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width/1,
              child: ListView.builder(
                itemCount:2,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left:20.0,right:20,top:20),
                    child: Container(
                      height:120,
                      width: MediaQuery.of(context).size.width/1,
                      decoration: BoxDecoration(
                          color: AppColors.textFieldClr,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height:10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Ajay Malviya ,6261253415',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w700),),
                                Container(
                                  width:60,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Center(child: Text('Edit',style: TextStyle(color: AppColors.whit),)),
                                )

                              ],
                            ),
                            const SizedBox(height:5,),
                            Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width/1.2,
                                child: const Text('Vijay Nagar Indore,Madhya Pradesh,India,Pin code 452010 ',overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w700),)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                     checkColor: Colors.white,
                                     fillColor:MaterialStateColor.resolveWith((states) => AppColors.secondary),
                                     value:controller.isChecked?[index],
                                     onChanged:(val) {
                                    if(controller.isChecked != null && index >= 0 && index < 2) {
                                       controller.isChecked?[index] = val ?? false; // Ensure val is not null
                                       controller.update(); // Trigger UI update if necessary
                                    }

                                      // controller.isChecked = val;
                                     // controller.onTapGetCheck();
                                    // controller.update();

                                  },
                                ),
                                const Text('Marked as Default'),
                                const SizedBox(width: 10,),
                                Container(
                                  width:60,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color: AppColors.red,
                                      borderRadius: BorderRadius.circular(15)),

                                  child: const Center(child: Text('Delete',style: TextStyle(color: AppColors.whit

                                  ),)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },),
            ),
          ],
        ),
      );
    },);
  }
}
