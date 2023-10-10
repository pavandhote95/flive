class ApiMethods {
  static final ApiMethods _apiMethods = ApiMethods._internal();

  factory ApiMethods() {
    return _apiMethods;
  }

  ApiMethods._internal();

  String login = 'login';
  String getCategory = 'category';
  String getBanner = 'getbanner';
  String getProduct = 'product';
  String getProductDetails = 'single_product';
  String addToFavorite = 'addfavorite';
  String removeToFavorite = 'removefavorite';
  String addToCart = 'Addtocart';
  String getCart = 'getcart';
  String removeCart = 'removecart';
  String getFavorite = 'getfavorite';




}