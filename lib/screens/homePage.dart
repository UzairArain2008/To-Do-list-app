import 'package:flutter/material.dart';
import 'package:to_do_list/auth/objects.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedTag = 'All';

  List<String> allTags = ['All', 'study', 'work', 'personal', 'test'];

  final List<Map<String, dynamic>> tasks = [
    {'title': 'Learn Flutter', 'isDone': false, 'tag': 'study'},
    {'title': 'Build UI', 'isDone': true, 'tag': 'work'},
    {'title': 'Read book', 'isDone': false, 'tag': 'personal'},
  ];

  @override
  Widget build(BuildContext context) {
    // final filteredTasks = tasks
    //     .where((task) => task['tag'] == selectedTag)
    //     .toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          children: [
            CusAppbar(title: 'Uzair Arain'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Tasks',
                  style: TextStyle(fontFamily: 'ArchivoBlack', fontSize: 30),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF94A3B8), width: 2),
                    color: Color(0xFF94A3B8),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 30,
                    icon: Icon(Icons.add, color: Color(0xFF222222)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: allTags.map((tag) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TagChip(
                      tagName: tag.toUpperCase(),
                      isSelected: selectedTag == tag,
                      onTap: () {
                        setState(() {
                          selectedTag = tag;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            Tasks(isdone: false),
          ],
        ),
      ),
    );
  }
}

class Tasks extends StatelessWidget {
  Tasks({super.key, required this.isdone});

  bool isdone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('object'),
      child: Container(
        width: double.infinity,
        height: 120,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Color(0xffcccccc), width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                isdone = true;
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isdone ? Color(0xff22C35D) : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: isdone
                        ? Color.fromARGB(136, 204, 204, 204)
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
