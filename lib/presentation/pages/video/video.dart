import 'package:flutter/material.dart';

import '../../widgets/text.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextW(title: "Video Page"),
      ),
    );
  }
}
