
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../map/Map.dart';
import '../session/Session.dart';

class AddAddressController extends AppBaseController{

TextEditingController mobileController = TextEditingController();
TextEditingController nameController = TextEditingController();
final TextEditingController _areaController = TextEditingController();
final TextEditingController _cityController = TextEditingController();

TextEditingController addC = TextEditingController();
TextEditingController? nameC, mobileC, pincodeC, addressC, landmarkC, stateC, countryC, altMobC;
FocusNode? nameFocus, monoFocus, almonoFocus, addFocus, landFocus, locationFocus = FocusNode();
String? name, mobile, city, area, address, pincode, landmark, altMob, type = "Home", isDefault;
String? latitude, longitude, state, country;
StateSetter? areaState, cityState;
bool checkedDefault = false, isArea = false;
TextEditingController recipientAddressCtr= TextEditingController();

 bool cityLoading = true, areaLoading = true;
 int? selAreaPos = -1, selCityPos = -1;
 int? selectedType = 1;
String?newAddress,AddressC;

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAddress();

  }


  getAddress() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AddressC = pref.getString('address_c');
    print('------ttttt---kkk-----${AddressC}');
    addC.text = AddressC.toString();
    update();

    print('---ajay----${addC.text}');

  }

  List areaSearchList = [
    'Vijay Nagar',
    'Azad Nagar',
    'Khajrana'
  ];

  List citySearchLIst = [
    'Indore',
    'Bhopal',
    'Ujjain'
  ];


  setUserName(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.whit,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          focusNode: nameFocus,
          controller: nameC,
          textCapitalization: TextCapitalization.words,
          validator: (val) => validateUserName(
              val!,
              'Name is require',
              'User'),
          onSaved: (String? value) {
            name = value;
          },
          onFieldSubmitted: (v) {
            _fieldFocusChange(context, nameFocus!, monoFocus);
          },
          style: const TextStyle(color: AppColors.primary,fontWeight: FontWeight.w600),
          decoration: const InputDecoration(
              label: Text('Name'),
              fillColor: AppColors.whit,
              isDense: true,
              hintText: 'Name',
              border: InputBorder.none),
        ),
      ),
    ),
  );
}

  setMobileNo(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color:AppColors.whit,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: TextFormField(
          keyboardType: TextInputType.number,
          maxLength: 10,
          controller: mobileC,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.next,
          focusNode: monoFocus,
          style: const TextStyle(color:AppColors.primary),
          validator: (val) => validateMob(
              val!,'Mobile Number is required',
              'Valid mobile number'),
          onSaved: (String? value) {
            mobile = value;
          },
          onFieldSubmitted: (v) {
            _fieldFocusChange(context, monoFocus!, almonoFocus);
          },
          decoration: const InputDecoration(
              label: Text('Mobile Number'),
              fillColor: AppColors.whit,
              isDense: true,
              hintText:'Mobile',
              border: InputBorder.none),
        ),
      ),
    ),
  );
}

  setAddress(context) {
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whit,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(color:AppColors.fntClr),
                focusNode: addFocus,
                controller: addC,
                validator: (val) => validateField(
                    val!, 'Field is require'),
                onSaved: (String? value) {
                  address = value;
                },
                onFieldSubmitted: (v) {
                  _fieldFocusChange(context, addFocus!, locationFocus);
                },
                decoration: InputDecoration(
                  label: const Text('Address'),
                  fillColor:AppColors.whit,
                  isDense: true,
                  hintText: 'Address',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon:const Icon(
                      Icons.my_location,
                      color: AppColors.primary,
                    ),
                    focusNode: locationFocus,
                    onPressed: () async {
                      LocationPermission permission;
                      permission = await Geolocator.requestPermission();
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);

                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>Map(
                                latitude:
                                latitude == null || latitude == ""
                                    ? position.latitude
                                    : double.parse(latitude!),
                                longitude:
                                longitude == null || longitude == ""
                                    ? position.longitude
                                    : double.parse(longitude!),
                                from:
                                'Address',
                              )
                          )
                      );

                      update();
                      List<Placemark> placemark =
                      await placemarkFromCoordinates(
                          double.parse(latitude!),
                          double.parse(longitude!));

                      var address;
                      address = placemark[0].name;
                      address = address + "," + placemark[0].subLocality;
                      address = address + "," + placemark[0].locality;
                      print('--9999999-----$address');

                      state = placemark[0].administrativeArea;
                      country = placemark[0].country;
                      // pincode = placemark[0].postalCode;
                      //  address = placemark[0].name;
                          countryC!.text = country!;
                          stateC!.text = state!;
                          addressC!.text = address;
                          print('--9999999-----${addressC}');
                          //  pincodeC!.text = pincode!;
                          // addressC!.text = address!;

                          update();

                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

  setPincode(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color:AppColors.whit,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: TextFormField(
            //readOnly: true,
            keyboardType: TextInputType.number,
            controller: pincodeC,
            style: const TextStyle(color: AppColors.fntClr),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onSaved: (String? value) {
              // pincode = value;
            },
            // validator: (val) => validatePincode(val, getTranslated(context, 'PIN_REQUIRED')),
            decoration: const InputDecoration(
                label: Text('Pin code'),
                fillColor:AppColors.whit,
                isDense: true,
                hintText: 'Pin code',
                border: InputBorder.none),
          )),
    ),
  );
}


  setLandmark() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.whit,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          focusNode: landFocus,
          controller: landmarkC,
          style: const TextStyle(color: AppColors.fntClr),
          validator: (val) =>
              validateField(val!,'Field is require'),
          onSaved: (String? value) {
            landmark = value;
          },
          decoration: const InputDecoration(
              label: Text("Landmark"),
              fillColor: AppColors.whit,
              isDense: true,
              hintText: "Landmark",
              border: InputBorder.none),
        ),
      ),
    ),
  );
}

  setStateField() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color:AppColors.whit,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: TextFormField(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          controller: stateC,
          style: const TextStyle(color: AppColors.whit),
          readOnly: true,
          //validator: validateField,
          onChanged: (v){
            state = v;
            update();
          },

          onSaved: (String? value) {
            state = value;
          },
          decoration: const InputDecoration(
              label: Text('State'),
              fillColor: AppColors.whit,
              isDense: true,
              hintText: 'State',
              border: InputBorder.none),
        ),
      ),
    ),
  );
}

  setCountry() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.whit,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: TextFormField(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          controller: countryC,
          readOnly: true,
          style: const TextStyle(color: AppColors.fntClr),
          onSaved: (String? value) {
            country = value;
          },
          validator: (val) =>
              validateField(val!,'Field is require'),
          decoration: const InputDecoration(
              label: Text('Country'),
              fillColor: AppColors.whit,
              isDense: true,
              hintText: 'Country',
              border: InputBorder.none),
        ),
      ),
    ),
  );
}


   areaDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          areaState = setStater;
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  5.0,
                ),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                  child: Text('Area Select',
                    style: TextStyle(color: AppColors.fntClr),
                  ),
                ),
                TextField(
                  style: const TextStyle(
                    color:AppColors.fntClr,
                  ),
                  controller: _areaController,
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                    prefixIcon:
                    const Icon(Icons.search, color:AppColors.primary, size: 17),
                    hintText: 'Search here',
                    hintStyle: TextStyle(
                      color: AppColors.primary.withOpacity(0.5),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.whit
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:AppColors.whit
                      ),
                    ),
                  ),
                  // onChanged: (query) => updateSearchQuery(query),
                ),
                const Divider(color:AppColors.black),
                areaLoading
                    ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.0),
                    child: CircularProgressIndicator(),
                  ),
                )
                    : (areaSearchList.length > 0)
                    ? Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: getAreaList(context)),
                  ),
                )
                    : Padding(
                      padding:
                        const EdgeInsets.symmetric(vertical: 20.0),
                       child: getNoItem(context),
                )
              ],
            ),
          );
        },
      );
    },
  );
}

   cityDialog(context) {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          cityState = setStater;
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                  child: Text('City',
                    style: TextStyle(color:AppColors.fntClr),
                  ),
                ),
                TextField(
                  controller: _cityController,
                  autofocus: false,
                  style: const TextStyle(
                    color:AppColors.fntClr,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                    prefixIcon:
                    const Icon(Icons.search, color:AppColors.primary, size: 17),
                    hintText:'Search',
                    hintStyle:
                    TextStyle(color:AppColors.primary.withOpacity(0.5)),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:AppColors.whit),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:AppColors.whit),
                    ),
                  ),
                  // onChanged: (query) => updateSearchQuery(query),
                ),
                const Divider(color:AppColors.black),
                     cityLoading
                      ? const Center(
                            child: Padding(
                             padding: EdgeInsets.symmetric(vertical: 50.0),
                              child: CircularProgressIndicator(),),): (citySearchLIst.length > 0)
                    ? Flexible(
                           child: SingleChildScrollView(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: getCityList(context),
                          ),
                        ),
                       )
                    : Padding(
                           padding:
                           const EdgeInsets.symmetric(vertical: 20.0),
                           child: getNoItem(context),
                )
              ],
            ),
          );
        },
      );
    },
  );
}

   getAreaList(context) {
  return areaSearchList
      .asMap()
      .map(
        (index, element) => MapEntry(
      index,
      InkWell(
        onTap: () {

        },
        child: Container(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              areaSearchList[index].name!,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
      ),
    ),
  )
      .values
      .toList();
}

   getCityList(context) {
  return citySearchLIst
      .asMap()
      .map(
        (index, element) => MapEntry(
      index,
      InkWell(
        onTap: () {

          city = citySearchLIst[selCityPos!].id;


        },
        child: Container(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              citySearchLIst[index].name!,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
      ),
    ),
  )
      .values
      .toList();
}

   setCities(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color:AppColors.whit,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: GestureDetector(
            child: InputDecorator(
                decoration: const InputDecoration(
                  fillColor:AppColors.whit,
                  isDense: true,
                  border: InputBorder.none,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Select City',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                              selCityPos != null && selCityPos != -1
                                  ? citySearchLIst[selCityPos!].name!
                                  : "",
                              style: TextStyle(
                                  color: selCityPos != null
                                      ? AppColors.fntClr
                                      : Colors.grey)),
                        ],
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                )),
            onTap: () {
              cityDialog(context);
            },
          )),
    ),
  );
}

   setArea(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color:AppColors.whit,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: GestureDetector(
            child: InputDecorator(
                decoration: const InputDecoration(
                    fillColor:AppColors.whit,
                    isDense: true,
                    border: InputBorder.none),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Area Select',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                              selAreaPos != null && selAreaPos != -1
                                  ? areaSearchList[selAreaPos!].name!
                                  : "",
                              style: TextStyle(
                                  color: selAreaPos != null
                                      ? AppColors.fntClr
                                      : Colors.grey)),
                        ],
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_right),
                  ],
                )),
            onTap: () {
              areaDialog(context);
            },
          )),
    ),
  );
}

   typeOfAddress()  {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
        color:AppColors.whit,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              child: Row(
                children: [
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    groupValue: selectedType,
                    activeColor:AppColors.fntClr,
                    value: 1,
                    onChanged: (dynamic val) {
                          selectedType = val;
                          type = 'HOME';
                          update();
                    },
                  ),
                  const Expanded(child: Text('Home'))
                ],
              ),
              onTap: () {
                    selectedType = 1;
                    type = 'HOME';
                    update();

              },
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Row(
                children: [
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    groupValue: selectedType,
                    activeColor:AppColors.fntClr,
                    value: 2,
                    onChanged: (dynamic val) {
                          selectedType = val;
                          type = 'OFFICE';
                          update();

                    },
                  ),
                  const Expanded(child: Text('OFFICE'))
                ],
              ),
              onTap: () {
                    selectedType = 2;
                    type = 'OFFICE';
                    update();

              },
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Row(
                children: [
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    groupValue: selectedType,
                    activeColor:AppColors.fntClr,
                    value: 3,
                    onChanged: (dynamic val) {
                          selectedType = val;
                          type = 'OTHER';
                          update();

                    },
                  ),
                  const Expanded(child: Text('OTHER'))
                ],
              ),
              onTap: () {
                    selectedType = 3;
                    type = 'OTHER';
                    update();

              },
            ),
          )
        ],
      ));
}

  defaultAdd() {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color:AppColors.whit,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SwitchListTile(
        value: checkedDefault,
        activeColor:AppColors.fntClr,
        dense: true,
        onChanged: (newValue) {

              checkedDefault = newValue;
              update();


        },
        title: const Text('Default Add',
          style:TextStyle(color: AppColors.primary),
        ),
      ));
}


  saveButton(String title, VoidCallback? onBtnSelected) {
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: MaterialButton(
            height: 45.0,
            textColor:AppColors.whit,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: onBtnSelected,
            child: Text(title),
            color:AppColors.primary,
          ),
        ),
      ),
    ],
  );
}


_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}


}