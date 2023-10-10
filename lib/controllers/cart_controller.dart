
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/get_cart_data_response.dart';

import '../Services/request_keys.dart';
import '../Widgets/bottom_navigation_bar/bottom_bar.dart';
import '../Widgets/show_message.dart';
import '../models/delete_cart_response.dart';

class CartController extends AppBaseController {
  int? increment;
  int number = 1;
  List<int> itemQuantities = [];
  String itemName = 'Product Name';
  double itemPrice = 19.99;

  List<GetCartData> cartData = [];


  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartData();
    if(Get.arguments != null) {
      increment  = Get.arguments;
      print('------Increment Number-----${increment}');
    }
  }



onTapNotification(){
  Get.toNamed(notificationScreen);

}

  void showCheckoutBottomSheet(BuildContext context, String itemName, double itemPrice) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: AppColors.greyColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Checkout Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text('Item: $itemName'),
                Text('Price: \$${itemPrice.toStringAsFixed(2)}'),
                const SizedBox(height: 16.0),
                Container(
                  height:130,
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

                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined,color: AppColors.red,),
                            SizedBox(width: 5,),
                            Text('Shipping Details',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Divider(height: 1,color: AppColors.black.withOpacity(0.5),thickness:0.5,),
                        const SizedBox(height:5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Ajay Malviya',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w700),),
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
                            child: const Text('Vijay Nagar Indore,Madhya Pradesh,India,Pin code 452010 ',overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w400),)),
                         const Text('6261253415',overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height:10),
                Container(
                  height:40,
                  width: MediaQuery.of(context).size.width/1,
                  decoration: BoxDecoration(
                      color: AppColors.textFieldClr,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child:const Padding(
                    padding: EdgeInsets.only(left: 20.0,right: 20),
                    child:Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                         Icon(Icons.payment,color: AppColors.red,),
                          SizedBox(width:20,),
                          Text('Select Payment Method',style: TextStyle(fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  height:110,
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
                        const Text('Order Summery(1 item)',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),
                        const SizedBox(height:10,),
                        Divider(height: 1,color: AppColors.black.withOpacity(0.5),thickness:0.5,),
                        const SizedBox(height:10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sub Total',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),
                                SizedBox(height:5,),
                                Text('Delivery Charge',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),


                              ],),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rs.1100',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),
                                SizedBox(height:5,),
                                Text('Rs.0.00',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),


                              ],),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),

                Container(
                  height:70,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.textFieldClr,
                  child:Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text('Rs.1100',style: TextStyle(fontWeight: FontWeight.w600,),),
                            Text('1 item',style: TextStyle(fontWeight: FontWeight.w400,color: AppColors.primary),),

                          ],
                        ),
                        SizedBox(
                          height: 40,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the bottom sheet
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10) )),
                            child: const Text('Place Order'),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }





  List<Map<String,dynamic>> menCategoryData = [
    {
      'categoryImage' : 'assets/images/formal_image1.jpg','name': 'Men wear'
    },


  ];

  addToCart(int index) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            print('IIIIIII');
            if (cartData[index].productQty >= 2) {
              cartData[index].productQty--; // Decrease the quantity for the specific item.
              update();
            }
          },
          child: Container(
            height: 40,
            width: 40,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Center(
                child: Text(
                  '-',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "${cartData[index].productQty}", // Display the quantity for the specific item.
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            if (cartData[index].productQty >=1) {
                cartData[index].productQty++; // Increase the quantity for the specific item.
                update();
            }
          },
          child: Container(
            height: 40,
            width: 40,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Center(
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }


  cartEmpty() {
  return Center(
    child: SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              noCartImage(),
              const SizedBox(height: 20,),
              noCartText(),
        //       AppBtn(
        //   width:210,
        //   height: 45,
        //   title: 'Shop Now',
        //   onPress: () {
        //     Get.toNamed(bottomBar);
        //   },
        // )
      ]),
    ),
  );
}

  noCartImage() {
  return Image.asset(
    'assets/images/emptyCart_image.png',
    fit: BoxFit.fill,

  );
}

  noCartText() {
  return Container(
      child: const Text('Your Cart Is Empty',
          style: TextStyle(color:AppColors.red,fontWeight: FontWeight.bold,fontSize: 20)));
}


  Future<void> getCartData() async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      GetCartResponseModel res = await api.getCartCartApi(body);

      if (res.error==true) {
        cartData = res.data;
        print('_____Product Details_____${res.message}_____________');
        //ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        update();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  ///Delete Cart Api Integration------------------>
  Future<void> deleteCartData(index) async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.productId]= cartData[index].productId.toString();
      DeleteCartResponseModel res = await api.deleteCartApi(body);
      print('_____id_____${body}_____________');
      if (res.error==true) {

        print('_____Product Details_____${res.message}_____________');
        getCartData();
        ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        update();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  ///Calculation For Discount price------------------>
  calculationDiscount(index){
    var productPrice = double.parse(cartData[index].productPrice);
    var discount = (productPrice * 10 / 100);
    var specialPrice = productPrice - discount;
    var specialPriceAsString = specialPrice.toStringAsFixed(2);
    return Text("Special Price : Rs.${(double.parse(specialPriceAsString)*cartData[index].productQty)}",style: const TextStyle(color:Colors.orange, fontSize: 12, fontWeight: FontWeight.w600,));

  }
}