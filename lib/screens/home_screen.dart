import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../widgets/video_carousel.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<VideoModel> videos = [];

  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  Future<void> loadVideos() async {
    final String response = await rootBundle.loadString('assets/videos.json');
    final data = await json.decode(response) as List;
    setState(() {
      videos = data.map((e) => VideoModel.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flick OTT Prototype")),
      body: videos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          VideoCarousel(title: "Recommended", videos: videos),
          VideoCarousel(title: "Trending", videos: videos),
          VideoCarousel(title: "New Releases", videos: videos),
        ],
      ),
    );
  }
}
