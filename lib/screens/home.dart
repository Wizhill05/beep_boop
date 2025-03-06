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
  // Create a focus node to manage focus state
  final FocusNode _focusNode = FocusNode();

  final List<String> _commandExamples = [
    "type your command here!",
    "wake me up at 5am tomorrow.",
    "turn on flashlight.",
  ];

  void toggleTurn() {
    setState(() {
      myTurn = !myTurn;
    });
  }

  void _startExamplesCycle() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
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
    _focusNode.dispose(); // Dispose the focus node
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startExamplesCycle();
    // Add listener to text controller to rebuild when text changes
    _commandController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if text field has content
    bool hasText = _commandController.text.isNotEmpty;
    // Command button should only appear when there's text AND it's user's turn (not myTurn)
    bool showCommandButton = hasText && !myTurn;

    return GestureDetector(
      // Add gesture detector to unfocus when tapping outside
      onTap: () {
        // This unfocuses the text field when tapping anywhere else
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                              focusNode:
                                  _focusNode, // Add focus node to textfield
                              maxLines: 100,
                              enabled: !myTurn,
                              cursorColor: !myTurn ? lightC : textCDark,
                              cursorWidth: 2,
                              decoration: InputDecoration(
                                hintText:
                                    _commandExamples[_currentExampleIndex],
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
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            myTurn = false;
                            setState(() {
                              _commandController.clear();
                            });
                          },
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
                      ),
                      Expanded(
                        child: GestureDetector(
                          // Make sure taps on the button don't unfocus
                          behavior: HitTestBehavior.opaque,
                          onTap:
                              showCommandButton
                                  ? () {
                                    toggleTurn(); // Example action - toggle turn
                                  }
                                  : null,
                          child: AnimatedOpacity(
                            opacity: showCommandButton ? 1.0 : 0.5,
                            duration: const Duration(milliseconds: 300),
                            child: AnimatedContainer(
                              height: 64,
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color:
                                    showCommandButton
                                        ? lightC
                                        : toColor("191919"),
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
                                    color:
                                        showCommandButton
                                            ? Colors.grey[900]
                                            : textCDark,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  child: Text("Command"),
                                ),
                              ),
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
      ),
    );
  }
}
