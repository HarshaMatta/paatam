import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paatam/DataFunctions.dart';
import 'SettingsPage.dart';
import 'FourPage.dart';
import 'FlashPage.dart';
import 'DataFunctions.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paatam',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontSize:40, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)])
        )
      ),
      home: const MyHomePage(title: 'PAATAM', ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
        actions: const <Widget>
        [ SettingsButton(), ]

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
                  GestureDetector(
                    onTap: () { 
                      openPage(vowelList, context);
                    },

                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.purple[50],
                        border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Colors.purple[400],
                                  child:const Align(
                                    alignment: Alignment.center, 
                                    child: Text("Vowels", 
                                    style: TextStyle( color: Colors.white, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)]),
                                    ),
                                  ),
                                ),
                              ), 
                    
                                  GridView.count(
                                    primary: false,
                                    shrinkWrap: true,
                                    // padding: const EdgeInsets.all(00),
                                    // crossAxisSpacing: 10,
                                    // mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    children: const <Widget>[
                                      Center(child: Text("a", style: TextStyle(fontSize: 30, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)]),)),
                                      Center(child: Icon(CupertinoIcons.arrow_turn_right_down)),
                                      Center(child: Icon(CupertinoIcons.arrow_turn_down_right)),
                                      Center(child: Text("అ", style: TextStyle(fontSize: 30, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)], fontFamily: "Noto"),)),
                                    ],
                                  ),
                          ],
                    //அ
                      ), 
                    ),
                  ),
                  GestureDetector(
                    onTap: () { 
                      openPage(consonantList, context);
                    },

                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.purple[50],
                        border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Colors.purple[400],
                                  child:const Align(
                                    alignment: Alignment.center, 
                                    child: Text("Consonants", 
                                    style: TextStyle( color: Colors.white, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)]),
                                    ),
                                  ),
                                ),
                              ), 
                    
                    
                                  GridView.count(
                                    primary: false,
                                    shrinkWrap: true,
                                    // padding: const EdgeInsets.all(00),
                                    // crossAxisSpacing: 10,
                                    // mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    children: const <Widget>[
                                      Center(child: Text("ka", style: TextStyle(fontSize: 30, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)]),)),
                                      Center(child: Icon(CupertinoIcons.arrow_turn_right_down)),
                                      Center(child: Icon(CupertinoIcons.arrow_turn_down_right)),
                                      Center(child: Text("క", style: TextStyle(fontSize: 30, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)], fontFamily: "Noto"),)),
                                    ],
                                  ),
                          ],
                    
                      ),
                    
                    ),
                  ),
                  GestureDetector(
                    onTap: () { 
                      openPage(clusterList, context);
                    },

                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.purple[50],
                        border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Colors.purple[400],
                                  child:const Align(
                                    alignment: Alignment.center, 
                                    child: Text("Clusters", 
                                    style: TextStyle( color: Colors.white, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)]),
                                    ),
                                  ),
                                ),
                              ), 
                    
                    
                                  GridView.count(
                                    primary: false,
                                    shrinkWrap: true,
                                    // padding: const EdgeInsets.all(00),
                                    // crossAxisSpacing: 10,
                                    // mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    children: const <Widget>[
                                      Center(child: Text("kra", style: TextStyle(fontSize: 30, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)]),)),
                                      Center(child: Icon(CupertinoIcons.arrow_turn_right_down)),
                                      Center(child: Icon(CupertinoIcons.arrow_turn_down_right)),
                                      Center(child: Text("క్ర", style: TextStyle(fontSize: 30, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)], fontFamily: "Noto"),)),
                                    ],
                                  ),
                          ],
                    
                      ),
                    
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.purple[50],
                      border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget> [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.purple[400],
                                child:const Align(
                                  alignment: Alignment.center, 
                                  child: Text("Vowels", 
                                  style: TextStyle( color: Colors.white, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)]),
                                  ),
                                ),
                              ),
                            ), 

                                GridView.count(
                                  primary: false,
                                  shrinkWrap: true,

                                  crossAxisCount: 2,
                                  children: const <Widget>[
                                    
                                    Center(child: Text("a", style: TextStyle(fontSize: 30, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)]),)),
                                    Center(child: Icon(CupertinoIcons.arrow_turn_right_down)),
                                    Center(child: Icon(CupertinoIcons.arrow_turn_down_right)),
                                    Center(child: Text("అ", style: TextStyle(fontSize: 30, fontVariations:[FontVariation('wght', 750), FontVariation('wdth', 150)], fontFamily: "Noto"),)),
                                  ],
                                ),
                        ],

                    ),
                  
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsButton extends StatefulWidget {
  const SettingsButton({super.key});

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Settings',
          onPressed: () {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsPage(title : "settings Page")));
            });
          },
        ),
      ],
    );
  }
}