import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
class OverlappingCardCount extends StatelessWidget {
  final List<String> imageUrls;
  final int totalCount;
  final double avatarSize;
  final double  overlap;

  const OverlappingCardCount({
    super.key,
    required this.imageUrls,
    required this.totalCount,
    this.avatarSize = 30,
    this.overlap = 15,
  });

  @override
  Widget build(BuildContext context) {
    double stackWidth =
        avatarSize + (imageUrls.length - 1) * (avatarSize - overlap);

    return Row(
      children: [
        SizedBox(
          width: stackWidth,
          height: avatarSize,
          child: Stack(
            children: List.generate(imageUrls.length, (index) {
              return Positioned(
                left: index * (avatarSize - overlap),
                child: ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: imageUrls[index] ,
                    height: 26.h,
                    width: 26.w,
                    boxShape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "+${totalCount - imageUrls.length}",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
