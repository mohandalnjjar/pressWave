import 'package:flutter/material.dart';

class IconWithUnderlineText extends StatelessWidget {
  const IconWithUnderlineText({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
  });
  final IconData iconData;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(iconData),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }
}
