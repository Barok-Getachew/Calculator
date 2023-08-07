import 'package:calculator/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswers = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(children: [
        Expanded(
            child: Container(
          child: Column(children: [
            Container(
              child: Text(
                userQuestion,
                style: TextStyle(fontSize: 20),
              ),
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
            ),
            Container(
              child: Text(
                userAnswers,
                style: TextStyle(fontSize: 20),
              ),
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
            ),
          ]),
        )),
        Expanded(
          flex: 2,

          // ignore: sort_child_properties_last
          child: Container(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Buttons(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                        });
                      },
                      Color: Colors.green,
                      buttonText: buttons[index],
                      textcolor: Colors.white);
                }
                if (index == 1) {
                  return Buttons(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                      Color: Colors.red,
                      buttonText: buttons[index],
                      textcolor: Colors.white);
                }
                if (index == buttons.length - 1) {
                  return Buttons(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      Color: Colors.deepPurple,
                      buttonText: buttons[index],
                      textcolor: Colors.white);
                } else {
                  return Buttons(
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      Color: (isOperator(buttons[index]))
                          ? Colors.deepPurple
                          : Colors.deepPurple[50],
                      buttonText: buttons[index],
                      textcolor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.deepPurple);
                }
              },
              itemCount: buttons.length,
            ),
          ),
        ),
      ]),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    Parser p = Parser();
    Expression exp = p.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswers = eval.toString();
  }
}
