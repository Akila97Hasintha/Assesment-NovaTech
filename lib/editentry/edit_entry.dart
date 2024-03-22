import 'package:assesment/provider/entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:assesment/models/entryModel.dart';
import 'package:provider/provider.dart';

class EditEntry extends StatefulWidget {
  final EntryModel entry;

  const EditEntry({Key? key, required this.entry}) : super(key: key);

  @override
  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  late TextEditingController categoryController;
  late TextEditingController descriptionController;
  late TextEditingController authController;
  late TextEditingController corsController;
  late TextEditingController linkController;

  @override
  void initState() {
    super.initState();
    
    categoryController = TextEditingController(text: widget.entry.category);
    descriptionController = TextEditingController(text: widget.entry.description);
    authController = TextEditingController(text: widget.entry.auth);
    corsController = TextEditingController(text: widget.entry.cors);
    linkController = TextEditingController(text: widget.entry.link);
  }

  @override
  void dispose() {
    
    categoryController.dispose();
    descriptionController.dispose();
    authController.dispose();
    corsController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Entry"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color.fromARGB(255, 58, 102, 138),
              Colors.blue.withOpacity(0.5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Consumer<EntryProvider>(
          builder: (context, provider, _) {
          return Column(
            children: [
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: authController,
                decoration: const InputDecoration(labelText: 'Auth'),
              ),
              TextField(
                controller: corsController,
                decoration: const InputDecoration(labelText: 'Cors'),
              ),
              TextField(
                controller: linkController,
                decoration: const InputDecoration(labelText: 'Link'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                 bool updateSuccess = await provider.updateEntry(
                      widget.entry.api,
                      widget.entry.category,
                      descriptionController.text,
                      authController.text,
                      corsController.text,
                      linkController.text
              );
              if (updateSuccess) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Entry updated successfully!')),
                );
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to update entry!')),
                );
              }
              
                },
                child: const Text('Save'),
              ),
            ],
          );
          }
        ),
      ),
    );
  }

 
}
