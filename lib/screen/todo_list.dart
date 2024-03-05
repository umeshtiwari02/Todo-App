
import 'package:flutter/material.dart';
import 'package:todo_app/screen/add_page.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/utils/snack_bar.dart';
import 'package:todo_app/widgets/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchData,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                "No Todo Item",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  return TodoCard(
                      index: index,
                      item: item,
                      navigateToEditPage: navigateToEditPage,
                      deleteById: deleteById);
                }),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text(
          'Add Todo',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    final route =
        MaterialPageRoute(builder: (context) => AddTodoPage(todo: item));
    await Navigator.push(context, route);

    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    await Navigator.push(context, route);

    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> deleteById(String id) async {
    // Delete the item
    final isSuccess = await TodoServices.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage(context, message: "");
    }
  }

  Future<void> fetchData() async {
    final response = await TodoServices.fetchData();

    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: "Something went wrong");
    }
    setState(() {
      isLoading = false;
    });
  }
}
