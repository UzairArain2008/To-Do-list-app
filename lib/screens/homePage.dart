import 'package:flutter/material.dart';
import 'package:to_do_list/auth/objects.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedTag = 'All';

  final List<String> allTags = ['All', 'study', 'work', 'personal'];

  final List<Map<String, dynamic>> tasks = [
    {
      'tag': 'study',
      'title': 'Learn Flutter',
      'description': 'State management basics',
      'dateTime': DateTime.now(),
      'isDone': false,
    },
    {
      'tag': 'work',
      'title': 'Build UI',
      'description': 'Homepage layout',
      'dateTime': DateTime.now(),
      'isDone': true,
    },
    {
      'tag': 'personal',
      'title': 'Read book',
      'description': 'Clean Code chapter 1',
      'dateTime': DateTime(2026, 2, 15, 20, 30),
      'isDone': false,
    },
    {
      'tag': 'personal',
      'title': 'Read book 2',
      'description': 'Clean Code chapter 2',
      'dateTime': DateTime(2026, 2, 16, 18, 30),
      'isDone': false,
    },
  ];

  void showAddTaskDialog() {
    String title = '';
    String description = '';
    String tag = 'study';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xffffffff),
          titleTextStyle: TextStyle(color: Color(0xff000000)),
          title: Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  fillColor: Color(0xff000000),
                  label: Text(
                    'Task Title',
                    style: TextStyle(color: Color(0xff000000)),
                  ),
                ),
              ),
              TextField(),
              DropdownButtonFormField<String>(
                value: tag,
                items: allTags
                    .where((t) => t != 'all')
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) tag = value;
                },
              ),
            ],
          ),
          // content: SingleChildScrollView(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       TextField(
          //         decoration: const InputDecoration(
          //           labelText: 'Title',
          //           fillColor: Color(0xff000000),
          //         ),
          //         onChanged: (value) => title = value,
          //       ),
          //       TextField(
          //         decoration: const InputDecoration(labelText: 'Description'),
          //         onChanged: (value) => description = value,
          //       ),
          //       DropdownButtonFormField<String>(
          //         value: tag,
          //         decoration: const InputDecoration(labelText: 'Tag'),
          //         items: allTags
          //             .where((t) => t != 'All')
          //             .map((t) => DropdownMenuItem(value: t, child: Text(t)))
          //             .toList(),
          //         onChanged: (value) {
          //           if (value != null) tag = value;
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    tasks.add({
                      'tag': tag,
                      'title': title,
                      'description': description,
                      'dateTime': DateTime.now(),
                      'isDone': false,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save Task'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> getFilteredTasks() {
    final now = DateTime.now();

    return tasks.where((task) {
      final date = task['dateTime'];
      final tag = task['tag'];

      if (date == null || date is! DateTime) return false;

      final isToday =
          date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      final matchesTag = selectedTag == 'All' || tag == selectedTag;

      return isToday && matchesTag;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = getFilteredTasks();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 20,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            CusAppbar(title: 'Uzair Arain'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Tasks',
                  style: TextStyle(fontFamily: 'ArchivoBlack', fontSize: 30),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF94A3B8),
                  ),
                  child: IconButton(
                    onPressed: showAddTaskDialog,
                    icon: const Icon(Icons.add, color: Color(0xFF222222)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];

                  return TaskCard(
                    tag: task['tag'],
                    title: task['title'],
                    description: task['description'],
                    dateTime: task['dateTime'],
                    isDone: task['isDone'],
                    onToggleDone: () {
                      setState(() {
                        task['isDone'] = !task['isDone'];
                      });
                    },
                    onDelete: () {
                      setState(() {
                        tasks.remove(task);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
