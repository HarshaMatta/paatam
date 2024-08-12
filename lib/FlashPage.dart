import 'package:flutter/material.dart';
import 'DataFunctions.dart';
import 'main.dart';
import 'package:auto_size_text/auto_size_text.dart';


class FlashPage extends StatefulWidget {
  final String frontChar;
  final String backChar;
  final Future<List<List<dynamic>>> list;


  const FlashPage({super.key, required this.frontChar, required this.backChar, required this.list});


  @override
  State<FlashPage> createState() => _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {
  bool _showCardContent = false;

  void _toggleCardContent() {
    setState(() {
      _showCardContent = !_showCardContent;
    });
  }

  void _updateAndOpenPage(BuildContext context, Future<List<List<dynamic>>> list, bool correct) async {
    var updatedList = changeIndex(list, correct);
    setState(() {
      list = updatedList;
    });
    //debugPrint(vowelList); // Log the updated vowelList
    openPage(list, context);
  }



  @override
  Widget build(BuildContext context ) {
    

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(title: 'PAATAM')),
        ),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GestureDetector(
        onTap: _toggleCardContent,
        child: Center(
          child: _showCardContent
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                     Padding(
                      padding: const EdgeInsets.only(top:100.0, left:30, right: 30),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: Container(
                              alignment: Alignment.center,
                              height: 300,
//                              padding: const EdgeInsets.only(bottom: 55),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.purple[50],
                                border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                                ),
                                child: AutoSizeText(
                                  widget.frontChar,
                                  style: const TextStyle(fontSize: 300.0, fontWeight: FontWeight.bold),
                                  maxLines: 2, // Limit the text to 2 lines
                                  minFontSize: 20.0, // Minimum font size
                                  overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                ),
                          ),
                        ),
                      ),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(top:20.0, left:30, right: 30),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: Container(
                              alignment: Alignment.center,
                              height: 300,
//                              padding: const EdgeInsets.only(bottom: 55),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.purple[50],
                                border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                                ),
                                child: AutoSizeText(
                                  widget.backChar,
                                  style: const TextStyle(fontSize: 300.0, fontWeight: FontWeight.bold),
                                  maxLines: 2, // Limit the text to 2 lines
                                  minFontSize: 20.0, // Minimum font size
                                  overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _updateAndOpenPage(context, widget.list, false);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(20),
                            ),
                            child: const Icon(Icons.close, size: 50),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _updateAndOpenPage(context, widget.list, true);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(20),
                            ),
                            child: const Icon(Icons.check, size: 50),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Padding(
                padding: const EdgeInsets.only(top:100.0, left:30, right: 30),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Container(
                        alignment: Alignment.center,
                        height: 300,
//                        padding: const EdgeInsets.only(bottom: 55),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.purple[50],
                          border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                          ),
                          child: AutoSizeText(
                            widget.frontChar,
                            style: const TextStyle(fontSize: 300.0, fontWeight: FontWeight.bold),
                            maxLines: 2, // Limit the text to 2 lines
                            minFontSize: 20.0, // Minimum font size
                            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                          ),
                          // Text(
                          //     widget.frontChar,
                          //     style: const TextStyle(fontSize: 200),
                          // ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
