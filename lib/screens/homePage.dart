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
            Tasks(),
          ],
        ),
      ),
    );
  }
}

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Color(0xffcccccc), width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Study Time', style: TextTheme.of(context).titleMedium),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xff000000)),
            ),
          ],
        ),
      ),
    );
  }
}
