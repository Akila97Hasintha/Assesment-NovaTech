import 'package:assesment/editentry/edit_entry.dart';
import 'package:assesment/home/home.dart';
import 'package:assesment/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:assesment/models/entryModel.dart';

class EntryDetailsPage extends StatelessWidget {
  final EntryModel entry;

  const EntryDetailsPage({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry Details'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color.fromARGB(255, 58, 102, 138),
              Colors.blue.withOpacity(0.5)
            ]
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
             
              height: 300,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
              border: Border.all(
                color: Colors.grey, 
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0), 
            ),
             
              child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text( entry.api,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            const SizedBox(height: 20,),
            Text('Description: ${entry.description}'),
            Text('Auth: ${entry.auth}'),
            Text('Cors: ${entry.cors}'),
            Text('Link: ${entry.link}'),
            Text('Category: ${entry.category}'),
            const SizedBox(height: 20,),
             Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                              Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  EditEntry(entry: entry,)),
                       ); 
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmationDialog(context,entry.api);
                          },
                        ),
                      ],
                    ),

          ],
        ) ,
            ),
          ],
        ),
      ),
    );
  }

  
  Future<Future<bool?>> _showDeleteConfirmationDialog(BuildContext context,String api) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () {
              
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                
                DatabaseHelper.deleteEntry(api);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                       );              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
  
}
