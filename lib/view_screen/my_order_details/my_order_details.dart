import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';

import '../../controllers/my_order_details_controller.dart';

class MyOrderDetails extends StatefulWidget {
  const MyOrderDetails({Key? key}) : super(key: key);

  @override
  State<MyOrderDetails> createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyOrderDetailsController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle:true,
          title: const Text('Order Details'),
          backgroundColor: AppColors.primary,
        ),
        body:Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10,right:10),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/1,
                child:Row(
                  children: [
                    Container(
                      height: 40,
                      width: 85,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Center(child: Text('Accept',style: TextStyle(color: AppColors.whit),)),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      height: 40,
                      width: 85,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Center(child: Text('Accept',style: TextStyle(color:AppColors.whit),)),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      height: 40,
                      width: 85,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Center(child: Text('Accept',style: TextStyle(color: AppColors.whit),)),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      height: 40,
                      width: 85,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Center(child: Text('Accept',style:TextStyle(color:AppColors.whit),)),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      );
    },);
  }
}
