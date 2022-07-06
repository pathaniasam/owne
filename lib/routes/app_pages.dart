import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ownervet/booking/binding/booking_binding.dart';
import 'package:ownervet/booking/view/booking_view.dart';
import 'package:ownervet/chat/binding/all_users_binding.dart';
import 'package:ownervet/chat/view/all_users_screen.dart';
import 'package:ownervet/deals/binding/appointment_detail_binding.dart';
import 'package:ownervet/deals/binding/deals_binding.dart';
import 'package:ownervet/deals/view/appointment_detail.dart';
import 'package:ownervet/deals/view/deals_view.dart';
import 'package:ownervet/drawer/bindings/drawer_binding.dart';
import 'package:ownervet/drawer/view/drawer_screen.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/add_cost/binding/add_binding.dart';
import 'package:ownervet/screens/add_cost/view/add_cost_view.dart';
import 'package:ownervet/screens/addpet/binding/add_pet_binding.dart';
import 'package:ownervet/screens/addpet/view/add_pet_view.dart';
import 'package:ownervet/screens/addquestionanswer/binding/add_question_binding.dart';
import 'package:ownervet/screens/addquestionanswer/binding/question_detail_binding.dart';
import 'package:ownervet/screens/addquestionanswer/view/add_question_detail.dart';
import 'package:ownervet/screens/addquestionanswer/view/add_question_view.dart';
import 'package:ownervet/screens/auth/binding/claim_binding.dart';
import 'package:ownervet/screens/auth/binding/create_account_binding.dart';
import 'package:ownervet/screens/auth/binding/google_binding.dart';
import 'package:ownervet/screens/auth/binding/login_binding.dart';
import 'package:ownervet/screens/auth/view/add_address.dart';
import 'package:ownervet/screens/auth/view/claim_business.dart';
import 'package:ownervet/screens/auth/view/create_account.dart';
import 'package:ownervet/screens/auth/view/google_login.dart';
import 'package:ownervet/screens/auth/view/login_view.dart';
import 'package:ownervet/screens/coummnity/binding/coummnity_binding.dart';
import 'package:ownervet/screens/coummnity/view/coummnity_view.dart';
import 'package:ownervet/screens/dashboard/binding/dashbaord_detail_binding.dart';
import 'package:ownervet/screens/dashboard/view/book_appointment.dart';
import 'package:ownervet/screens/dashboard/view/dashbaord_detail.dart';
import 'package:ownervet/screens/favourite/binding/favourite_binding.dart';
import 'package:ownervet/screens/favourite/view/favourite_view.dart';
import 'package:ownervet/screens/home/binding/home_binding.dart';
import 'package:ownervet/screens/home/view/home_view.dart';
import 'package:ownervet/screens/intro/binding/intro_binding.dart';
import 'package:ownervet/screens/intro/view/intro_screen.dart';
import 'package:ownervet/screens/myprofile/binding/my_controller_binding.dart';
import 'package:ownervet/screens/myprofile/view/my_profile_view.dart';
import 'package:ownervet/screens/reviews/binding/all_review_binding.dart';
import 'package:ownervet/screens/reviews/binding/reviews_binding.dart';
import 'package:ownervet/screens/reviews/view/all_review_view.dart';
import 'package:ownervet/screens/reviews/view/reviews_view.dart';
import 'package:ownervet/screens/search/binding/search_binding.dart';
import 'package:ownervet/screens/search/view/search_filter.dart';
import 'package:ownervet/screens/search/view/search_view.dart';
import 'package:ownervet/screens/select_payment/binding/payment_binding.dart';
import 'package:ownervet/screens/select_payment/binding/select_payment_binding.dart';
import 'package:ownervet/screens/select_payment/view/payment_screen.dart';
import 'package:ownervet/screens/select_payment/view/select_payment.dart';
import 'package:ownervet/screens/splash/binding/splash_binding.dart';
import 'package:ownervet/screens/splash/view/splash_screen.dart';


class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScren(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.INTRO,
      page: () => IntroScreen(),
      binding: IntroBinding(),
    ),

    GetPage(
      name: AppRoutes.AddPet,
      page: () => AddPetView(),
      binding: AddPetBinding(),
    ),

    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: AppRoutes.Coummnity,
      page: () => CoummnityView(),
      binding: CoummnityBinding(),
    ),
    GetPage(
      name: AppRoutes.Search,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.Deals,
      page: () => DealsView(),
      binding: DealsBinding(),
    ),
    GetPage(
      name: AppRoutes.Booking,
      page: () => BookingView(),
      binding: BookingBinding(),
    ),

    GetPage(
      name: AppRoutes.AddQuestion,
      page: () => AddQuestionView(),
      binding: QuestionBinding(),
    ),


    GetPage(
      name: AppRoutes.detailQuestion,
      page: () => AddQuestionDetail(),
      binding: QuestionDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.social,
      page: () => GoogleLogin(),
      binding: GoogleBinding(),
    ),

    GetPage(
      name: AppRoutes.LOGIN,

      page: () => LoginView(),
      binding: LoginBinding(),),
    GetPage(
      name: AppRoutes.createAccount,

      page: () => CreateAccountView(),
      binding: CreateAccountBinding(),),
    GetPage(
      name: AppRoutes.myprofile,

      page: () => MyProfileView(),
      binding: MyProfileBinding(),),

    GetPage(
      name: AppRoutes.drawer,

      page: () => DrawerMenu(),
      binding: DrawerBinding(),),

    GetPage(
      name: AppRoutes.detail_home,

      page: () => DashBoardDetails(),
      binding: DashBoardDetailBinding(),),
    GetPage(
      name: AppRoutes.book_home,

      page: () => BookAppointment(),
      binding: DashBoardDetailBinding(),),
    GetPage(
      name: AppRoutes.add_cost,

      page: () => AddCostView(),
      binding: AddCostBinding(),),

    GetPage(
      name: AppRoutes.select_payment,

      page: () => SelectPayment(),
      binding: SelectPaymentBinding(),),

    GetPage(
      name: AppRoutes.payment,

      page: () => PaymentScreen(),
      binding: PaymentBinding(),),

    GetPage(
      name: AppRoutes.chat,

      page: () => AllUsersView(),
      binding: AllUsersBinding(),),

    GetPage(
      name: AppRoutes.reviews,

      page: () => ReviewsView(),
      binding: ReviewsBinding(),),

    GetPage(
      name: AppRoutes.favourite,

      page: () => FavouriteView(),
      binding: FavouriteBinding(),),

    GetPage(
      name: AppRoutes.allReviews,

      page: () => AllReviewView(),
      binding: AllReviewsBinding(),),
    GetPage(
      name: AppRoutes.claim,

      page: () => ClaimView(),
      binding: ClaimBinding(),),

    GetPage(
      name: AppRoutes.address,

      page: () => AddAddress(),
      binding: ClaimBinding(),),

    GetPage(
      name: AppRoutes.appointemntDetail,

      page: () => AppointmentDetailView(),
      binding: AppointmentDetailBinidng(),),

    GetPage(
      name: AppRoutes.searchFilter,

      page: () => SearchFilter(),
      binding: SearchBinding(),),

  ];
}
