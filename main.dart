import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imageUrl =
      "https://img.freepik.com/free-photo/wet-sphere-reflective-water-abstract-beauty-generated-by-ai_188544-19616.jpg";

  Future<void> shareImage() async {
    try {
      // Load the image from assets
      final ByteData data = await rootBundle.load('assets/water_image.avif');

      // Create a temporary directory
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/water_image.avif');

      // Write the image data to the temporary file
      await file.writeAsBytes(data.buffer.asUint8List());

      // Share the file using the share_plus package
      await Share.shareXFiles([XFile(file.path)],
          text: 'Check out this image!');
    } catch (e) {
      print("Error sharing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 100, left: 12, right: 12),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              shareImage();
            },
            child: Image.network(imageUrl),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Click on the image to share')
        ],
      ),
    ));
  }
}