import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/add_favorite_model.dart';
import 'package:lucknowichickenkari_app/models/remove_favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/request_keys.dart';
import '../Utils/colors.dart';
import '../Widgets/show_message.dart';
import '../models/category_data_response.dart';
import '../models/get_banner_data_response.dart';
import '../models/product_data_response.dart';

class HomeController extends AppBaseController{
  String? prodId;
  // bool isFavorite = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHomeCategoryData();
    getHomeBannerData();
    getHomeProductData();

  }


  int?  currentIndex;
  String? lat2;
  String? long2;





  List <ProductData> productListData = [] ;
  List <CategoryData> categoryListData = [] ;
  List <BannerData> bannerListData = [] ;

  var pinController = TextEditingController();
  TextEditingController currentAddress = TextEditingController();



  onTapProduct(index) async {
    print('----set___product---id--${prodId}');
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('prod_id',prodId!);

  }



  /// Screen Navigation Function--------------------->
  onTapProductScreen(slugId) async {

    if(slugId!=null){
      print('------kkkkkkl-----$slugId');
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('slug_name', slugId);
      Get.toNamed(productScreen,arguments:[productListData],);
    }

  }

  onTapProductScreen2(){

   Get.toNamed(productScreen);

  }

  onTapCategoryScreen(){
    Get.toNamed(categoryScreen);
  }

  onTapNotification(){

    Get.toNamed(notificationScreen);
  }


  /// Favorite status update-------------->
  // updateFavorite(index){
  //   isFavorite = !isFavorite;
  //   update();
  // }


  Future<void> onTapGetFavoriteStatus(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('productId',productListData[index].id.toString() );
    // Toggle the favorite status for the item at the given index
    productListData[index].isFavorite = !productListData[index].isFavorite;
    print('favorite----status------${productListData[index].isFavorite}');
    if(productListData[index].isFavorite==true){
      addFavorite(index);
      // update();
    }else{
      removeFavorite(index);

    }
    update();
  }





  /// Map Integration For Current Location Function--------->
  Future<void> getCurrentLoc() async {

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here ${permission}");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat2 = position.latitude.toString();
    long2 = position.longitude.toString();
    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(lat2!), double.parse(long2!),
        localeIdentifier: "en");

    pinController.text = placemark[0].postalCode!;

    pinController.text = placemark[0].postalCode!;
    currentAddress.text =
    "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
    lat2 = position.latitude.toString();
    long2 = position.longitude.toString();
    // loc.lng = position.longitude.toString();
    //loc.lat = position.latitude.toString();
    update();
    print('Latitude=============${lat2}');
    print('Longitude*************${long2}');
    print('Current Addresssssss${currentAddress.text}');

  }



  /// Get Category Api Function--------------->
  Future<void> getHomeCategoryData() async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      GetCategoryModel res = await api.homeCategoryDataApi(body);
      print('_____cateData_____${res.message}_____________');

      if (res.error==true) {

        categoryListData = res.data;

        print('__________${res.message}_____________');
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

  /// Get Banner or Slider Api Function-------->
  Future<void> getHomeBannerData() async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      GetBannerModel res = await api.homeBannerDataApi(body);
      print('_____geBanner Message_____${res.message}_____________');

      if (res.error==true) {

        bannerListData = res.banner;

        print('__________${res.message}_____________');
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

  /// Get Product Api Function -------------->
  Future<void> getHomeProductData() async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      GetProductModel res = await api.homeProductDataApi(body);

      if (res.error==true) {

        productListData = res.products;

        print('___________Product Status______${res.status}');
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

 /// Add Favorite Api Function------------------>

  Future<void> addFavorite(index) async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.productId] = productListData[index].id.toString();
      body[RequestKeys.userId] = '1';

      AddFavoriteModel res = await api.addToFavoriteApi(body);

      if (res.error==true) {
        ShowMessage.showSnackBar('Server Res', res.message);
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

  /// Remove Favorite Api Function------------------>
  Future<void> removeFavorite(index) async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.productId] = productListData[index].id.toString();
      body[RequestKeys.userId] = '1';

      RemoveFavoriteModel res = await api.removeFavoriteApi(body);

      if (res.error==true) {
        ShowMessage.showSnackBar('Server Res', res.message);
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

 /// Static Data List For View Data---------------->
  List<Map<String,dynamic>> imageData = [
    {
      'catImage' : 'assets/images/lucknowi_chickankari.jpg',
      'cat1':'Mens wear'
    },
    {
      'catImage' : 'assets/images/lucknowi_chickankari.jpg','cat1':'Kids wear'
    },
    {
      'catImage' : 'assets/images/lucknowi_chickankari.jpg','cat1':"Women's wear"
    },
    {
      'catImage' : 'assets/images/lucknowi_chickankari.jpg','cat1':'Mens wear'
    },
  ];

  List<Map<String,dynamic>> sliderData = [
    {
      'sliderImage' : 'assets/images/menswear_image.png'
    },
    {
      'sliderImage' : 'assets/images/womens_wear_images.png'
    },
    {
      'sliderImage' : 'assets/images/kids_wear_image.png'
    },
    {
      'sliderImage' : 'assets/images/menswear_image.png'
    },

  ];

  List<Map<String,dynamic>> productData1 = [
    {
      'productImage' : 'assets/images/kurta_image6.jpg','name': 'Men wear'
    },
    {
      'productImage' : 'assets/images/formal_image2.jpg','name': 'Men wear'
    },
    {
      'productImage' : 'assets/images/womens_image1.jpg','name': 'Women wear'
    },
    {
      'productImage' : 'assets/images/women_image2.jpg','name': 'Women wear'
    },
    {
      'productImage' : 'assets/images/kids_image1.png','name': 'Kids wear'
    },
    {
      'productImage' : 'assets/images/kids_image2.png','name': 'Kids wear'
    },



  ];


  ///Calculation For Discount price------------------>
  calculationDiscount(index){
    var productPrice = double.parse(productListData[index].productPrice);
    var discount = (productPrice * 10 / 100);
    var specialPrice = productPrice - discount;
    var specialPriceAsString = specialPrice.toStringAsFixed(2);
    return Text("Rs.$specialPriceAsString",style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w400,));

  }

}