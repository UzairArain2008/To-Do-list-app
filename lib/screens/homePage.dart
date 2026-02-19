import 'package:flutter/material.dart';
import 'package:to_do_list/auth/objects.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedTag = 'All';

  final List<String> allTags = ['All', 'Study', 'Work', 'Personal'];

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

  void showAddTaskBottomSheet() {
    String title = '';
    String description = '';
    String tag = 'Study';
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Task',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    label: Text(
                      'Task Title',
                      style: TextStyle(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  onChanged: (value) => title = value,
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    label: Text(
                      'Task Description',
                      style: TextStyle(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  onChanged: (value) => description = value,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Tag',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                  ),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  items: allTags
                      .where((t) => t != 'All')
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) tag = value;
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    label: Text(
                      'Select Date',
                      style: TextStyle(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: selectedDate != null
                        ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                        : '',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.access_time, color: Colors.blue),
                    label: Text(
                      'Select Time',
                      style: TextStyle(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime ?? TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedTime = pickedTime;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: selectedTime != null
                        ? "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                        : '',
                  ),
                ),
                SizedBox(height: 24),
                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (title.isNotEmpty &&
                            description.isNotEmpty &&
                            selectedDate != null &&
                            selectedTime != null) {
                          setState(() {
                            tasks.add({
                              'tag': tag,
                              'title': title,
                              'description': description,
                              'dateTime': DateTime(
                                selectedDate!.year,
                                selectedDate!.month,
                                selectedDate!.day,
                                selectedTime!.hour,
                                selectedTime!.minute,
                              ),
                              'isDone': false,
                            });
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Save Task'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
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
                    onPressed: showAddTaskBottomSheet,
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
