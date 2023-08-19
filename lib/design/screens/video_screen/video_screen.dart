import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;
  final LessonModel lesson;
  const VideoScreen({super.key, required this.videoUrl, required this.lesson});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    _chewieController = ChewieController(
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl)),
      aspectRatio: 16 / 9,
      autoInitialize: true,
      allowPlaybackSpeedChanging: true,
      showControls: true,
      allowFullScreen: true,
      allowMuting: true,
      looping: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.primaryColor,
        handleColor: AppColors.successColor,
        backgroundColor: AppColors.backgroundColor,
        bufferedColor: AppColors.accentColor,
      ),
      placeholder: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 6,
        ),
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text("Error loading lesson. Please try again later.",
              style: AppTextStyles.labelLarge),
        );
      },
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.pause();
    _chewieController.videoPlayerController.pause();
    _chewieController.videoPlayerController.removeListener(() {});
    _chewieController.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              FontAwesomeIcons.arrowLeft,
              color: AppColors.backgroundColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: AppColors.textColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: appDefaultPadding,
            vertical: appDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.lesson.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.displaySmall
                    .copyWith(color: AppColors.backgroundColor),
              ),
              Gap(AppLayout.getHeight(appDefaultSpacing)),
              AspectRatio(
                aspectRatio: 2 / 3,
                child: Chewie(controller: _chewieController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
