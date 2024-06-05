import 'package:flutter/material.dart';
import 'package:movie_zone/presentation/widgets/text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextW(title: "Profile Page"),
      ),
    );
  }
}
