import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/request_keys.dart';
import '../Utils/colors.dart';
import '../Widgets/show_message.dart';
import '../models/add_to_cart_response.dart';
import '../models/get_product_details_response.dart';

class ProductController extends AppBaseController{
  String? productId;
  String? slugId;
  int number = 1;
  double Rate = 0;
  String? selectedSize;
  int? selectedColor;

  List? productData;
  List<AddToCartResponseModel>aadToCartResData=[];
  List<ProductDetailsData>productDetailsData=[];

  void onInit(){
    super.onInit();

    if(Get.arguments != null) {
      productData  = Get.arguments;
      print('------ProductData-----${productData}');

    }

    getProductId();
    getProductDetailsData();

  }

  getProductId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    productId = pref.getString('prod_id');

  }



  /// Get Navigation  Function -------------->
  onTapCartScreen(){
    Future.delayed(const Duration(seconds:2),(){

      Get.toNamed(cartScreen,arguments: number);

    });

}

  /// Show Error Massage Function--------------->
  void _showError(context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message)),
    );
  }

  /// Add Product Function--------------->
  void addItem(BuildContext context, {index})async{

    // Check if a size is selected
    if (isSelected.every((element) => element == false)) {
      _showError(context,'Please select a size');
      return ;
    }

    // Check if a color is selected
    if (isSelectedColor.every((element) => element == false)) {
      _showError(context,'Please select a color');
      return;
    }
    addToCartData(index);
    // onTapCartScreen();
  }

  /// Select Function--------------->
  List<bool> isSelected = [
    false,false,false,false,false
  ];

  /// Select Color List--------------->
  List isSelectedColor = [
    false,false,false,false
  ];

  /// Size List--------------->
  List sizes = [
    'S','M','L','XL','XXL'
  ];
  onTapSelectedSize(index){
    selectedSize = sizes[index];
    print('choose size-------${selectedSize}');

  }

  /// colors List--------------->
  List colors = [
    0xFFFFFFFF,0xFF000000,0xFFFFD54F,0xFF64B5F6,

  ];

  onTapSelectedColor(index){
   selectedColor = colors[index];
   print('Selected Color--------$selectedColor');

  }

  /// Add to Cart Logic------------>
   addToCart(){
  return Container(
    decoration:BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: (){
                if(number>=2){
                  number--;
                  update();
                }

            },
            // behavior: ,
            child:const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
              child: Text('-',style: TextStyle(color: Colors.black,fontSize:30,fontWeight: FontWeight.bold),),
            ) ),

        Text(number.toString(),style: const TextStyle(fontSize:18),),
        GestureDetector(
          onTap: (){
              if(number>=1){
                number++;
                update();
                print('Increment---${number}');
              }

          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
            child: Text('+',style: TextStyle(fontSize: 25,color: Colors.black),),
          ),)
      ],
    ),
  );

}


  /// Get Product Details Api Function -------------->
  Future<void> getProductDetailsData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    slugId = pref.getString('slug_name');
    print('======Slug=======$slugId');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.slug] = slugId ?? '10';
      GetProductDetailsModel res = await api.productDetailsDataApi(body);
      print('_____vvv_____${res.message}_____________');

      if (res.error==true) {

        productDetailsData = res.data;

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


  Future<void> addToCartData(index) async {
         print('------id----${productDetailsData.first.id}');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.productId] =productId ??'';
      body[RequestKeys.sizeOfProduct] = selectedSize!;
      body[RequestKeys.color] = 'red';
      body[RequestKeys.productQty] = number.toString();
      AddToCartResponseModel res = await api.addToCartApi(body);
      print('parameter---------$body');
      if (res.error==true) {
        print('_____Product Details_____${res.message}_____________');
        ShowMessage.showSnackBar('Server Res', res.message);
        setBusy(false);
        update();
        onTapCartScreen();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }



  ///Calculation For Discount price------------------>
  calculationDiscount(){
    var productPrice = double.parse(productDetailsData[0].productPrice);
    var discount = (productPrice * 10 / 100);
    var specialPrice = productPrice - discount;
    var specialPriceAsString = specialPrice.toStringAsFixed(2);
    return Text("Special Price: Rs.$specialPriceAsString",style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w400,));

  }

  ///Calculation For Total price------------------>
  calculationTotalPrice(){
    var productPrice = double.parse(productDetailsData[0].productPrice);
    var discount = (productPrice * 10 / 100);
    var specialPrice = productPrice - discount;
    var specialPriceAsString = specialPrice.toStringAsFixed(2);
    return Text("Rs. ${(double.parse(specialPriceAsString)*number)}",style: const TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w500,));

  }
}