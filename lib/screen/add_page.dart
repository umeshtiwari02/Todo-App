import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/utils/snack_bar.dart';
import 'package:todo_app/utils/utils.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;

    if (widget.todo != null) {
      isEdit = true;
      final title = todo!['title'];
      final description = todo['description'];

      titleController.text = title;
      descriptionController.text = description;
    }
  }

  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit Todo" : "Add Todo",
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextField(
            controller: titleController,
            focusNode: titleFocusNode,
            // autofocus: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(12),
              hintText: 'Title',
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              Utils.fieldFocusChange(
                  context, titleFocusNode, descriptionFocusNode);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            focusNode: descriptionFocusNode,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'Description',
                labelText: 'Description',
                border: OutlineInputBorder()),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Text(
                isEdit ? "Update" : "Submit",
              )),
        ],
      ),
    );
  }

  Future<void> updateData() async {
    // get the data from form
    final todo = widget.todo;
    if (todo == null) {
      return;
    }
    final id = todo['_id'];
    // submit the updated data to the server
    final isSuccess = await TodoServices.updateTodo(id, body);
    // show success or failure message based on updation status
    if (isSuccess) {
      showSuccessMessage(context, message: "Updation Success");
    } else {
      showErrorMessage(context, message: "Updation Failed");
    }
  }

  Future<void> submitData() async {
    // submit the data to the server
    final isSuccess = await TodoServices.addTodo(body);
    // show success or failure message based on status
    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage(context, message: "Creation Success");
    } else {
      showErrorMessage(context, message: "Creation Failed");
    }
  }

  Map get body {
    // get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };
  }
}
