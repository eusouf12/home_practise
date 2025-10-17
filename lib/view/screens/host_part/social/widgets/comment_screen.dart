import 'package:event_platform/view/screens/host_part/social/controller/social_controller.dart';
import 'package:event_platform/view/screens/host_part/social/model/socal_feed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../service/api_url.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String userId;

  const CommentScreen({super.key, required this.postId, required this.userId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final SocialController controller = Get.put(SocialController());

  @override
  void initState() {
    super.initState();
    controller.getComment();
  }

  Widget _buildComment(AllCommentPost comment) {
    final commentId = comment.id ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Comment Row =====
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: "${ApiUrl.baseUrl}/${comment.user?.photo}",
                height: 35,
                width: 35,
                boxShape: BoxShape.circle,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: comment.user?.name ?? "Unknown",
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(text: comment.comment ?? ""),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _showReplyField(comment, context);
                          },
                          child: const CustomText(
                            text: 'Reply',
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        InkWell(
                          onTap: () async {
                            // Fetch replies for this comment
                            await controller.getReplies(commentId);
                            comment.isRepliesVisible.toggle();
                          },
                          child: Obx(() => CustomText(
                                text: comment.isRepliesVisible.value &&
                                        comment.replies != null
                                    ? 'Hide replies'
                                    : 'View replies',
                                fontSize: 13,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ===== Replies =====
          Obx(() {
            if (comment.isRepliesVisible.isFalse) return const SizedBox();

            final replies = controller.commentReplies[commentId] ?? [];

            if (controller.isReplyLoading.value) {
              return const Padding(
                padding: EdgeInsets.only(left: 45.0, top: 6),
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            }

            if (replies.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(left: 45.0, top: 6),
                child: CustomText(
                  text: "No replies yet",
                  fontSize: 12,
                  color: Colors.grey,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(left: 45.0, top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: replies.map<Widget>((reply) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomNetworkImage(
                          imageUrl:
                              "${ApiUrl.baseUrl}/${reply['userId']?['photo']}",
                          height: 28,
                          width: 28,
                          boxShape: BoxShape.circle,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: reply['userId']?['name'] ?? 'User',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 100,
                                text: reply['comment'] ?? '',
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const CustomText(
              text: 'Comments',
              fontWeight: FontWeight.w600,
            ),
            const Divider(),

            // ===== Comments List =====
            Expanded(
              child: Obx(() {
                if (controller.isCommentLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.comments.isEmpty) {
                  return const Center(
                      child: CustomText(text: "No comments yet"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: controller.comments.length,
                  itemBuilder: (context, index) {
                    final comment = controller.comments[index];
                    return _buildComment(comment);
                  },
                );
              }),
            ),

            // ===== Add Comment Box =====
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.commentController.value,
                      decoration: InputDecoration(
                        hintText: "Add a comment...",
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(() => controller.isPostingComment.value
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : IconButton(
                          onPressed: () {
                            controller.postComment(postId: widget.postId);
                          },
                          icon: const Icon(Icons.send, color: Colors.blue),
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final SocialController controller = Get.find<SocialController>();

void _showReplyField(AllCommentPost comment, BuildContext context) {
  final TextEditingController replyController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: replyController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Reply to ${comment.user?.name ?? 'user'}...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Obx(() => controller.isReplyingComment.value
                ? const CircularProgressIndicator(strokeWidth: 2)
                : IconButton(
                    onPressed: () {
                      controller.postReply(
                        parentCommentId: comment.id ?? '',
                        replyText: replyController.text,
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.send, color: Colors.blue),
                  )),
          ],
        ),
      );
    },
  );
}
