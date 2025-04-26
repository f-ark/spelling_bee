import 'package:flutter/material.dart';

class MainMenuElevatedButon extends StatelessWidget {
  const MainMenuElevatedButon({
    required this. onPressed,
    required this.title,
    required this.color,
    required this.icon,
    super.key,
  });

  final IconData icon;
  final String title;
  final MaterialColor color;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(80)),
        backgroundColor: WidgetStatePropertyAll(color.shade500),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
        elevation: const WidgetStatePropertyAll(10),
        shadowColor: WidgetStatePropertyAll(color.shade800),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
      ),

      onPressed: onPressed,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, size: 50),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
