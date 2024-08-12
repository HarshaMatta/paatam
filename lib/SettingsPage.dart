import 'package:flutter/material.dart';
import 'DataFunctions.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String dropdownnvalue = 'English';
  var items = [
    'English',
    'Telugu',
    'Hindi',
    'Kannada',
    'Malayalam'
  ];
  String dropdownnvalue1 = 'Telugu';
  var items1 = [
    'Telugu',
    'Tamil',
    'Hindi',
    'Kannada',
    'Malayalam'
  ];

Future<List<List<dynamic>>> vowelList= parseJsonTo2DArray("vowels", "English", "Telugu");
Future<List<List<dynamic>>> consonantList= parseJsonTo2DArray("consonants", "English", "Telugu");
Future<List<List<dynamic>>> clusterList= parseJsonTo2DArray("clusters", "English", "Telugu");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Paatam Settings'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 1, // Adjust the number of columns here
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 4,
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                color: const Color.fromARGB(255, 239, 215, 255),
                height: 10,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: Text('Input language: ')),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownnvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownnvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                color: const Color.fromARGB(255, 239, 215, 255),
                height: 10,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: Text('Output language: ')),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownnvalue1,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items1.map((String items1) {
                              return DropdownMenuItem(
                                value: items1,
                                child: Text(items1),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownnvalue1 = newValue!;  
                              });
                              
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}