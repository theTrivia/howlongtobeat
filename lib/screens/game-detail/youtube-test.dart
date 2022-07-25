import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hltb/model/youtube-video.dart';
import 'package:youtube_api/youtube_api.dart';

import '../../static.dart';

class YoutubeTest {
  static fetchVideo(videoGameName) async {
    String apiKey = ProjectVariables.YOUTUBE_API_KEY;
    YoutubeAPI ytApi = new YoutubeAPI(apiKey);
    var videoResult;
    String query = videoGameName;

    try {
      await ytApi.search(query, type: 'video').then((result) async {
        videoResult = YoutubeVideo(
          result[0].channelId,
          result[0].channelTitle,
          result[0].channelUrl,
          result[0].description,
          result[0].duration,
          result[0].id,
          result[0].kind,
          result[0].publishedAt,
          result[0].thumbnail,
          result[0].title,
          result[0].url,
        );
      });
      print(videoResult);
      return videoResult;
    } catch (e) {
      print(e);
    }
  }
}
