import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GridItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  GridItem({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            height: 100,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(title,
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
