import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/request/appointment_create_request.dart';
import 'package:ownervet/model/request/slot.dart';
import 'package:ownervet/model/request/verfiy_request.dart';
import 'package:ownervet/model/response/all_pet_response.dart';
import 'package:ownervet/model/response/category_filter_response.dart';
import 'package:ownervet/model/response/home_detail_response.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/model/response/slot_response.dart';
import 'package:ownervet/model/response/verify_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class DashBoardDetailController extends GetxController {
  String? id;
  HomeDetailResponse  detailResponse = HomeDetailResponse();
  TextEditingController paymentController = TextEditingController();
  TextEditingController addNotes = TextEditingController();
  TextEditingController verifyController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  var userLogin = GetStorage();
  List<Pets> pets = [];

  List<String> slots = [];
  List<int> servicesIdVerfiy = [];

  DateTime currentDate = DateTime.now();
  DateTime currentDate2 = DateTime.now();
  DateTime targetDateTime = DateTime.now();

  double grandTotal = 0.00;
  double discountOffer = 0.0;
  List<Services> addServices = [];
  List<Services> filterServices = [];
  List<CreateServices> createServices = [];
  double total = 0.00;
  int? selectSlot;
  String? slotValue;
  bool isCouponApplied = false;
  var payment = ["credit/Debit", "Cash", "Financement"];
  var imagesVet = [
    "assets/images/consultant.png",
    "assets/images/dogs.png",
    "assets/images/vet.png",
    "assets/images/groming.png"
  ];
  int? petId;
  final List<String> genderItems = [
    'Cat',
    'Dog',
  ];

  final List<String> vistSelection = [
    'Office Visit',
    'Call Appointment',
  ];
  String promoCode="";
  String currency="";
  String officeVisitAppointment="";
  var isDashLoad=false;

  @override
  void onInit() {
    super.onInit();

    getDetail();
   getSlotCallApi();
    callAddPetProfile();
  }

  void getDetail() {
    AppUtils().checkInternet().then((value) {
      if (value) {
        isDashLoad=true;
        update();
        ApiHelper.get(NetworkUtils.professional + id.toString(),
                authtoken: userLogin.read(GetConstant.token))
            .then((values) {
          HomeDetailResponse response =
              HomeDetailResponse.fromJson(jsonDecode(values.data));
          detailResponse = response;
          filterServices.addAll(detailResponse.services!);
          if(filterServices.length!=0){
            currency  =  filterServices.first.currency!;

          }
          isDashLoad=false;

          update();
        });
      } else {}
    });
  }

  addWeek(String key, bool value) {
    update();
  }

  addVServices(int index, bool value, Services services) {
    if (value) {
      grandTotal += services.price!.toDouble();
      addServices.add(services);
    } else {
      grandTotal -= services.price!.toDouble();
      addServices.remove(services);
    }
    detailResponse.services![index].isTrue = value;

    update();
  }

  changeDate(DateTime time) {
    currentDate2 = time;
    update();
  }

  getSlotCallApi() {
    AppUtils().checkInternet().then((value) {
      if (value) {
        SlotRequest request = SlotRequest(
            date:
                "${currentDate2.year.toString()}-${currentDate2.month.toString().padLeft(2, "0")}-${currentDate2.day.toString().padLeft(2, "0")}");
        ApiHelper.get(NetworkUtils.professionalSLot + id.toString()+"/slots",
                params: request.toJson(),
                authtoken: userLogin.read(GetConstant.token))
            .then((values) {
          SlotResponse response =
              SlotResponse.fromJson(jsonDecode(values.data));
          slots.clear();
          slots.addAll(response.slots!);
          update();
        });
      } else {}
    });
  }

  void callAddPetProfile() {
    AppUtils().checkInternet().then((values) {
      if (values) {
        ApiHelper.get(NetworkUtils.add_pet,
                authtoken: userLogin.read(GetConstant.token))
            .then((value) {
          AllPetResponse response =
              AllPetResponse.fromJson(jsonDecode(value.data));
          if (response.pets != null) {
            pets.addAll(response.pets!);
            update();
          }
        });
      } else {
        AppUtils.Snackbar(
            "Connection", "Please check your internet connection");
      }
    });
  }

  changeSlot(int index, String slot) {
    selectSlot = index;
    slotValue = slot;
    update();
  }

  addPet(Pets pet) {
    petId = pet.id;
    update();
  }

  createAppointement() {
    AppUtils().checkInternet().then((value) {
      if (addServices.length < 0) {
        return;
      }
      else if(officeVisitAppointment.isEmpty){
        AppUtils.Snackbar("Office Vist", "Please select appointemnt vist");
        return;
      }else if(petId==null){
        AppUtils.Snackbar("Pet", "Please select pet");
        return;
      }else if(slotValue==null){
        AppUtils.Snackbar("Time slot", "Please select time slot");
        return;
      }

      addServices.forEach((element) {
        createServices!.add(CreateServices(
            name: element.service!.name!,
            priceType: element.priceType,
            price: element.price,
            currency: element.currency,
            professionalServiceId: int.parse(id!)));
      });
      if (value) {
        AppointmentCreateRequest request = AppointmentCreateRequest(
            professionalId: int.parse(id!),
            totalAmount: total.toDouble(),
            petId: petId,
            services: createServices,
            sub_total: grandTotal.toDouble(),
            promocode: promoCode,
            discount: discountOffer.toDouble(),

            currency: currency,
            type: officeVisitAppointment,
            timing:
                "${currentDate2.year}-${currentDate2.month.toString().padLeft(2, "0")}-${currentDate2.day.toString().padLeft(2, "0")}${'T'}${slotValue}${":00Z"}");
        ApiHelper.post(NetworkUtils.createAppointment,
                body: request.toJson(),
                authtoken: userLogin.read(GetConstant.token))
            .then((values) {
              LoginResponse response=LoginResponse.fromJson(jsonDecode(values!.data));
              AppUtils.Snackbar("Success", response.message);
              Get.offAllNamed(AppRoutes.HOME);
        });
      } else {}
    });
  }

  void verifyCall(String promoCode) {
    AppUtils().checkInternet().then((value) {
      if (value) {
        if (promoCode.isEmpty) {
          return;
        }

        addServices.forEach((element) {
          servicesIdVerfiy.add(element.id!);
        });
        VerfiyRequest request = VerfiyRequest(
            professionalId: int.parse(id!),
            services: servicesIdVerfiy,
            promocode: promoCode);
        ApiHelper.post(
          NetworkUtils.verify,
          body: request.toJson(),
          authtoken: userLogin.read(GetConstant.token),
        ).then((values) {
          if (values!.statusCode == 200) {
            VerifyResponse response =
                VerifyResponse.fromJson(jsonDecode(values.data));
            AppUtils.Snackbar("Success", response.message);

            double discount = 100.00 - response.discount!;
            total = ((discount * grandTotal) / 100);
            total=double.parse(total.toStringAsFixed(2));

            isCouponApplied = true;
            promoCode=promoCode;
            discountOffer=response.discount!.toDouble();
            update();
          } else {
            LoginResponse response =
                LoginResponse.fromJson(jsonDecode(values.data));

            AppUtils.Snackbar("Error", response.message);
            isCouponApplied = false;
            total=grandTotal;
            discountOffer=0.0;
            promoCode="";
            update();
          }
        });
      } else {}
    });
  }

  speciesGenderFilter(String filter) {
    filterServices.addAll(detailResponse.services!);
    filterServices = detailResponse.services!
        .where((i) => i.animalType!.toUpperCase() == filter.toUpperCase())
        .toList();
    update();
  }


  vistAppointemnt(String value){
    officeVisitAppointment=value;
    update();
  }

  updateFavourite(bool isFav){
    detailResponse.isFavourite =isFav;
    update();

  }

  
  callFavouriteApi(){
    AppUtils().checkInternet().then((value) {
     if(value){
      ApiHelper.put(NetworkUtils.professional+id.toString()+"/"+"favourite",authtoken: userLogin.read(GetConstant.token)).then((values) {

      });
     }else{
       
     }
    });
  }
}
