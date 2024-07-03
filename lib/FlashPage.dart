import 'package:flutter/material.dart';

class FlashPage extends StatefulWidget {
  final String frontChar;
  final String backChar;


  const FlashPage({super.key, required this.frontChar, required this.backChar});


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              padding: const EdgeInsets.only(bottom: 55),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.purple[50],
                                border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                                ),
                                child: Text(
                                    widget.frontChar,
                                    style: const TextStyle(fontSize: 200),
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
                              padding: const EdgeInsets.only(bottom: 55),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.purple[50],
                                border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                                ),
                                child: Text(
                                  
                                    widget.backChar,
                                    style: const TextStyle(fontSize: 200),
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(20),
                            ),
                            child: const Icon(Icons.close, size: 50),
                          ),
                          ElevatedButton(
                            onPressed: () {},
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
                        padding: const EdgeInsets.only(bottom: 55),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.purple[50],
                          border: Border.all(color: const Color.fromRGBO(206, 147, 216, 1), width:3,)
                          ),
                          child: Text(
                              widget.frontChar,
                              style: const TextStyle(fontSize: 200),
                          ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
