import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataFunctions.dart';
import 'FourPage.dart';
import 'FlashPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_bar_chart/progress_bar_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paatam',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: 40,
              fontVariations: [FontVariation('wght', 750), FontVariation('wdth', 150)]),
        ),
      ),
      home: const MyHomePage(title: 'PAATAM'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValueInput = 'English';
  String dropdownValueOutput = 'Telugu';

  var itemsInput = [
    'English',
    'Telugu',
    'Hindi',
    'Kannada',
    'Malayalam'
  ];

  var itemsOutput = [
    'Telugu',
    'Tamil',
    'Hindi',
    'Kannada',
    'Malayalam'
  ];

  // final List<StatisticsItem> stats = [
  // StatisticsItem(Colors.blue, 500, title: 'Type 1'),
  // StatisticsItem(Colors.green, 200, title: 'Type 2'),
  // StatisticsItem(Colors.red, 300, title: 'Type 3'),
  // StatisticsItem(Colors.yellow, 100, title: 'Type 4'),
  // ];

  late Future<List<List<dynamic>>> vowelList;
  late Future<List<List<dynamic>>> consonantList;
  late Future<List<List<dynamic>>> clusterList;

  @override

  void initState() {
    super.initState();
    _loadLanguageSettings();
    _saveLists();
    _loadLists();

  }

  void _loadLanguageSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    dropdownValueInput = prefs.getString('inputLanguage') ?? 'English';
    dropdownValueOutput = prefs.getString('outputLanguage') ?? 'Telugu';
  });
  _updateLists();
}

  void _updateLists() {
    vowelList = parseJsonTo2DArray("vowels", dropdownValueInput, dropdownValueOutput);
    consonantList = parseJsonTo2DArray("consonants", dropdownValueInput, dropdownValueOutput);
    clusterList = parseJsonTo2DArray("clusters", dropdownValueInput, dropdownValueOutput);
    _saveLists();
    _loadLists();
  }

  void _saveLanguageSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('inputLanguage', dropdownValueInput);
  await prefs.setString('outputLanguage', dropdownValueOutput);
}

void _saveLists() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<List<dynamic>> resolvedVowelList = await vowelList;
  List<List<dynamic>> resolvedConsonantList = await consonantList;
  List<List<dynamic>> resolvedClusterList = await clusterList;

  await prefs.setString('Vowels', jsonEncode(resolvedVowelList));
  //List<StatisticsItem> vowelStats = await listStats(vowelList);

  await prefs.setString('Consonants', jsonEncode(resolvedConsonantList));
  //List<StatisticsItem> vowelStats = await listStats(vowelList);

  await prefs.setString('Clusters', jsonEncode(resolvedClusterList));
  //List<StatisticsItem> vowelStats = await listStats(vowelList);

}



Future<void> _loadLists() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<List<dynamic>> loadedVowelList = (jsonDecode(prefs.getString('Vowels') ?? '[]') as List)
      .map((e) => List<dynamic>.from(e)).toList();
  List<List<dynamic>> loadedConsonantList = (jsonDecode(prefs.getString('Consonants') ?? '[]') as List)
      .map((e) => List<dynamic>.from(e)).toList();
  List<List<dynamic>> loadedClusterList = (jsonDecode(prefs.getString('Clusters') ?? '[]') as List)
      .map((e) => List<dynamic>.from(e)).toList();

  setState(() {
    vowelList = Future.value(loadedVowelList);
    consonantList = Future.value(loadedConsonantList);
    clusterList = Future.value(loadedClusterList);
  });
}


Future<List<StatisticsItem>> listStats(Future<List<List<dynamic>>> futureList) async {
  List<List<dynamic>> list = await futureList; // Wait for the Future to complete
  
  final List<StatisticsItem> stats = [];

  for (var Data in list) {
    int masteryLevel = Data[2];

    // Determine color based on mastery level
    Color barColor;
    if (masteryLevel <= 2) {
      barColor = Colors.red;
    } else if (masteryLevel <= 4) {
      barColor = Colors.yellow;
    } else {
      barColor = Colors.green;
    }

    // Create a StatisticsItem and add it to the list
    stats.add(StatisticsItem(barColor, masteryLevel.toDouble(), title: Data[0]));
  }

  return stats;
}


  void _openSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Paatam Settings"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDropdown(
                  context, "Input language:", dropdownValueInput, itemsInput,
                  (String? newValue) {
                setState(() {
                  dropdownValueInput = newValue!;
                });
              }),
              const SizedBox(height: 10),
              _buildDropdown(
                  context, "Output language:", dropdownValueOutput, itemsOutput,
                  (String? newValue) {
                setState(() {
                  dropdownValueOutput = newValue!;
                });
              }),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                _saveLanguageSettings();
                  setState(() {
                    _updateLists();
                  });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDropdown(BuildContext context, String label, String value,
      List<String> items, ValueChanged<String?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(width: 10),
        DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              _openSettingsDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisSpacing: 12,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 0.80,
                children: <Widget>[
                  _buildGridItem(
                      "Vowels", vowelList, 
                      CupertinoIcons.arrow_turn_right_down),
                  _buildGridItem(
                      "Consonants", consonantList,
                      CupertinoIcons.arrow_turn_right_down),
                  _buildGridItem(
                      "Clusters", clusterList, 
                      CupertinoIcons.arrow_turn_right_down),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildGridItem(String title, Future<List<List<dynamic>>> list,
      IconData icon) {
    return GestureDetector(
      onTap: () {
        _saveLists();
        _loadLists();
        openPage(list, context, title);
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.purple[50],
          border: Border.all(
              color: const Color.fromRGBO(206, 147, 216, 1), width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.purple[400],
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontVariations: [
                          FontVariation('wght', 750),
                          FontVariation('wdth', 150)
                        ]),
                  ),
                ),
              ),
            ),
            GridView.count(
              //primary: false,
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 1.0, 
              mainAxisSpacing: 1.0,  
              padding: const EdgeInsets.all(1),
              children: const <Widget>[
                Center(
                  child: AutoSizeText(
                      "a",
                      style: const TextStyle(fontSize: 400.0, fontWeight: FontWeight.bold),
                      maxLines: 1, // Limit the text to 2 lines
                      minFontSize: 20.0, // Minimum font size
                      overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                    ),
                  ),
                Center(child: Icon(CupertinoIcons.arrow_turn_right_down)),
                Center(child: Icon(CupertinoIcons.arrow_turn_down_right)),
                Center(
                    child: 
                      AutoSizeText(
                        "అ",
                        style: const TextStyle(fontSize: 400.0, fontWeight: FontWeight.bold),
                        maxLines: 1, // Limit the text to 2 lines
                        minFontSize: 20.0, // Minimum font size
                        overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                      ),
                ),
              ],
            ),
            FutureBuilder<List<StatisticsItem>>(
              future: listStats(list),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Handle any errors
                } else if (snapshot.hasData) {
                  return ProgressBarChart(
                    values: snapshot.data!,
                    height: 20,
                    borderRadius: 5,
                    totalPercentage: 1100,
                    unitLabel: 'kg',
                  );
                } else {
                  return const Text('No data available'); // Handle the case where there's no data
                }
              },
            )

          ],
        ),
      ),
    );
  }
}
