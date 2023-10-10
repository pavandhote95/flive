import 'package:flutter/material.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/get_favorite_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import '../models/remove_favorite_model.dart';

class FavoriteController extends AppBaseController{

String? productIndexId;
String? userId;

  @override
  void onInit(){
    super.onInit();
    getProductIndexId();
    getFavoriteData();

  }


 Future<void> getProductIndexId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    productIndexId = pref.getString('productId');
    userId = pref.getString('user_id');
    print('------------asasasasas${productIndexId}');

 }

 List<FavoriteData> favoriteData = [];

  Future<void> getFavoriteData() async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      GetFavoriteResponseModel res = await api.getFavoriteApi(body);

      if (res.error==true) {
        favoriteData = res.data;
        update();
        print('_____GetFavorite_____${res.message}_____________');
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


  /// Remove Favorite Api Function------------------>
  Future<void> removeFavorite() async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.productId] = productIndexId ?? '';
      body[RequestKeys.userId] =userId ?? '';
      print('-------fuuuuuuuuuu$body');
      RemoveFavoriteModel res = await api.removeFavoriteApi(body);

      if (res.error==true) {
        ShowMessage.showSnackBar('Server Res', res.message);
        getFavoriteData();
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
    var productPrice = double.parse(favoriteData[index].productPrice);
    var discount = (productPrice * 10 / 100);
    var specialPrice = productPrice - discount;
    var specialPriceAsString = specialPrice.toStringAsFixed(2);
    return Text("Special Price : Rs.$specialPriceAsString",style: const TextStyle(color:Colors.orange, fontSize: 12, fontWeight: FontWeight.w600,));

  }

}