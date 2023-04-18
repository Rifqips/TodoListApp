import 'package:flutter/material.dart';
import 'package:flutter_todolist_app/model/todo_item.dart';
import 'package:flutter_todolist_app/utils/network_manager.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong ya';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(hintText: "Description"),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong ya';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final item = TodoItem(
                    title: titleController.text,
                    description: descController.text,
                    isDone: false,
                  );
                  if (item.title!.isNotEmpty && item.description!.isNotEmpty) {
                    await NetworkManager().postData(item);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
