import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomGalleryCard extends StatefulWidget {
  final String? img;
  final String? title;
  final bool isLove;
  final String? isFavourite;
  final VoidCallback? onLoveTap;

  const CustomGalleryCard({super.key, this.img, this.title, this.isLove=false, this.isFavourite, this.onLoveTap});

  @override
  State<CustomGalleryCard> createState() => _CustomGalleryCardState();
}

class _CustomGalleryCardState extends State<CustomGalleryCard> {

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isVideo = false;

  @override
  void initState() {
    super.initState();
    if (widget.img != null && widget.img!.toLowerCase().endsWith('.mp4')) {
      _isVideo = true;
      _initializeVideo(widget.img!);
    }
  }

  Future<void> _initializeVideo(String url) async {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
    await _videoController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoController!.value.aspectRatio,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isVideo
                ? Stack(
              alignment: Alignment.center,
              children: [
                //Thumbnail
                _videoController != null &&
                    _videoController!.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                )
                    : Container(
                  height: 244.h,
                  width: double.infinity,
                  color: Colors.black12,
                  child: const Center(
                      child: CircularProgressIndicator()),
                ),

                //  Play icon overlay
                const Icon(
                  Icons.play_circle_fill,
                  color: Colors.white70,
                  size: 64,
                ),

                //  Chewie full player show
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (_chewieController != null) {
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              insetPadding: const EdgeInsets.all(10),
                              backgroundColor: Colors.black,
                              child: AspectRatio(
                                aspectRatio: _videoController!
                                    .value.aspectRatio,
                                child: Chewie(
                                    controller: _chewieController!),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
                : CustomNetworkImage(
              imageUrl: widget.img ?? "",
              height: 244.h,
              width: double.infinity,
            ),

            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.title ?? 'Unknown',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: widget.onLoveTap,
                        child: Icon(
                          Icons.favorite,
                          size: 18.r,
                          color: widget.isLove ? AppColors.red : AppColors.black_02,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      CustomText(
                        text: widget.isFavourite ?? " ",
                        fontSize: 14.sp,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
