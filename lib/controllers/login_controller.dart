import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/request_keys.dart';
import '../Widgets/app_button.dart';
import '../Widgets/cropped_container.dart';
import '../Widgets/my_Clippath.dart';
import '../Widgets/show_message.dart';
import '../models/login_model_response.dart';
import '../session/Session.dart';


class LoginController extends AppBaseController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? mobile,password;
  bool isVisible = false;


  List<LoginData>userData = [];


  /// Navigation Function ----------->
  onTapSignUp(){
    Get.toNamed(signupScreen);

  }

 /// Password visibility update function------->
  onTapVisibUpdate(){
    isVisible=!isVisible;
    update();
  }




  /// Login UI View----------------------->
  getLoginContainer(context) {
    return Positioned.directional(
      start: MediaQuery.of(context).size.width * 0.025,
      // end: width * 0.025,
      // top: width * 0.45,
      top: MediaQuery.of(context).size.height * 0.2, //original
      //    bottom: height * 0.1,
      textDirection: Directionality.of(context),
      child: ClipPath(
        clipper: ContainerClipper(),
        child: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.8),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.95,
          color: AppColors.whit,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height:80,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Sign In',style: TextStyle(color:AppColors.red,fontWeight: FontWeight.bold,fontSize:30),)),
                    ),
                    const SizedBox(height:30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color:AppColors.textFieldClr,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: TextFormField(

                          controller:emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => value!.isEmpty ? 'Email Can not empty':null,
                          decoration: const InputDecoration(
                              border:InputBorder.none,
                              counterText: '',
                              hintText: 'Enter Email id',
                              prefixIcon: Icon(Icons.email_outlined,color:AppColors.primary,)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height:20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color:AppColors.textFieldClr,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: isVisible ? false : true,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => value!.isEmpty ? 'Password can not be blank':null,
                          decoration: InputDecoration(
                              border:InputBorder.none,
                              hintText: 'Enter Password',
                              suffixIcon: InkWell(
                                  onTap: () {
                                    onTapVisibUpdate();
                                  },
                                  child: Icon(isVisible ? Icons.visibility : Icons.visibility_off)),
                              prefixIcon: Icon(Icons.lock,color:AppColors.primary,)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height:20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right:20),
                      child: InkWell(
                          onTap: () {
                            Get.toNamed(forgetScreen);
                          },
                          child: const Text('Forgot Password',style: TextStyle(color: AppColors.red,fontWeight: FontWeight.bold),)),
                    ),
                    const SizedBox(height:20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right:20),
                      child: AppBtn(
                        title: 'Login',
                        height:45,
                        width: MediaQuery.of(context).size.width/1.2,
                        onPress: () {
                          // _formkey.currentState!.validate();
                          if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                            loginUser();
                          }else{
                            Fluttertoast.showToast(msg: 'Please Enter Email And Password');
                          }

                        },

                      ),
                    ),
                    const SizedBox(height:40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an Account ",style: TextStyle(color:AppColors.primary,fontWeight: FontWeight.bold,fontSize:15),),
                        InkWell(
                            onTap: () {
                              onTapSignUp();
                            },
                            child: const Text("Sign Up",style: TextStyle(color:AppColors.red,fontWeight: FontWeight.bold,fontSize:17),)),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Login Logo UI View----------------------->
  Widget getLogo(context) {
    return Positioned(
      // textDirection: Directionality.of(context),
      left: (MediaQuery.of(context).size.width / 2) -55,
      // right: ((MediaQuery.of(context).size.width /2)-55),
      top: (MediaQuery.of(context).size.height * 0.2) -55,
      //  bottom: height * 0.1,
      child: ClipPath(
        clipper: MyPolygon(),
        child: Container(
          color: AppColors.primary,
          width: 110,
          height: 110,
          child: Image.asset('assets/images/splashImage.jpg',fit: BoxFit.fill,),
        ),
      ),
    );
  }

/*
  String? validateEmail(String value, String? msg1, String? msg2) {
    if (value.length == 0) {
      return msg1;
    } else if (!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
        r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"
        r"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return msg2;
    } else {
      return null;
    }


    // validator: (val) => validateEmail(
    //     val!,
    //     'Email Id Is Required',
    //     'Please Enter Valid Email'),


  }
*/

  /// Login Api Integration------------------->
  Future<void> loginUser() async {
    // mobileFocus.unfocus();
    //passwordFocus.unfocus();
    //String? deviceID = await getDeviceIdentifier();
    setBusy(true);
    try {

      Map<String, String> body = {};
      body[RequestKeys.email] = emailController.text.trim();
      body[RequestKeys.password] = passwordController.text.trim();

      GetLoginModel res = await api.loginUserApi(body);
      print('${res.message}_____gggg_');
      if (res.error==true) {

        userData = res.data  ;
        print('this is id------>${userData[0].id}');
        String? user_id = res.data[0].id.toString();
        String? mobile = res.data[0].mobile ?? '';
        String? email = res.data[0].email ?? '';
        // String? name = res.data[0].username ?? '';
        print('user id is here=====${user_id}');
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_id',user_id);
        // prefs.setString('mobile',mobile);
        prefs.setString('email',email);
        // prefs.setString('userName',name);



        /// SharedPre.setValue(SharedPre.userData, userData.map((e) => e.toJson()));

        //SharedPre.setValue(SharedPre.userData, userData.toJson());
        /// var obj = await SharedPre.getObjs(SharedPre.userData);
        /// var currentUserData = UserData.fromJson(obj);
        ///  print('__________${currentUserData.id}_____________');
        ShowMessage.showSnackBar('Server Res', res.message);
        setBusy(false);
        Get.toNamed(bottomBar);
        update();

        // LoginUserData? userSavedData = LoginUserData();
        // userSavedData = res.data  ;
        //SharedPre.setValue(SharedPre.userData, userData?.toJson());
        //  SharedPre.setValue(SharedPre.isLogin, true);
        /*if (userData?.mobileVerifyStatus == 0) {
             Get.toNamed(AppRoutes.otp,
                 arguments: [mobileCtrl.text.trim(), passwordCtrl.text.trim()]);
           } else if (userData?.profileStatus == 0) {
             Get.offAndToNamed(AppRoutes.setupProfile);
           } else {
             mobileCtrl.clear();
             passwordCtrl.clear();
             Get.offAndToNamed(AppRoutes.home);*/
      }else{
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




}