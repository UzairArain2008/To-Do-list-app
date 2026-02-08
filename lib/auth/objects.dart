import 'package:flutter/material.dart';

class CusAppbar extends StatelessWidget {
  const CusAppbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   border: Border.all(color: Colors.white, width: sqrt1_2),
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              image: const DecorationImage(
                image: AssetImage('assets/pfp.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Hey, ",
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: title,
                        style: const TextStyle(
                          color: Color(0xFFE5E7EB),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Keep Track of You Daily Tasks'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String tagName;
  final bool isSelected;
  final VoidCallback onTap;

  const TagChip({
    super.key,
    required this.tagName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF94A3B8), width: 2),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? const Color(0xFF94A3B8) : Colors.transparent,
        ),
        child: Text(
          '#$tagName',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? const Color(0xff222222)
                : const Color(0xFF94A3B8),
          ),
        ),
      ),
    );
  }
}
