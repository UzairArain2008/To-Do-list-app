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
      'timeLeft': '2 hrs',
      'isDone': false,
    },
    {
      'tag': 'work',
      'title': 'Build UI',
      'description': 'Homepage layout',
      'timeLeft': '1 hr',
      'isDone': true,
    },
    {
      'tag': 'personal',
      'title': 'Read book',
      'description': 'Clean Code chapter 1',
      'timeLeft': '30 min',
      'isDone': false,
    },
    {
      'tag': 'personal',
      'title': 'Read book',
      'description': 'Clean Code chapter 1',
      'timeLeft': '30 min',
      'isDone': false,
    },
  ];

  void showAddTaskDialog() {
    String title = '';
    String description = '';
    String tag = 'study'; // default
    String timeLeft = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Task title
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  onChanged: (value) => title = value,
                ),

                // Task description
                TextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  onChanged: (value) => description = value,
                ),

                // Task tag
                DropdownButtonFormField<String>(
                  value: tag,
                  decoration: const InputDecoration(labelText: 'Tag'),
                  items: allTags
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) tag = value;
                  },
                ),

                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Time left (e.g. 2 hrs)',
                  ),
                  onChanged: (value) => timeLeft = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty &&
                    description.isNotEmpty &&
                    timeLeft.isNotEmpty) {
                  setState(() {
                    tasks.add({
                      'tag': tag,
                      'title': title,
                      'description': description,
                      'timeLeft': timeLeft,
                      'isDone': false,
                    });
                  });
                  Navigator.of(context).pop(); // close dialog
                }
              },
              child: const Text('Save Task'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = selectedTag == 'All'
        ? tasks
        : tasks
              .where(
                (task) =>
                    task['tag'].toLowerCase() == selectedTag.toLowerCase(),
              )
              .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
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

            // const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];

                    return TaskCard(
                      tag: task['tag'],
                      title: task['title'],
                      description: task['description'],
                      timeLeft: task['timeLeft'],
                      isDone: task['isDone'],
                      onToggleDone: () {
                        setState(() {
                          tasks[index]['isDone'] = !tasks[index]['isDone'];
                        });
                      },
                      onDelete: () {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
