import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/my_order_controller.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyOrderController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text('My Order'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10,),
            ListView.builder(
              shrinkWrap: true,
              // controller: scrollController,
              padding: const EdgeInsetsDirectional.only(top: 5.0),
              itemCount:5,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  //margin: EdgeInsets.all(5.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(7),
                    child: Column(children: <Widget>[
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(7.0),
                              topLeft: Radius.circular(7.0)),
                          child: FadeInImage(
                            fadeInDuration: const Duration(milliseconds: 150),
                            image:const AssetImage('assets/images/kurta_image7.jpeg'),
                            height: 120.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Container(), placeholder:const AssetImage('assetName'),

                            // errorWidget:(context, url,e) => placeHolder(90) ,

                          ),
                        ),
                        Expanded(
                            flex: 9,
                            child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 10.0, end: 5.0, bottom: 8.0, top: 8.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text(
                                        "ProStaus on 23-jun",
                                        style: TextStyle(color: AppColors.black),
                                      ),
                                      Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(top: 10.0),
                                          child: Text(
                                            'Shirt',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.normal),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ]))),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 3.0),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color:AppColors.primary,
                            size: 15,
                          ),
                        )
                      ]),
                    ]),
                    onTap: () async {
                   Get.toNamed(myOrderDetailsScreen);
                    },
                  ),
                );
              },
            )
          ],
        ),
      );
    },);
  }
}
