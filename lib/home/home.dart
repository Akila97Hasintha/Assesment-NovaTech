import 'package:assesment/models/entryModel.dart';
import 'package:assesment/provider/entry_provider.dart';
import 'package:assesment/services/api_service.dart';
import 'package:assesment/services/db_helper.dart';
import 'package:assesment/view/entri_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> categories = ["Animals", "Business", "Cryptocurrency", "Books", "Development", "Environment", "Finance"];
  String? selectedCategory;
  

@override
  void initState() {
    // TODO: implement initState
    super.initState();
   // fetchDataAndSaveToDB();
    Provider.of<EntryProvider>(context, listen: false).fetchEntries();
    selectedCategory = categories.isNotEmpty ? categories.first : null;
    
  }
  @override
  Widget build(BuildContext context) {
    
  

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("My app")),
        backgroundColor: Colors.blue,
       actions: [
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue;
              });
            },
            items: categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(width: 10), 
        ],
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
        child: Consumer<EntryProvider>(
          builder: (context, provider, _) {
            if (provider.entries.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: provider.entries
                    .where((entry) => selectedCategory == null || entry.category == selectedCategory)
                    .length,
                itemBuilder: (context, index) {
                  EntryModel entry = provider.entries
                      .where((entry) => selectedCategory == null || entry.category == selectedCategory)
                      .toList()[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                  elevation: 4.0, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                    child: ListTile(
                      title: Text(entry.api,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${entry.description}'),
                        Text('Auth: ${entry.auth}'),
                        Text('Cors: ${entry.cors}'),
                        Text('Link: ${entry.link}'),
                        Text('Category: ${entry.category}'),
                      ],
                    ),
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EntryDetailsPage(entry: entry),
                        ),
                      );
                      },
                    ),
                  );
                },
              );
            }
          },
        
        ),
      ),
    );
  }
}