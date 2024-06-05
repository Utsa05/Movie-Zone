// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie_zone/constants/theme.dart';

class TextW extends StatelessWidget {
  const TextW(
      {Key? key,
      required this.title,
      this.size,
      this.weight,
      this.color,
      this.align})
      : super(key: key);
  final String title;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align ?? TextAlign.start,
      style: TextStyle(
          color: color ?? AppTheme.white,
          fontWeight: weight ?? FontWeight.normal,
          fontSize: size ?? 14.0),
    );
  }
}
