import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataFunctions.dart';
import 'FourPage.dart';
import 'FlashPage.dart';

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

  late Future<List<List<dynamic>>> vowelList;
  late Future<List<List<dynamic>>> consonantList;
  late Future<List<List<dynamic>>> clusterList;

  @override
  void initState() {
    super.initState();
    _updateLists();
  }

  void _updateLists() {
    vowelList = parseJsonTo2DArray("vowels", dropdownValueInput, dropdownValueOutput);
    consonantList = parseJsonTo2DArray("consonants", dropdownValueInput, dropdownValueOutput);
    clusterList = parseJsonTo2DArray("clusters", dropdownValueInput, dropdownValueOutput);
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
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                children: <Widget>[
                  _buildGridItem(
                      "Vowels", vowelList, CupertinoIcons.arrow_turn_right_down),
                  _buildGridItem("Consonants", consonantList,
                      CupertinoIcons.arrow_turn_right_down),
                  _buildGridItem(
                      "Clusters", clusterList, CupertinoIcons.arrow_turn_right_down),
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
        openPage(list, context);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
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
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: const <Widget>[
                Center(
                    child: Text(
                  "a",
                  style: TextStyle(
                      fontSize: 30,
                      fontVariations: [
                        FontVariation('wght', 750),
                        FontVariation('wdth', 150)
                      ]),
                )),
                Center(child: Icon(CupertinoIcons.arrow_turn_right_down)),
                Center(child: Icon(CupertinoIcons.arrow_turn_down_right)),
                Center(
                    child: Text(
                  "అ",
                  style: TextStyle(
                      fontSize: 30,
                      fontVariations: [
                        FontVariation('wght', 750),
                        FontVariation('wdth', 150)
                      ],
                      fontFamily: "Noto"),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
