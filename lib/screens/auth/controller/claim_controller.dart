import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:ownervet/model/response/all_categories_response.dart';
import 'package:ownervet/model/response/claim_business_response.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/utils/app_utils.dart';

import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:http_parser/http_parser.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:path/path.dart';
import 'package:place_picker/entities/location_result.dart';

class ClaimControllerController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  List<LatLng> latLngList = List.empty(growable: true);
  String? id;
  var countryCode = "+1";
  bool showPassword = true;
  var userlogin = GetStorage();
  bool isLoading = false;
  String? latitude;
  String? longitude;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  List<Categories> categories = [];
  List<String> paymentModes = [];
  var addPayment = [];
  String country="";
  Map<String, bool> numbers = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };
  var holder_1 = [];
  var items;
  String categoryId="";
  List<int> weeklist=[];
  String openTime="";
  String closeTime="";
  @override
  void onInit() {
    super.onInit();
    getAllCategory();
  }

  getItems() {
    numbers.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  callRegister() {
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else if (image == null) {
      AppUtils.Snackbar("Image", "Please add image");

      return;
    } else {
      Get.toNamed(AppRoutes.address);
    }
  }

  addWeek(String key, bool value) {
    weeklist.clear();
    numbers[key] = value;
    print(numbers.toString());
    numbers.forEach((key, value) {
      if(value){
        weeklist.add(1);
      }else{
        weeklist.add(0);

      }
    });
    print(weeklist.toString());

    update();
  }

  void getAllCategory() {
    AppUtils().checkInternet().then((value) {
      if (value) {
        ApiHelper.get(NetworkUtils.categories).then((values) {
          AllCategoriesResponse response =
              AllCategoriesResponse.fromJson(jsonDecode(values.data));
          categories.addAll(response.categories!);
          paymentModes.addAll(response.paymentModes!);
          items = paymentModes
              .map((animal) => MultiSelectItem<String>(animal, animal))
              .toList();
          update();
        });
      } else {
        AppUtils.Snackbar(
            "Internet Connection", "Please check your internet connection");
      }
    });
  }

  pickImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    update();
  }

  getAddress(String address, LocationResult result) {
    placeController.text = address;
    latLngList.add(result.latLng!);
    latitude = latLngList[0].latitude.toString();
    longitude = latLngList[0].longitude.toString();
    country=result.country!.name!;

    update();
  }

  openTimeAdd(TimeOfDay time) {
    print(time);
    DateTime tempDate = DateFormat("hh:mm").parse(
        time!.hour.toString() +
            ":" + time!.minute.toString());
    var dateFormat = DateFormat("h:mm a");
    print(dateFormat.format(tempDate));

    openTime=time.hour.toString().padLeft(2, "0") +
        ":" +
        time.minute.toString().padLeft(2, '0');
    openTimeController.text = dateFormat.format(tempDate);
    update();
  }

  closeTimeAdd(TimeOfDay close) {
    print(close);
    DateTime tempDate = DateFormat("hh:mm").parse(
        close!.hour.toString() +
            ":" + close!.minute.toString());
    var dateFormat = DateFormat("h:mm a");
    print(dateFormat.format(tempDate));
    closeTime=close.hour.toString().padLeft(2, "0") +
        ":" +
        close.minute.toString().padLeft(2, '0');
    closeTimeController.text = dateFormat.format(tempDate);
    update();
  }

  saveCategory(Categories value) {
    print("Category" + value.id.toString());
    categoryId = value.id.toString();
    update();
  }

  addPayemnt(List<dynamic> value) {
    addPayment.clear();
    value.forEach((element) {
      addPayment.add(element);
    });

    print(addPayment);
    update();
  }

  callRegisterApi() async {
    AppUtils().checkInternet().then((value) async {
      if (value) {
        if (openTimeController.text.isEmpty) {
          AppUtils.Snackbar("Open Timing", "Please add open timing");
          return;
        } else if (closeTimeController.text.isEmpty) {
          AppUtils.Snackbar("Close Timing", "Please add close timing");
          return;
        } else if (contactController.text.isEmpty) {
          AppUtils.Snackbar(
              "Clinic Contact", "Please add clinic contact number");
          return;
        } else if (contactController.text.isEmpty) {
          AppUtils.Snackbar("Contact", "Please add contact number");
          return;
        } else if (placeController.text.isEmpty) {
          AppUtils.Snackbar("Address", "Please add address");
          return;
        } else if (addPayment.length == 0) {
          AppUtils.Snackbar("Payment Method", "Please add payment method");
          return;
        }else if(categoryId.isEmpty){
          AppUtils.Snackbar("Category", "Please select category");
          return;
        }
        if(country=="US" || country=="CA"){
          isLoading=true;
          update();
          final mimeTypeData =
          lookupMimeType(image!.path, headerBytes: [0xFF, 0xD8])!.split('/');

          FormData formData = FormData.fromMap({
            'name': nameController.text,
            'email': emailController.text,
            'mobile': phoneController.text,
            'password': passwordController.text,
            'address': placeController.text,
            'category_id': int.parse(categoryId!),
            'open_time': openTime,
            'close_time': closeTime,
            'contact': contactController.text,
            'latitude': latitude,
            'longitude': longitude,
            'payment_modes': json.encode(addPayment),
            'country': country=="CA"?"CANADA":"USA",
            'days':json.encode(weeklist),
            'image': await MultipartFile.fromFile(image!.path,
                filename: basename(image!.path),
                contentType: MediaType(mimeTypeData[0], mimeTypeData[1]))
          });

          ApiHelper.post(NetworkUtils.professionalClaim+id.toString()+"/claim",authtoken: userlogin.read(GetConstant.token), formData: formData)
              .then((value)  {

            if(value!.statusCode==201){
            //  userlogin.write(GetConstant.name,response.name);
             // userlogin.write(GetConstant.id,response.id);
              //userlogin.write(GetConstant.token,response.token);
            //  userlogin.write(GetConstant.currency,response.country);
           //   userlogin.write(GetConstant.role,"SP");
              LoginResponse response=LoginResponse.fromJson(jsonDecode(value.data));

              AppUtils.Snackbar("Success", response.message);
              Get.offAllNamed(AppRoutes.HOME);
              AppUtils.Snackbar("Success", "You have successfully login");
              isLoading=false;

              update();

            }else{
              LoginResponse response=LoginResponse.fromJson(jsonDecode(value.data));

              AppUtils.Snackbar("Success", response.message);
              Get.offAllNamed(AppRoutes.HOME);

              isLoading=false;

              update();

            }

            isLoading=false;
            update();
          });
        }else{
          AppUtils.Snackbar("Country", "Please select country either USA or CANADA");
          return;
        }

      } else {
        AppUtils.Snackbar(
            "Internet Connection", "Please check your internet connection");
      }
    });
  }

  showPasswords(bool showPasswords) {
    showPassword = !showPasswords;
    update();
  }
}
