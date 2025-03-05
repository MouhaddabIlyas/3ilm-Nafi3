import 'package:flutter/material.dart';

class ClickableThemeItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final String routeName;

  const ClickableThemeItem({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
