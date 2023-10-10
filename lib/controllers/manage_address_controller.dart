import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';

class ManageAddressController extends AppBaseController{

  List<bool>? isChecked= [
    false,true
  ] ;

  void onTapGetCheck(index,val){
    // isChecked = !isChecked;
    isChecked?[index] = val;

    update();

  }


}