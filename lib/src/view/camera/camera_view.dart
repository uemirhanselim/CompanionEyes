import 'dart:io';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';

@RoutePage()
class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with SingleTickerProviderStateMixin {
  final Gemini gemini = Gemini.instance;
  final FlutterTts flutterTts = FlutterTts();
  String outputText = '';
  File? selectedImage;
  bool isAnalyzing = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initTts();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Ask to AI", style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedImage != null)
              Expanded(
                flex: 2,
                child: Image.file(selectedImage!),
              ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * (0.7 - (0.4 * _animation.value)),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 25, 95, 122),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _captureAndAnalyzeImage,
                      child: const Text(
                        "Take a picture",
                        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (isAnalyzing)
              const CircularProgressIndicator(color: Colors.blue),
            if (outputText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  outputText,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _captureAndAnalyzeImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        selectedImage = File(file.path);
        outputText = '';
        isAnalyzing = true;
      });
      _controller.forward();
      await _analyzeImage(file);
    }
  }

  Future<void> _analyzeImage(XFile file) async {
    try {
      Uint8List imageBytes = await file.readAsBytes();
      await for (final event in gemini.streamGenerateContent("Describe this picture with details", images: [imageBytes])) {
        String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
        setState(() {
          outputText += response;
        });
      }
      _speakOutput();
    } catch (e) {
      setState(() {
        outputText = "An error occurred: $e";
      });
    } finally {
      setState(() {
        isAnalyzing = false;
      });
    }
  }

  Future<void> _speakOutput() async {
    try {
      await flutterTts.speak(outputText);
    } catch (e) {
      print("TTS error: $e");
    }
  }
}