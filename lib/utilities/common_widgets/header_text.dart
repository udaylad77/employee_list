import 'package:flutter/material.dart';

// Heading
class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Description
class DescText extends StatelessWidget {
  final String boldtext;
  final String normaltext;

  const DescText({Key? key, required this.boldtext, required this.normaltext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: normaltext,
            style: DefaultTextStyle.of(context).style,
          ),
          TextSpan(
            text: boldtext,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
