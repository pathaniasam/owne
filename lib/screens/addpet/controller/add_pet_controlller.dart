

import 'dart:convert';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide MultipartFile,FormData;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:ownervet/model/request/add_pet_request.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/dashboard/view/dashboard_view.dart';
import 'package:ownervet/screens/myprofile/view/my_profile_view.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
class AddPetController extends  GetxController{

  TextEditingController nameController=TextEditingController();
  TextEditingController breedController=TextEditingController();
  TextEditingController speciesController=TextEditingController();
  TextEditingController genderController=TextEditingController();
  TextEditingController dateOfBirthController=TextEditingController();
  TextEditingController weightController=TextEditingController();
  var userlogin=GetStorage();

  final GlobalKey<FormState> addPetkey = GlobalKey<FormState>();
  bool isLoading =false;
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  void callAddPet(){
    final isValid = addPetkey.currentState!.validate();
    if(!isValid){
      return;
    }else{
      AppUtils().checkInternet().then((value) async{
        if(value){

          isLoading = true;
          update();
          if(image!=null){
            print("Spiecies"+double.parse(weightController.text).toStringAsFixed(2));
            final mimeTypeData = lookupMimeType(image!.path, headerBytes: [0xFF, 0xD8])!.split('/');
            var formData = FormData.fromMap({
              'pet_name': nameController.text,
              'breed': breedController.text,
              'species': speciesController.text,
              'gender': genderController.text,
              'weight': double.parse(weightController.text).toStringAsFixed(2),
              'dob': dateOfBirthController.text,
              'image': image==null?"":await MultipartFile.fromFile(image!.path,filename: basename(image!.path),   contentType: MediaType(mimeTypeData[0], mimeTypeData[1]))
            });
            AddPetRequest request = AddPetRequest(petName: nameController.text,breed: breedController.text,species: speciesController.text,gender: genderController.text,weight: int.parse(weightController.text),dob: dateOfBirthController.text);
            ApiHelper.post(NetworkUtils.add_pet,authtoken: userlogin.read(GetConstant.token),formData: formData).then((value) {
              if(value!.statusCode==201){
                LoginResponse response=LoginResponse.fromJson(jsonDecode(value.data));
                AppUtils.Snackbar("Success", response.message);
                Get.offAllNamed(AppRoutes.HOME);

                isLoading = false;
                update();
              }else{
                isLoading = false;
                update();
              }
            });
          }else{
            var formData = FormData.fromMap({
              'pet_name': nameController.text,
              'breed': breedController.text,
              'species': speciesController.text,
              'gender': genderController.text,
              'weight': int.parse(weightController.text),
              'dob': dateOfBirthController.text,
              'image': null});
            AddPetRequest request = AddPetRequest(petName: nameController.text,breed: breedController.text,species: speciesController.text,gender: genderController.text,weight: int.parse(weightController.text),dob: dateOfBirthController.text);
            ApiHelper.post(NetworkUtils.add_pet,authtoken: userlogin.read(GetConstant.token),formData: formData).then((value) {
              if(value!.statusCode==201){
                LoginResponse response=LoginResponse.fromJson(jsonDecode(value.data));
                AppUtils.Snackbar("Success", response.message);
                Get.offAllNamed(AppRoutes.HOME);

                isLoading = false;
                update();
              }else{
                isLoading = false;
                update();
              }
            });
          }



        }else{

        }
      });
    }


  }

  setDate(DateTime dateTime) {
    try {
      var dates = AppUtils().profileDateformat;

      var date = dates.format(dateTime);
      dateOfBirthController.text=date;
      update();
    } catch (e) {
      print(e);
    }
  }

  pickImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    update();
  }

}