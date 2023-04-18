import 'package:flutter/material.dart';
import 'package:flutter_todolist_app/pages/form_page.dart';
import 'package:flutter_todolist_app/pages/todo_done_page.dart';
import 'package:flutter_todolist_app/utils/network_manager.dart';
import 'package:flutter_todolist_app/widgets/item_widget.dart';

import '../model/todo_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TodoItem> todos = [];
  bool isLoading = false;
  int totalDone = 0;

  void refreshData() {
    setState(() {
      isLoading = true;
    });
    NetworkManager().getTodosIsDone(true).then((value) {
      totalDone = value.length;
      setState(() {});
    });
    NetworkManager().getTodosIsDone(false).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List App'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Todo List",
                  style: textTheme.bodyText1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const TodoDonePage();
                        }),
                      );
                    },
                    child: Text(
                      "Sudah diselesaikan $totalDone",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: todos.isEmpty
                        ? const Center(
                            child: Text('tidak ada data'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return ItemWidget(
                                todoItem: todos[index],
                                handlerRefresh: refreshData,
                              );
                            },
                            itemCount: todos.length,
                          ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return FormPage();
            },
          ));
          refreshData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
