
import 'package:event_platform/core/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../host_part/social/controller/social_controller.dart';
import '../../../host_part/social/widgets/comment_screen.dart';
import '../../../host_part/social/widgets/dynamic_custom_post.dart';

class PersonProfileScreen extends StatefulWidget {

   PersonProfileScreen({super.key});

  @override
  State<PersonProfileScreen> createState() => _PersonProfileScreenState();
}

class _PersonProfileScreenState extends State<PersonProfileScreen> {
  final socialController = Get.put(SocialController());
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final data= Get.arguments;
    final String userName = data[0];
    final String userPhoto = data[1];
    final String userID = data[2];
    return CustomGradient(
      child: SafeArea(
        child: Scaffold(
          appBar: CustomRoyelAppbar(leftIcon: true, titleName: userName),
          backgroundColor: Colors.transparent,
          /*body: SingleChildScrollView(
            child: Obx((){

              if (socialController.rxRequestStatus.value == Status.loading && socialController.posts.isEmpty) {
                return const Center(child: CustomLoader());
              }

              if (socialController.posts.isEmpty) {
                return Center(
                  child: CustomText(
                    text: "No posts found in your feed.",
                    color: AppColors.primary,
                  ),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Profile Image
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [

                            ],
                          ),
                          child: ClipOval(
                            child: CustomNetworkImage(imageUrl: '${ApiUrl.baseUrl}/${userPhoto}',
                                height: 100, width: 100),
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomText(text: userName,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color:AppColors.black,
                        ),
                        CustomText(text: socialController.getUserName("@${userName}"),
                          fontSize: 12,
                          color:AppColors.black_80,
                        ),
                        SizedBox(height: 8),
                        // btn
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Follow Button
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedIndex = 0;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                selectedIndex == 0 ? AppColors.primary : AppColors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: CustomText(
                                text: 'Follow',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedIndex == 0 ? Colors.white : AppColors.black,
                              ),
                            ),

                            const SizedBox(width: 20),

                            // Message Button
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                selectedIndex == 1 ? AppColors.primary : AppColors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: CustomText(
                                text: 'Message',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedIndex == 1 ? Colors.white : AppColors.black,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                  Divider(thickness: 1,color: AppColors.primary,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CustomText(text: 'Follower',
                              fontSize: 16.w,
                              color:AppColors.black,
                              bottom: 12,
                            ),
                            CustomText(text: '2050',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color:AppColors.black,
                            ),
                          ],
                        ),
                        SizedBox(width: 60,),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.dmFollowersScreen);
                          },
                          child: Column(
                            children: [
                              CustomText(text: 'Following',
                                fontSize: 16.w,
                                color:AppColors.black,
                                bottom: 12,
                              ),
                              CustomText(text: '450',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color:AppColors.black,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 60,),
                        Column(
                          children: [
                            CustomText(text: 'Post',
                              fontSize: 16.w,
                              bottom: 12,
                              color:AppColors.black,
                            ),
                            CustomText(text: '10',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color:AppColors.black,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 1,color: AppColors.primary,),
                  ...List.generate(
                    socialController.posts.length,
                        (index) {
                      final post = socialController.posts[index];

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DynamicCustomPost(
                          isFollowed:
                          socialController.isClicked.value,
                          name: userName,
                          time: post.createdAt,
                          post: socialController.posts[index],
                          caption: post.caption ?? '',
                          postImage:
                          '${ApiUrl.baseUrl}/${post.content ?? ''}',
                          totalReacts: post.react.value,
                          totalComments: post.comment,
                          share: post.share,
                          profileImage:
                          '${ApiUrl.baseUrl}/${userPhoto?? ''}',
                          userName: socialController
                              .getUserName(userName),
                          isReacted: post.isReacted.value,
                          onLikePressed: () {
                            socialController.toggleReact(
                                socialController.posts[index]);
                          },
                          onCommentPressed: () async {
                            final String postId =
                                socialController.posts[index].id;
                            final String userId = socialController
                                .posts[index].user.id;
                            debugPrint(
                                "Post ID: $postId+ User ID:$userId");
                            await SharePrefsHelper.setString(
                                'selectedPostId', postId);
                            String savedId =
                            await SharePrefsHelper.getString(
                                'selectedPostId');
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom +
                                        20,
                                  ),
                                  child: CommentScreen(
                                      userId: userId,
                                      postId: postId),
                                );
                              },
                            );
                          },
                          onFollowPressed: () {
                            // debugPrint("Follow botton has been clicked");
                            socialController.toggleFollow();
                            //debugPrint("${socialController.isClicked}  has been clicked");
                          },
                          onSharePressed: () {},
                          onProfileClicked: (){
                            Get.toNamed(AppRoutes.personProfileScreen, arguments:
                            [
                              socialController.posts.first.user.name,
                              socialController.posts.first.user.photo,
                              socialController.posts.first.user.id,
                            ]
                            );
                            debugPrint("/personProfileScreen clicked");
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            }),

          ),*/
        ),
      ),
    );
  }
}
