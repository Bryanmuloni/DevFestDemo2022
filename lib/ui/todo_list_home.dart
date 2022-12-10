import 'package:devfest2022/models/todo_task.dart';
import 'package:flutter/material.dart';

class TodoListHome extends StatefulWidget {
  const TodoListHome({super.key});

  @override
  State<TodoListHome> createState() => _TodoListHomeState();
}

class _TodoListHomeState extends State<TodoListHome> {
  TodoTask todoTask = TodoTask();
  List<TodoTask> todoTaskList = List.generate(
      1,
      (index) => TodoTask(
          taskId: 1,
          taskName: "Sample task",
          taskDescription: "Sample task description",
          startTime: "2pm",
          endTime: "4pm"));

  ///Method to add new task
  void addTodoTaskToList(TodoTask todoTask) {
    todoTaskList.add(todoTask);
    setState(() {});
  }

  ///Method to update existing task
  void updateTodoTaskToList(TodoTask todoTask, int index) {
    todoTaskList[index] = todoTask;
    setState(() {});
  }

  ///Method to remove task from list
  void removeTaskFromList(TodoTask todoTask) {
    todoTaskList.remove(todoTask);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: todoTaskList.isNotEmpty
          ? ListView.builder(
              itemCount: todoTaskList.length,
              itemBuilder: (context, count) {
                TodoTask singleTodoTask = todoTaskList[count];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        singleTodoTask.taskName ?? "-",
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(singleTodoTask.taskDescription ?? "-"),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text("From: ${singleTodoTask.startTime ?? "-"}"),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text("To: ${singleTodoTask.endTime ?? "-"}"),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: "edit",
                              child: Text("Edit"),
                            ),
                            const PopupMenuItem(
                              value: "delete",
                              child: Text("Delete"),
                            ),
                          ];
                        },
                        onSelected: (action) {
                          setState(() {
                            debugPrint("$action item");
                            switch (action) {
                              case 'edit':
                                _openEditTodoTaskDialog(
                                    todoTaskList[count], count);
                                break;
                              case 'delete':
                                removeTaskFromList(todoTaskList[count]);
                                break;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                );
              })
          : const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "No todo tasks to display, click on the + "
                  "button below to create one",
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Create Todo Task"),
        icon: const Icon(Icons.add),
        onPressed: () {
          _openCreateTodoTaskDialog();
        },
      ),
    );
  }

  void _openCreateTodoTaskDialog() {
    GlobalKey<FormState> newTaskFormKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController start = TextEditingController();
    TextEditingController end = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Create New Todo Task"),
            content: Form(
              key: newTaskFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(label: Text("Task Name")),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "Task name is missing";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: description,
                    decoration: const InputDecoration(
                        label: Text("Task "
                            "Description")),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: start,
                    decoration: const InputDecoration(
                        label: Text("Start "
                            "Time")),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "Start time is missing";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: end,
                    decoration: const InputDecoration(label: Text("End Time")),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "End time is missing";
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (newTaskFormKey.currentState!.validate()) {
                      TodoTask task = TodoTask(
                          taskName: name.text,
                          taskDescription: description.text,
                          startTime: start.text,
                          endTime: end.text);
                      addTodoTaskToList(task);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save")),
            ],
          );
        });
  }

  void _openEditTodoTaskDialog(TodoTask selectedTodoTask, int index) {
    GlobalKey<FormState> editTaskFormKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController start = TextEditingController();
    TextEditingController end = TextEditingController();

    name.text = selectedTodoTask.taskName!;
    description.text = selectedTodoTask.taskDescription!;
    start.text = selectedTodoTask.startTime!;
    end.text = selectedTodoTask.endTime!;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Edit Todo Task"),
            content: Form(
              key: editTaskFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(label: Text("Task Name")),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "Task name is missing";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: description,
                    decoration: const InputDecoration(
                        label: Text("Task "
                            "Description")),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: start,
                    decoration: const InputDecoration(
                        label: Text("Start "
                            "Time")),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "Start time is missing";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: end,
                    decoration: const InputDecoration(label: Text("End Time")),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "End time is missing";
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (editTaskFormKey.currentState!.validate()) {
                      TodoTask task = TodoTask(
                          taskName: name.text,
                          taskDescription: description.text,
                          startTime: start.text,
                          endTime: end.text);
                      updateTodoTaskToList(task, index);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Update")),
            ],
          );
        });
  }
}
