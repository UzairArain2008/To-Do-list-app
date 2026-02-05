import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CusAppbar(title: Text('Uzair Arain')),
          Expanded(
            child: const Center(
              child: Text(
                "Your tasks go here",
                style: TextStyle(color: Color(0xFFE5E7EB)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CusAppbar extends StatelessWidget {
  CusAppbar({super.key, required this.title});

  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Hello, ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 145, 144, 144),
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
