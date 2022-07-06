import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ownervet/chat/controllers/all_users_controller.dart';
import 'package:ownervet/chat/view/chat_page.dart';
import 'package:ownervet/model/request/all_users.dart';
import 'package:ownervet/utils/const_color.dart';

class AllUsersView extends GetView<AllUsersController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllUsersController>(
        init: Get.put<AllUsersController>(AllUsersController()),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: AppColors.selectedDotColor,
                title: Text(
                  "Farevet",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SafeArea(
                  child: Column(children: [
                Expanded(
                  child: FirebaseAnimatedList(
                      query: controller.query,
                      itemBuilder: (context, snapshot, animation, index) {
                        final json = snapshot.value as Map<dynamic, dynamic>;
                        final message = AllUsers.fromMap(json);
                        print(message.senderId);
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  peerId: message.receiverId!.toString(),
                                  peerAvatar: "",
                                  profileImage: message.senderImage == null
                                      ? ""
                                      : message.senderImage!,
                                  peerNickname: message.reciverName!,
                                  doctorType: message.doctorType == null
                                      ? ""
                                      : message.doctorType!,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        message.senderImage == null ||
                                                message.senderImage!.isEmpty
                                            ? Image.asset(
                                                "assets/images/profiles.png",
                                                height: 20,
                                                width: 20,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                child: ClipRRect(
                                                  child: CachedNetworkImage(
                                                    imageUrl: message
                                                                .senderImage ==
                                                            null
                                                        ? ""
                                                        : message.senderImage!,
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/rectangle.png"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                height: 60,
                                                width: 60,
                                              ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                            child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    message.senderName!,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  )),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        CupertinoIcons.eye,
                                                        color: Colors.grey,
                                                        size: 12,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      message.timpstamp == null
                                                          ? Container()
                                                          : Text(
                                                              readTimestamp(
                                                                int.parse(message
                                                                    .timpstamp!),
                                                              ),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                            )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              message.doctorType == null
                                                  ? Container()
                                                  : Text(
                                                      message.doctorType!,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14),
                                                    ),
                                              message.type == null
                                                  ? Container()
                                                  : Text(
                                                      message.type!,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ])));
        });
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }
}
