import 'package:flutter/material.dart';

class FourPage extends StatefulWidget {
  const FourPage({super.key});

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
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
          child: Padding(
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
                          child: const Text(
                            
                              'అ',
                              style: TextStyle(fontSize: 200),
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
