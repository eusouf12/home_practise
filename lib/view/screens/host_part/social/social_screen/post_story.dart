import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:get/get.dart';
import '../../../../../service/api_url.dart';
import '../model/story_model.dart';

class PostStory extends StatefulWidget {
  const PostStory({super.key});

  @override
  State<PostStory> createState() => _PostStoryState();
}

class _PostStoryState extends State<PostStory> {
  final StoryController controller = StoryController();
  late final List<FeedModel> feeds;
  late final List<Map<String, String>> stories;

  @override
  void initState() {
    super.initState();

    // Receive feeds passed from SocialScreen
    feeds = (Get.arguments as List<FeedModel>?) ?? [];

    // Map feeds to story_view compatible format safely
    stories = feeds.map((FeedModel feed) {
      final contentUrl = feed.content?.isNotEmpty == true
          ? "${ApiUrl.baseUrl}/${feed.content}"
          : null;

      if (contentUrl != null && contentUrl.endsWith('.mp4')) {
        return {
          "type": "video",
          "content": contentUrl,
          "caption": feed.message ?? ""
        };
      } else if (contentUrl != null) {
        return {
          "type": "image",
          "content": contentUrl,
          "caption": feed.message ?? ""
        };
      } else {
        return {
          "type": "text",
          "content": feed.message ?? "No content",
          "caption": ""
        };
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Handle empty stories
    if (stories.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            "No stories to display",
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: StoryView(
          controller: controller,
          storyItems: stories.map((story) {
            switch (story["type"]) {
              case "text":
                return StoryItem.text(
                  title: story["content"] ?? "",
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                );
              case "image":
                return StoryItem.inlineImage(
                  url: story["content"] ?? "",
                  controller: controller,
                  caption: Text(
                    story["caption"] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                );
              case "video":
                return StoryItem.pageVideo(
                  story["content"] ?? "",
                  controller: controller,
                  duration: const Duration(seconds: 5),
                  caption: Text(
                    story["caption"] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                );
              default:
                return StoryItem.text(
                  title: "Unknown type",
                  backgroundColor: Colors.grey,
                );
            }
          }).toList(),
          onStoryShow: (storyItem, index) {
            debugPrint("Showing story index: $index");
          },
          onComplete: () {
            debugPrint("All stories completed!");
            Get.back(); // back to SocialScreen
          },
          progressPosition: ProgressPosition.top,
          repeat: false,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
