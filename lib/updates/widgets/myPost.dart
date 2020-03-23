import 'package:chewie/chewie.dart';
import 'package:covid19_sastra/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class MyPost extends StatelessWidget {
  final String title, uid, description, attachment;
  final int attachmentType;

  const MyPost(
    this.title,
    this.uid,
    this.description,
    this.attachment,
    this.attachmentType,
  );

  @override
  Widget build(BuildContext context) {
    final videoPlayerController = VideoPlayerController.network(attachment);

    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: true,
    );

    final playerWidget = Chewie(
      controller: chewieController,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 16),
            SelectableLinkify(
              text: description,
              onOpen: (ele) => _launchURL(ele.url),
              options: LinkifyOptions(humanize: true),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            if (attachmentType != null)
              if (attachmentType == 0)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(attachment),
                )
              else
                playerWidget
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
