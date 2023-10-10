
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:lucknowichickenkari_app/models/add_favorite_model.dart';
import 'package:lucknowichickenkari_app/models/add_to_cart_response.dart';
import 'package:lucknowichickenkari_app/models/delete_cart_response.dart';
import 'package:lucknowichickenkari_app/models/get_cart_data_response.dart';
import 'package:lucknowichickenkari_app/models/get_favorite_response.dart';
import 'package:lucknowichickenkari_app/models/product_data_response.dart';
import 'package:lucknowichickenkari_app/models/remove_favorite_model.dart';
import '../models/category_data_response.dart';
import '../models/get_banner_data_response.dart';
import '../models/get_product_details_response.dart';
import '../models/login_model_response.dart';
import 'api_client.dart';
import 'api_methods.dart';

class Api {
  final ApiMethods _apiMethods = ApiMethods();
  final ApiClient _apiClient = ApiClient();

  static final Api _api = Api._internal();

final Connectivity connectivity = Connectivity();

  //final Connectivity? connectivity;

  factory Api() {
    return _api;
  }

  Api._internal();

  Map<String, String> getHeader() {
    return {'Cookie': 'ci_session=c35fa031f74710f20bf26fea3b4ccd7bfe18332a'};
    // return {'Content-Type': 'application/json'};
  }

  Future<GetLoginModel> loginUserApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.login, body: body);
      if (res.isNotEmpty) {
        try {
          return getLoginModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetLoginModel(error: true, message: 'Success', data: []);
        }
      } else {
        return GetLoginModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetLoginModel(error: false, message: 'No Internet', data: []);
    }
  }



  Future<GetCategoryModel> homeCategoryDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.getMethod(method: _apiMethods.getCategory, body: body);
      if (res.isNotEmpty) {
        try {
          return getCategoryModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print("----kDebugMode------${e}");
          }
          return GetCategoryModel(error: true, message: 'Success', data: []);
        }
      } else {
        return GetCategoryModel(error: false, message: 'success', data: []);
      }
    } else {
      return GetCategoryModel(error: false, message: 'success', data: []);
    }
  }

  Future<GetBannerModel> homeBannerDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.getMethod(method: _apiMethods.getBanner, body: body);
      if (res.isNotEmpty) {
        try {
          return getBannerModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print("----kDebugMode------${e}");
          }
          return GetBannerModel(error: true, message: 'success', banner: []);
        }
      } else {
        return GetBannerModel(error: true, message: 'success', banner: []);
      }
    } else {
      return GetBannerModel(error: true, message: 'success',banner: []);
    }
  }

  Future<GetProductModel> homeProductDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.getMethod(method: _apiMethods.getProduct, body: body);
      if (res.isNotEmpty) {
        try {
          return getProductModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print("-----jjjjjjj${e}");
          }
          return GetProductModel(error: true, status: 'success', products: []);
        }
      } else {
        return GetProductModel(error: false, status: 'Something went wrong', products: []);
      }
    } else {
      return GetProductModel(error: true, status: 'No Internet', products: []);
    }
  }


  Future<GetProductDetailsModel> productDetailsDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getProductDetails, body: body);
      if (res.isNotEmpty) {
        try {
          return getProductDetailsModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print("-----jjjjjjj${e}");
          }
          return GetProductDetailsModel(error: true, message: 'success', data: []);
        }
      } else {
        return GetProductDetailsModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetProductDetailsModel(error: false, message: 'No Internet', data: []);
    }
  }



  Future<AddFavoriteModel> addToFavoriteApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.addToFavorite, body: body);
      if (res.isNotEmpty) {
        try {
          return addFavoriteModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddFavoriteModel(error: true, message: 'Success', data: []);
        }
      } else {
        return AddFavoriteModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return AddFavoriteModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<RemoveFavoriteModel> removeFavoriteApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.removeToFavorite, body: body);
      if (res.isNotEmpty) {
        try {
          return removeFavoriteModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return RemoveFavoriteModel(error: true, message: 'Success', data: []);
        }
      } else {
        return RemoveFavoriteModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return RemoveFavoriteModel(error: false, message: 'No Internet', data: []);
    }
  }

  Future<GetFavoriteResponseModel> getFavoriteApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.getMethod(method: _apiMethods.getFavorite, body: body);
      if (res.isNotEmpty) {
        try {
          return getFavoriteResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetFavoriteResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return GetFavoriteResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetFavoriteResponseModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<AddToCartResponseModel> addToCartApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.addToCart, body: body);
      if (res.isNotEmpty) {
        try {
          return addToCartResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddToCartResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return AddToCartResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return AddToCartResponseModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<GetCartResponseModel> getCartCartApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.getMethod(method: _apiMethods.getCart, body: body);
      if (res.isNotEmpty) {
        try {
          return getCartResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetCartResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return GetCartResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetCartResponseModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<DeleteCartResponseModel> deleteCartApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.removeCart, body: body);
      if (res.isNotEmpty) {
        try {
          return deleteCartResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return DeleteCartResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return DeleteCartResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return DeleteCartResponseModel(error: false, message: 'No Internet', data: []);
    }
  }

// Future<RegisterUserResponse> registerUserApi(Map<String, String> body) async {
  //   if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
  //       await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
  //     String res =
  //     await _apiClient.postMethod(method: _apiMethods.registerUser, body: body);
  //     if (res.isNotEmpty) {
  //       try {
  //         return registerUserResponseFromJson(res);
  //       } catch (e) {
  //         if (kDebugMode) {
  //           print(e);
  //         }
  //         return RegisterUserResponse(error: true, message: e.toString());
  //       }
  //     } else {
  //       return RegisterUserResponse(error: true, message: 'Something went wrong');
  //     }
  //   } else {
  //     return RegisterUserResponse(error: true, message: 'No Internet');
  //   }
  // }

  // Future<LoginUserResponse> loginUserApi(Map<String, String> body) async {
  //   if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
  //       await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
  //     String res =
  //     await _apiClient.postMethod(method: _apiMethods.login, body: body);
  //     if (res.isNotEmpty) {
  //       try {
  //         return loginUserResponseFromJson(res);
  //       } catch (e) {
  //         if (kDebugMode) {
  //           print(e);
  //         }
  //         return LoginUserResponse(error: true, message: e.toString());
  //       }
  //     } else {
  //       return LoginUserResponse(error: true, message: 'Something went wrong');
  //     }
  //   } else {
  //     return LoginUserResponse(error: true, message: 'No Internet');
  //   }
  // }


  // Future<ResetPasswordResponse> resetPasswordApi(Map<String, String> body) async {
  //   if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
  //       await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
  //     String res =
  //     await _apiClient.postMethod(method: _apiMethods.resetPassword, body: body);
  //     if (res.isNotEmpty) {
  //       try {
  //         return resetPasswordResponseFromJson(res);
  //       } catch (e) {
  //         if (kDebugMode) {
  //           print(e);
  //         }
  //         return ResetPasswordResponse(error: true, message: e.toString());
  //       }
  //     } else {
  //       return ResetPasswordResponse(error: true, message: 'Something went wrong');
  //     }
  //   } else {
  //     return ResetPasswordResponse(error: true, message: 'No Internet');
  //   }
  // }







}