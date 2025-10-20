import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:event_platform/view/screens/thrillseekers_part/profile/controller/dm_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../../host_part/social/controller/social_controller.dart';
import '../../../../host_part/social/social_screen/social_screen.dart';
import '../../../../host_part/social/widgets/comment_screen.dart';
import '../../../../host_part/social/widgets/dynamic_custom_post.dart';
import '../../controller/home_controller/dm_home_controller.dart';
import '../../widget/custom_live_details/custom_live_comment.dart';
import '../../widget/custom_live_details_post/custom_live_details_post.dart';

class DmLiveEventDetails extends StatelessWidget {
  DmLiveEventDetails({super.key});
  final DmHomeController dmHomeController = Get.put(DmHomeController());
  final DmProfileController dmProfileController = Get.put(DmProfileController());
  final SocialController socialController = Get.put(SocialController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      dmHomeController.getLiveEventDetails();
      dmHomeController.getAllPosts();
      dmHomeController.getLiveComment();
      socialController.fetchInitialPost();
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: 'Live Details'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Obx(() {
            if (dmHomeController.rxLiveEventRequestStatus.value == Status.loading) {
              return const Center(child: CustomLoader());
            }
            if (dmHomeController.rxLiveEventRequestStatus.value == Status.error) {
              return  Center(child: Text("Failed to load Events Details"));
            }
            if (dmHomeController.specificEvent.value ==  null) {
              return  Center(child: Text("No live events details found"));
            }
            final event = dmHomeController.specificEvent.value!;
            return Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    // card ing
                    CustomNetworkImage(
                      imageUrl:'${ApiUrl.baseUrl}/${event.photo }',
                      height: 200.h,
                      width: MediaQuery.sizeOf(context).width,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //before 1st divider
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Live Jazz Night
                              CustomText(
                                text: event.eventTitle??" ",
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                bottom: 4,
                              ),

                              CustomText(
                                text:event.description??" ",
                                maxLines: 3,
                                textAlign: TextAlign.start,
                                bottom: 8,
                              ),
                              // joined+Invited+18+
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //joined
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.group),
                                        SizedBox(width: 5),
                                        CustomText(
                                          text: 'Joined',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      Get.toNamed(AppRoutes.invitedScreen);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.red,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.group_add,
                                            color: AppColors.white,
                                          ),
                                          SizedBox(width: 5),
                                          CustomText(
                                            text: 'Invite',
                                            color: AppColors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        text: event.audienceSettings?.age ??"",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 13),
                              //Venue
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.venueFacility,
                                  arguments: event.venueFacilities);
                                },
                                child: Container(
                                  height: 48,
                                  width: 121,
                                  decoration: BoxDecoration(
                                    color: AppColors.greyLight,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: CustomText(
                                    text: 'Venue Facility',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1, color: AppColors.primary,),
                        // write something
                        Padding(
                          padding: const EdgeInsets.symmetric( horizontal: 14, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomNetworkImage(
                                imageUrl:dmProfileController.userProfileModel.value.photo != null?"${ApiUrl.baseUrl}/${dmProfileController.userProfileModel.value.photo}" : AppConstants.profileImage,
                                height: 50.h,
                                width: 50.w,
                                boxShape: BoxShape.circle,
                              ),
                              SizedBox( width: 5,),
                              Expanded(
                                child: CustomTextField(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.createPostLive,arguments: {"eventId": event.id});
                                  },
                                  hintText: 'Write Something....',
                                  hintStyle: TextStyle( color: AppColors.black_80,),
                                  fillColor: Colors.transparent,
                                  fieldBorderColor: Colors.black,
                                  readOnly: true,
                                  fieldBorderRadius: 15,
                                ),
                              ),
                              SizedBox(
                                width: 22,
                              ),
                              InkWell(
                                onTap: () {
                                  // Get.toNamed(AppRoutes.createPostScreen);
                                },
                                child: Icon(Icons.image),
                              ),
                            ],
                          ),
                        ),
                        // live comment
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, right: 10, bottom: 19),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.video_call,
                                color: AppColors.red,
                              ),
                              CustomText(
                                text: 'Live Comments',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                left: 5,
                                // right: 60,
                              ),
                              Spacer(),
                              //clock
                              Icon(Icons.access_time),
                              CustomText(
                                text: '01:20 Hours',
                                left: 7,
                                right: 15,
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1, color: AppColors.black),
                        //cmt scroll
                        Obx(() => Container(
                          height: 262,
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemCount: dmHomeController.comments.length,
                              reverse: true,
                              separatorBuilder: (_, __) => const SizedBox(height: 20),
                              itemBuilder: (context, index) {
                                final comment = dmHomeController.comments[index];
                                return CustomLiveComment(
                                  title2: comment.createdAt.toString().substring(11, 19)?? "00:00",
                                  subtitle: comment.comments ?? "",
                                  title: comment.user!.name ?? "",
                                  preImg: '${ApiUrl.baseUrl}/${comment.user!.photo ?? ''}'

                                );
                              },
                            ),
                          ),
                        )),

                        SizedBox(height: 16),
                        //Write a comment
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: Row(
                              children: [
                                CustomNetworkImage(
                                  imageUrl:dmProfileController.userProfileModel.value.photo != null?"${ApiUrl.baseUrl}/${dmProfileController.userProfileModel.value.photo}" : AppConstants.profileImage,
                                  height: 50.h,
                                  width: 50.w,
                                  boxShape: BoxShape.circle,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: CustomTextField(
                                    fillColor: AppColors.greyLight,
                                    hintText: 'Write a comment',
                                    inputTextStyle: TextStyle(color: AppColors.black),
                                    hintStyle: TextStyle(color: AppColors.black),
                                    fieldBorderRadius: 15,
                                    textEditingController: dmHomeController.commentController.value,
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: (){
                                    dmHomeController.liveComment(eventId: event.id!);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColors.primary,
                                    ),
                                    child: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        //Ata niye pore kaj hobe aro
                        // ListView.builder(
                        //   itemCount: dmHomeController.posts.length,
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   itemBuilder: (context, index) {
                        //     final post = dmHomeController.posts[index];
                        //     final postId = post.id ?? '';
                        //
                        //     return Obx(() {
                        //       //bool isFollowed = dmHomeController.isFollowedMap[postId] ?? false;
                        //
                        //       return CustomLiveDetailsPost(
                        //        // isFollowed: isFollowed,
                        //         name: post.userId?.name ?? "Unknown User",
                        //         profileImage: (post.userId?.photo != null && post.userId!.photo!.isNotEmpty) ? '${ApiUrl.baseUrl}/${post.userId!.photo}' : AppConstants.profileImage,
                        //         time: post.createdAt ?? DateTime.now(),
                        //         userName: dmHomeController.getUserName(post.userId?.name?? ""),
                        //         //post+Title
                        //         postImage: (post.content != null && post.content!.isNotEmpty) ? '${ApiUrl.baseUrl}/${post.content}' : "",
                        //         caption: post.caption ?? '',
                        //         //Rect+comment+share
                        //         totalReacts: post.react ?? 0,
                        //         totalComments: post.comment ?? 0,
                        //         share: post.share,
                        //         isReacted: true,
                        //         onLikePressed: () {
                        //            dmHomeController.toggleReact(post.id!);
                        //         },
                        //         onCommentPressed: () async {
                        //           final String postId = post.id!;
                        //           final String userId = post.userId?.id ?? "";
                        //           showModalBottomSheet(
                        //             context: context,
                        //             isScrollControlled: true,
                        //             useSafeArea: true,
                        //             backgroundColor: Colors.transparent,
                        //             builder: (context) {
                        //               return Padding(
                        //                 padding: EdgeInsets.only(
                        //                   bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        //                 ),
                        //                 child: CommentScreen(userId: userId, postId: postId),
                        //               );
                        //             },
                        //           );
                        //         },
                        //         //User section
                        //         onProfileClicked: () {
                        //           Get.toNamed(
                        //             AppRoutes.personProfileScreen,
                        //             arguments: [
                        //               post.userId?.id ?? "",
                        //               post.userId?.photo,
                        //               post.userId?.name,
                        //             ],
                        //           );
                        //         },
                        //         //Share section
                        //         onSharePressed: () async {
                        //           Get.dialog(
                        //             const Center(child: CircularProgressIndicator()),
                        //             barrierDismissible: false,
                        //           );
                        //           final String caption = post.caption ?? 'Hey! Check this out!';
                        //           final String? mediaUrl = (post.content != null && post.content!.isNotEmpty)
                        //               ? '${ApiUrl.baseUrl}/${post.content}'
                        //               : null;
                        //
                        //           // await shareEventPost(
                        //           //   caption: caption,
                        //           //   fileUrl: mediaUrl,
                        //           // );
                        //           Get.back();
                        //         },
                        //
                        //         onFollowPressed: () {
                        //           dmHomeController.toggleFollow(post.userId!.id!);
                        //           debugPrint("User Id====================${post.userId!.id!}");
                        //         },
                        //         post: null,
                        //       );
                        //     });
                        //   },
                        // )
                        Obx(() {
                          return ListView.builder(
                            itemCount: dmHomeController.posts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final post = dmHomeController.posts[index];
                              final postId = post.id ?? '';

                              return CustomLiveDetailsPost(
                                name: post.userId?.name ?? "Unknown User",
                                profileImage: (post.userId?.photo != null && post.userId!.photo!.isNotEmpty)
                                    ? '${ApiUrl.baseUrl}/${post.userId!.photo}'
                                    : AppConstants.profileImage,
                                time: post.createdAt ?? DateTime.now(),
                                userName: dmHomeController.getUserName(post.userId?.name ?? ""),
                                postImage: (post.content != null && post.content!.isNotEmpty)
                                    ? '${ApiUrl.baseUrl}/${post.content}'
                                    : "",
                                caption: post.caption ?? '',
                                totalReacts: post.react ?? 0,
                                totalComments: post.comment ?? 0,
                                share: post.share,
                                isReacted: true,
                                onLikePressed: () {
                                  dmHomeController.toggleReact(post.id!);
                                },
                                onCommentPressed: () async {
                                  final String postId = post.id!;
                                  final String userId = post.userId?.id ?? "";
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                                        ),
                                        child: CommentScreen(userId: userId, postId: postId),
                                      );
                                    },
                                  );
                                },
                                onProfileClicked: () {
                                  Get.toNamed(
                                    AppRoutes.personProfileScreen,
                                    arguments: [
                                      post.userId?.id ?? "",
                                      post.userId?.photo,
                                      post.userId?.name,
                                    ],
                                  );
                                },
                                onSharePressed: () async {
                                  Get.dialog(
                                    const Center(child: CustomLoader()), barrierDismissible: false,);
                                  final String caption = post.caption ??
                                      'Hay! Check this out!';
                                  final String? mediaUrl = (post.content != null && post.content!.isNotEmpty)
                                      ? '${ApiUrl.baseUrl}/${post.content}'
                                      : null;

                                  await shareEventPost(
                                    caption: caption,
                                    fileUrl: mediaUrl,
                                  );

                                  Get.back();
                                },
                                onFollowPressed: () {
                                  dmHomeController.toggleFollow(post.id!);
                                },
                                post: null,
                              );
                            },
                          );
                        }),



                      ],
                    ),
                  ],
                ),
              );


          }),
        ),
      ),
    );
  }
}
