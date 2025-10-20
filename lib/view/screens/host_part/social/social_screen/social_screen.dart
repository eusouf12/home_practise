import 'dart:io';

import 'package:event_platform/core/app_routes/app_routes.dart';
import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:event_platform/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_nav_bar/dm_navbar.dart';
import '../../../../components/custom_nav_bar/host_navbar.dart';
import '../../../thrillseekers_part/social/widgets/custom_group_card.dart';
import '../../event/widgets/custom_event_tabbar.dart';
import '../../profile/controller/profile_controller.dart';
import '../controller/social_controller.dart';
import '../widgets/comment_screen.dart';
import '../widgets/custom_story.dart';
import '../widgets/dynamic_custom_post.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final socialController = Get.put(SocialController());
  final ProfileController profileController = Get.put(ProfileController());
  String? role; // nullable initially

  @override
  void initState() {
    super.initState();
    loadUserRole(); // load from SharedPref
  }

  Future<void> loadUserRole() async {
    String savedRole = await SharePrefsHelper.getString(AppConstants.role);
    setState(() {
      role = savedRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getUserProfile();
      socialController.getAllStories();
      socialController.fetchInitialPost();
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: false, titleName: "Social Feed"),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Obx(() => Column(
                  children: [
                    /// -------- Tabbar Section --------
                    CustomEventTabbar(
                      textColor: AppColors.white,
                      tabs: socialController.tabNames,
                      selectedIndex: socialController.currentIndex.value,
                      onTabSelected: (value) {
                        socialController.onTabSelected(value);
                      },
                      selectedColor: AppColors.primary,
                    ),
                    SizedBox(height: 20.h),

                    /// -------- Main Section (Based on Tab Index) --------
                    Expanded(
                      child: Builder(builder: (_) {
                        // Tab 1 - Social Feed
                        if (socialController.currentIndex.value == 0) {
                          return Obx(() {
                            if (socialController.rxRequestStatus.value ==
                                    Status.loading &&
                                socialController.posts.isEmpty) {
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

                            return NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (!socialController
                                        .isMoreLoadingPosts.value &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent &&
                                    socialController.currentPagePosts <
                                        socialController.totalPagesPosts) {
                                  socialController.currentPagePosts++;
                                  socialController.getAllPosts();
                                }
                                return true;
                              },
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                children: [
                                  /// -------- Story Section --------
                                  SizedBox(
                                    height: 100.h,
                                    child: Obx(() {
                                      if (socialController
                                              .rxStoryRequestStatus.value ==
                                          Status.loading) {
                                        return const Center(
                                            child: CustomLoader());
                                      }

                                      if (socialController
                                              .rxStoryRequestStatus.value ==
                                          Status.error) {
                                        return const Center(
                                            child:
                                                Text("Failed to load stories"));
                                      }

                                      final groupedStories =
                                          socialController.storiesGroupedByUser;

                                      return ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 10),
                                        itemCount: groupedStories.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(AppRoutes
                                                        .createStoryScreen);
                                                  },
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      CustomNetworkImage(
                                                        imageUrl:
                                                            "${ApiUrl.baseUrl}/${profileController.userProfileModel.value.photo}",
                                                        height: 64.h,
                                                        width: 64.w,
                                                        boxShape:
                                                            BoxShape.circle,
                                                      ),
                                                      const Positioned(
                                                        right: -4,
                                                        bottom: -8,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              AppColors.white,
                                                          radius: 14,
                                                          child: Icon(Icons.add,
                                                              color: AppColors
                                                                  .black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                CustomText(
                                                  top: 12.h,
                                                  text: "Your Story",
                                                  fontSize: 14.w,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ],
                                            );
                                          }

                                          final userId = groupedStories.keys
                                              .elementAt(index - 1);
                                          final userFeeds =
                                              groupedStories[userId]!;

                                          final validFeeds = userFeeds
                                              .where((feed) =>
                                                  feed.content != null ||
                                                  (feed.message != null &&
                                                      feed.message!.isNotEmpty))
                                              .toList();

                                          if (validFeeds.isEmpty)
                                            return const SizedBox.shrink();

                                          final firstFeed = validFeeds.first;
                                          final imgUrl = (firstFeed.content !=
                                                      null &&
                                                  firstFeed
                                                      .content!.isNotEmpty &&
                                                  !firstFeed.content!
                                                      .endsWith('.mp4'))
                                              ? "${ApiUrl.baseUrl}/${firstFeed.content}"
                                              : AppConstants.profileImage;

                                          return CustomStory(
                                            img: imgUrl,
                                            onTap: () {
                                              Get.toNamed(
                                                AppRoutes.postStory,
                                                arguments: validFeeds,
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }),
                                  ),

                                  SizedBox(height: 20.h),

                                  /// -------- Create Post Section --------
                                  Card(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                      side: const BorderSide(
                                          color: AppColors.primary, width: 0.1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: ClipOval(
                                              child: profileController
                                                      .userProfileModel
                                                      .value
                                                      .photo
                                                      .isNotEmpty
                                                  ? Image.network(
                                                      "${ApiUrl.baseUrl}/${profileController.userProfileModel.value.photo}",
                                                      fit: BoxFit.cover,
                                                      height: 45.h,
                                                      width: 50.w,
                                                    )
                                                  : CustomNetworkImage(
                                                      imageUrl: AppConstants
                                                          .profileImage,
                                                      height: 60.h,
                                                      width: 60.w,
                                                      boxShape: BoxShape.circle,
                                                    ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 5,
                                            child: CustomTextField(
                                              fillColor: Colors.transparent,
                                              fieldBorderRadius: 30,
                                              hintText: "Create post?",
                                              readOnly: true,
                                              onTap: () {
                                                Get.toNamed(
                                                    AppRoutes.createPostScreen);
                                              },
                                              hintStyle: const TextStyle(
                                                  color: Color(0xff404040)),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Icon(Icons.image,
                                                color: AppColors.primary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10.h),

                                  /// -------- Posts Section --------
                                  ...List.generate(
                                    socialController.posts.length,
                                    (index) {
                                      final post =
                                          socialController.posts[index];

                                      return DynamicCustomPost(
                                        isFollowed:
                                            socialController.isClicked.value,
                                        name: post.user.name,
                                        time: post.createdAt,
                                        post: post,
                                        caption: post.caption ?? '',
                                        postImage: (post.content != null &&
                                                post.content!.isNotEmpty)
                                            ? '${ApiUrl.baseUrl}/${post.content}'
                                            : null,
                                        totalReacts: post.react.value,
                                        totalComments: post.comment,
                                        share: post.share,
                                        profileImage:
                                            '${ApiUrl.baseUrl}/${post.user.photo ?? ''}',
                                        userName: socialController
                                            .getUserName(post.user.name),
                                        isReacted: post.isReacted,
                                        onLikePressed: () {
                                          debugPrint(
                                              "Before========== ${post.isReacted}");
                                          socialController.toggleReact(post.id);
                                        },

                                        onCommentPressed: () async {
                                          final String postId = post.id;
                                          final String userId = post.user.id;
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
                                          socialController.toggleFollow();
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
                                     //   Eusof
                                     //    onSharePressed: () async {
                                     //      Get.dialog(
                                     //        const Center(child: CustomLoader()),
                                     //        barrierDismissible: false,
                                     //      );
                                     //
                                     //      final String caption = post.caption ?? 'Hay! Check this out!';
                                     //      final String? mediaUrl = (post.content != null && post.content!.isNotEmpty)
                                     //          ? '${ApiUrl.baseUrl}/${post.content}'
                                     //          : null;
                                     //
                                     //      bool shareSuccess = await shareEventPost(
                                     //        caption: caption,
                                     //        fileUrl: mediaUrl,
                                     //      );
                                     //
                                     //      if (shareSuccess && shareStarted && post != null) {
                                     //        final socialController = Get.find<SocialController>();
                                     //        await socialController.sharePostAndCount(post!);
                                     //      }

                                          //Get.back(); // Close loader
                                       // },
                                        /*onSharePressed: () async {
                                            Get.dialog(
                                              const Center(child: CustomLoader()),
                                              barrierDismissible: false,
                                            );

                                            final String caption = post.caption ?? 'Hay! Check this out!';
                                            final String? mediaUrl = (post.content != null && post.content!.isNotEmpty)
                                                ? '${ApiUrl.baseUrl}/${post.content}'
                                                : null;

                                            // Open share sheet
                                            await shareEventPost(caption: caption, fileUrl: mediaUrl);

                                            // Ask user if they actually shared
                                            bool? didShare = await Get.dialog<bool>(
                                              AlertDialog(
                                                title: const Text("Confirm Share"),
                                                content: const Text("Did you actually share this post?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Get.back(result: false),
                                                    child: const Text("No"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => Get.back(result: true),
                                                    child: const Text("Yes"),
                                                  ),
                                                ],
                                              ),
                                              barrierDismissible: false,
                                            );

                                            if (didShare == true && post != null) {
                                              final socialController = Get.find<SocialController>();
                                              await socialController.sharePostAndCount(post!);
                                            }

                                            Get.back(); // Close loader
                                          },*/
                                        // onSharePressed: () async {
                                        //   final socialController =
                                        //       Get.find<SocialController>();
                                        //
                                        //   final result =
                                        //       await showModalBottomSheet<bool>(
                                        //     context: context,
                                        //     shape: const RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           BorderRadius.vertical(
                                        //               top: Radius.circular(20)),
                                        //     ),
                                        //     builder: (context) {
                                        //       return Padding(
                                        //         padding:
                                        //             const EdgeInsets.all(16.0),
                                        //         child: Column(
                                        //           mainAxisSize:
                                        //               MainAxisSize.min,
                                        //           children: [
                                        //             const Text(
                                        //               "Share Post",
                                        //               style: TextStyle(
                                        //                   fontSize: 18,
                                        //                   fontWeight:
                                        //                       FontWeight.bold),
                                        //             ),
                                        //             const SizedBox(height: 10),
                                        //
                                        //             // Share with Followers → automatic API call
                                        //             ListTile(
                                        //               leading: const Icon(
                                        //                   Icons.people),
                                        //               title: const Text(
                                        //                   "Share with Followers"),
                                        //               onTap: () =>
                                        //                   Navigator.pop(
                                        //                       context, true),
                                        //             ),
                                        //
                                        //             // Share to Social Media → system share + manual confirm
                                        //             ListTile(
                                        //               leading: const Icon(
                                        //                   Icons.share),
                                        //               title: const Text(
                                        //                   "Share to Social Media"),
                                        //               onTap: () async {
                                        //                 // Open system share dialog
                                        //                 await Share.share(
                                        //                     'Check out this post: ${post?.caption ?? ''}');
                                        //
                                        //                 // After user closes system share, ask for manual confirmation
                                        //                 bool? didActuallyShare =
                                        //                     await showModalBottomSheet<
                                        //                         bool>(
                                        //                   context: context,
                                        //                   shape:
                                        //                       const RoundedRectangleBorder(
                                        //                     borderRadius:
                                        //                         BorderRadius.vertical(
                                        //                             top: Radius
                                        //                                 .circular(
                                        //                                     20)),
                                        //                   ),
                                        //                   builder: (context) {
                                        //                     return Padding(
                                        //                       padding:
                                        //                           const EdgeInsets
                                        //                               .all(
                                        //                               16.0),
                                        //                       child: Column(
                                        //                         mainAxisSize:
                                        //                             MainAxisSize
                                        //                                 .min,
                                        //                         children: [
                                        //                           const Text(
                                        //                             "Did you actually share this post?",
                                        //                             style: TextStyle(
                                        //                                 fontSize:
                                        //                                     16,
                                        //                                 fontWeight:
                                        //                                     FontWeight.w500),
                                        //                           ),
                                        //                           const SizedBox(
                                        //                               height:
                                        //                                   10),
                                        //                           Row(
                                        //                             mainAxisAlignment:
                                        //                                 MainAxisAlignment
                                        //                                     .spaceEvenly,
                                        //                             children: [
                                        //                               ElevatedButton(
                                        //                                 onPressed: () => Navigator.pop(
                                        //                                     context,
                                        //                                     false),
                                        //                                 child: const Text(
                                        //                                     "No"),
                                        //                               ),
                                        //                               ElevatedButton(
                                        //                                 onPressed: () => Navigator.pop(
                                        //                                     context,
                                        //                                     true),
                                        //                                 child: const Text(
                                        //                                     "Yes"),
                                        //                               ),
                                        //                             ],
                                        //                           ),
                                        //                         ],
                                        //                       ),
                                        //                     );
                                        //                   },
                                        //                 );
                                        //
                                        //                 Navigator.pop(
                                        //                     context,
                                        //                     didActuallyShare ??
                                        //                         false);
                                        //               },
                                        //             ),
                                        //
                                        //             // Cancel / Back
                                        //             ListTile(
                                        //               leading: const Icon(
                                        //                   Icons.close),
                                        //               title:
                                        //                   const Text("Cancel"),
                                        //               onTap: () =>
                                        //                   Navigator.pop(
                                        //                       context, false),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       );
                                        //     },
                                        //   );
                                        //
                                        //   // Only call API if share actually happened
                                        //   if (result == true && post != null) {
                                        //     socialController
                                        //         .isShareLoading.value = true;
                                        //     await socialController
                                        //         .sharePostAndCount(post!);
                                        //   }
                                        // },

                                        onProfileClicked: () {
                                          Get.toNamed(
                                              AppRoutes.personProfileScreen,
                                              arguments: [
                                                post.user.id,
                                                post.user.photo,
                                                post.user.name,
                                              ]);
                                        },
                                      );
                                    },
                                  ),

                                  if (socialController.isMoreLoadingPosts.value)
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(child: CustomLoader()),
                                    ),

                                  SizedBox(height: 100.h),
                                ],
                              ),
                            );
                          });
                        }

                        //Group
                        if (socialController.currentIndex.value == 1) {
                          return Obx(() {
                            if (socialController.isLoadingGroup.value &&
                                socialController.groups.isEmpty) {
                              return const Center(child: CustomLoader());
                            }

                            if (socialController.groups.isEmpty) {
                              return Center(
                                child: CustomText(
                                  text: "No groups available",
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              );
                            }

                            return NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (!socialController
                                        .isMoreLoadingGroup.value &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent &&
                                    socialController.currentPageGroup <
                                        socialController.totalPagesGroup) {
                                  socialController.getAllGroups();
                                }
                                return true;
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10),
                                itemCount: socialController.groups.length +
                                    (socialController.isMoreLoadingGroup.value
                                        ? 1
                                        : 0),
                                itemBuilder: (context, index) {
                                  if (index == socialController.groups.length) {
                                    return const Center(child: CustomLoader());
                                  }

                                  final group = socialController.groups[index];
                                  return CustomGroupCard(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.hostLiveEventDetails,
                                          arguments: group.id);
                                    },
                                    img: group.eventId?.photo ?? "",
                                    groupName: group.groupName,
                                    totalMember: group.totalMember,
                                  );
                                },
                              ),
                            );
                          });
                        }
                        //ChatRoom
                        if (socialController.currentIndex.value == 2) {
                          return Obx(() {
                            if (socialController.isLoadingChatRoom.value &&
                                socialController.chatRooms.isEmpty) {
                              return const Center(child: CustomLoader());
                            }

                            if (socialController.chatRooms.isEmpty) {
                              return Center(
                                child: CustomText(
                                  text: "No chatRooms available",
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              );
                            }

                            return NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (!socialController
                                        .isMoreLoadingChatRoom.value &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent &&
                                    socialController.currentPageChatRoom <
                                        socialController.totalPagesChatRoom) {
                                  socialController.getAllChatRooms();
                                }
                                return true;
                              },
                              child: ListView.builder(
                                padding:
                                    EdgeInsets.only(top: 10.h, bottom: 10.h),
                                itemCount: socialController.chatRooms.length +
                                    (socialController
                                            .isMoreLoadingChatRoom.value
                                        ? 1
                                        : 0),
                                itemBuilder: (context, index) {
                                  if (index ==
                                      socialController.chatRooms.length) {
                                    return const Center(child: CustomLoader());
                                  }

                                  final chatroom =
                                      socialController.chatRooms[index];
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 10.w),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4,
                                              offset: Offset(0, 2)),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text:
                                                    chatroom.chatRoomName ?? "",
                                                fontSize: 16.w,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              CustomText(
                                                text:
                                                    "${chatroom.totalMember} participants",
                                                fontSize: 14.w,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 8.h),
                                            decoration: BoxDecoration(
                                              color: const Color(0xffDCFCE7),
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                            ),
                                            child: Center(
                                              child: CustomText(
                                                text: "Chat",
                                                fontSize: 14.w,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          });
                        }
                        return Container();
                      }),
                    ),
                  ],
                ))),
        bottomNavigationBar: role == null
            ? const SizedBox()
            : role == "host"
            ? HostNavbar(currentIndex: 2)
            : DmNavBar(currentIndex: 3),
      ),
    );
  }
}

//Share Post (text+image+video)
Future<void> shareEventPost({
  required String caption,
  String? fileUrl,
}) async {
  try {
    if (fileUrl != null && fileUrl.isNotEmpty) {
      final uri = Uri.parse(fileUrl);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final bytes = res.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final fileName = fileUrl.split('/').last;
        final filePath = '${tempDir.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(bytes);

        if (file.path.endsWith('.mp4') ||
            file.path.endsWith('.mov') ||
            file.path.endsWith('.avi')) {
          await Share.shareXFiles(
            [XFile(file.path, mimeType: 'video/mp4')],
            text: caption.isNotEmpty ? caption : "Check this event!",
          );
        } else {
          await Share.shareXFiles(
            [XFile(file.path, mimeType: 'image/*')],
            text: caption.isNotEmpty ? caption : "Check this event!",
          );
        }
      } else {
        await Share.share(caption);
      }
    } else {
      await Share.share(caption);
    }
  } catch (e) {
    debugPrint("Error sharing post: $e");
    await Share.share(caption);
  }
}
// bool shareStarted = false;
// Future<bool> shareEventPost({
//   required String caption,
//   String? fileUrl,
// }) async {
//   try {
//     shareStarted = true;
//     if (fileUrl != null && fileUrl.isNotEmpty) {
//       final uri = Uri.parse(fileUrl);
//       final res = await http.get(uri);
//
//       if (res.statusCode == 200) {
//         final bytes = res.bodyBytes;
//         final tempDir = await getTemporaryDirectory();
//         final fileName = fileUrl.split('/').last;
//         final filePath = '${tempDir.path}/$fileName';
//         final file = File(filePath);
//         await file.writeAsBytes(bytes);
//
//         if (file.path.endsWith('.mp4') ||
//             file.path.endsWith('.mov') ||
//             file.path.endsWith('.avi')) {
//           await Share.shareXFiles(
//             [XFile(file.path, mimeType: 'video/mp4')],
//             text: caption.isNotEmpty ? caption : "Check this event!",
//           );
//         } else {
//           await Share.shareXFiles(
//             [XFile(file.path, mimeType: 'image/*')],
//             text: caption.isNotEmpty ? caption : "Check this event!",
//           );
//         }
//         return true;
//       } else {
//         await Share.share(caption);
//         return true;
//       }
//     } else {
//       await Share.share(caption);
//       return true;
//     }
//   } catch (e) {
//     debugPrint("Error sharing post: $e");
//     await Share.share(caption);
//     return false;
//   }
// }
//
//
// Future<bool> shareEventPost({
//   required String caption,
//   String? fileUrl,
// }) async {
//   try {
//     if (fileUrl != null && fileUrl.isNotEmpty) {
//       final uri = Uri.parse(fileUrl);
//       final res = await http.get(uri);
//       if (res.statusCode == 200) {
//         final bytes = res.bodyBytes;
//         final tempDir = await getTemporaryDirectory();
//         final fileName = fileUrl.split('/').last;
//         final filePath = '${tempDir.path}/$fileName';
//         final file = File(filePath);
//         await file.writeAsBytes(bytes);
//
//         if (file.path.endsWith('.mp4') ||
//             file.path.endsWith('.mov') ||
//             file.path.endsWith('.avi')) {
//           await Share.shareXFiles(
//             [XFile(file.path, mimeType: 'video/mp4')],
//             text: caption,
//           );
//         } else {
//           await Share.shareXFiles(
//             [XFile(file.path, mimeType: 'image/*')],
//             text: caption,
//           );
//         }
//         return true; // share sheet opened successfully
//       } else {
//         await Share.share(caption);
//         return true;
//       }
//     } else {
//       await Share.share(caption);
//       return true;
//     }
//   } catch (e) {
//     debugPrint("Error sharing post: $e");
//     return false;
//   }
// }
