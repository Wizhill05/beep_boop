import 'dart:async';

import 'package:beep_boop/extras/commonFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool myTurn = false;
  late final TextEditingController _commandController = TextEditingController();
  int _currentExampleIndex = 0;
  Timer? _timer;

  final List<String> _commandExamples = [
    "type your command here!",
    "wake me up at 5am tomorrow",
    "turn on flashlight",
  ];

  void toggleTurn() {
    setState(() {
      myTurn = !myTurn;
    });
  }

  void _startExamplesCycle() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      debugPrint("Well");
      setState(() {
        _currentExampleIndex =
            (_currentExampleIndex + 1) % _commandExamples.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _commandController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startExamplesCycle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: bgC),
          Column(
            children: [
              SizedBox(height: 36),
              Expanded(
                flex: 2,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: MediaQuery.sizeOf(context).width,
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  padding: const EdgeInsets.all(16),
                  decoration: activeBox(myTurn, 1, 12, 12, 4, 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: GoogleFonts.instrumentSerif(
                                  color: myTurn ? lightC : textCDark,
                                  fontSize: myTurn ? 28 : 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                child: const Text("beep boop"),
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                CupertinoIcons.settings,
                                color: myTurn ? lightC : textCDark,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: Divider(color: myTurn ? lightC : textCDark),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: MediaQuery.sizeOf(context).width,
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: activeBox(!myTurn, 0, 4, 4, 4, 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: GoogleFonts.instrumentSerif(
                                  color: !myTurn ? lightC : textCDark,
                                  fontSize: !myTurn ? 28 : 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                child: const Text("user"),
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                CupertinoIcons.person,
                                color: !myTurn ? lightC : textCDark,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: Divider(color: !myTurn ? lightC : textCDark),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            controller: _commandController,
                            maxLines: 100,
                            enabled: !myTurn,
                            cursorColor: !myTurn ? lightC : textCDark,
                            cursorWidth: 2,
                            decoration: InputDecoration(
                              hintText: _commandExamples[_currentExampleIndex],
                              hintStyle: GoogleFonts.instrumentSerif(
                                color:
                                    !myTurn
                                        ? Colors.grey[700]
                                        : Colors.grey[800],
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            style: GoogleFonts.instrumentSerif(
                              color: !myTurn ? Colors.grey[200] : textCDark,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        height: 64,
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: lightC,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: GoogleFonts.instrumentSerif(
                              color: Colors.grey[900],
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            child: Text("Reset"),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AnimatedContainer(
                        height: 64,
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: !myTurn ? lightC : toColor("191919"),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: GoogleFonts.instrumentSerif(
                              color: !myTurn ? Colors.grey[900] : textCDark,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            child: Text("Command"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleTurn,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
