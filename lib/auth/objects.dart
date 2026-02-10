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

class TaskCard extends StatelessWidget {
  final String tag;
  final String title;
  final String description;
  final String timeLeft;
  final bool isDone;
  final VoidCallback onToggleDone;

  const TaskCard({
    super.key,
    required this.tag,
    required this.title,
    required this.description,
    required this.timeLeft,
    required this.isDone,
    required this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onToggleDone,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isDone ? const Color(0xff22c35d) : Colors.transparent,
                border: Border.all(
                  color: isDone
                      ? const Color(0xff22c35d)
                      : const Color(0xFF94A3B8).withOpacity(0.25),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff22c35d).withOpacity(0.25),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xff22c35d),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDone ? const Color(0xFF94A3B8) : Colors.black,
                    decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2.5,
                  ),
                ),

                Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),

                // const SizedBox(height: 4),

                // Text(
                //   timeLeft,
                //   style: const TextStyle(fontSize: 12, color: Colors.redAccent),
                // ),
              ],
            ),
          ),

          PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
            icon: const Icon(Icons.more_vert, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }
}
