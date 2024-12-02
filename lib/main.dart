import 'package:flutter/material.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savings Planner Project',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  double _savings = 0.0;
  double _salary = 0.0;
  double _expenses = 0.0;
  String _resultText = "";

  void updateSavings(String saving) {
    try {
      double doubleSavings = double.parse(saving);
      setState(() {
        this._savings = doubleSavings;
      });
    }
    catch (e) {
      this._savings = 0;
    }
  }

  void updateSalary(String salary) {
    try {
      double doubleSalary = double.parse(salary);
      setState(() {
        this._salary = doubleSalary;
      });
    }
    catch (e) {
      this._salary = 0;
    }
  }

  void updateExpenses(String expenses) {
    try {
      double doubleExpenses = double.parse(expenses);
      setState(() {
        this._expenses = doubleExpenses;
      });
    }
    catch (e) {
      this._expenses = 0;
    }
  }

  void calculateScenarios() {
    double remainingBalance = this._salary - this._expenses;

    if (this._savings <= 0 || this._salary <= 0 ||
        this._expenses >= this._salary) {
      setState(() {
        this._resultText =
        'Invalid inputs. Please check your data and try again.';
      });
      return;
    }
    double conservativeSavings = remainingBalance * 0.3;
    double moderateSavings = remainingBalance * 0.5;
    double aggressiveSavings = remainingBalance * 0.75;

    double conservativeFreeMoney = remainingBalance - conservativeSavings;
    double moderateFreeMoney = remainingBalance - moderateSavings;
    double aggressiveFreeMoney = remainingBalance - aggressiveSavings;

    int monthsConservative = (this._savings / conservativeSavings).ceil();
    int monthsModerate = (this._savings / moderateSavings).ceil();
    int monthsAggressive = (this._savings / aggressiveSavings).ceil();

    setState(() {
      _resultText = '''
    Conservative Savings Plan (30%):
    - Save: \$${conservativeSavings.toStringAsFixed(2)} per month
    - Free Money: \$${conservativeFreeMoney.toStringAsFixed(2)} per month
    - Months to Goal: $monthsConservative

    Moderate Savings Plan (50%):
    - Save: \$${moderateSavings.toStringAsFixed(2)} per month
    - Free Money: \$${moderateFreeMoney.toStringAsFixed(2)} per month
    - Months to Goal: $monthsModerate

    Aggressive Savings Plan (75%):
    - Save: \$${aggressiveSavings.toStringAsFixed(2)} per month
    - Free Money: \$${aggressiveFreeMoney.toStringAsFixed(2)} per month
    - Months to Goal: $monthsAggressive
    ''';
    });
  }

  void resetFields() {
    setState(() {
      this._savings = 0.0;
      this._expenses = 0.0;
      this._salary = 0.0;
      this._resultText = "";
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Savings Planner',
            style: TextStyle(fontSize: 22.0, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blueGrey[60],
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Savings Goal',
                          style: TextStyle(fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        SizedBox(height: 8.0),
                        SizedBox(
                          width: 170,
                          child: TextField(
                            onChanged: updateSavings,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter desired savings'),
                            style: TextStyle(fontSize: 14.0, color: Colors
                                .black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly Salary',
                          style: TextStyle(fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        SizedBox(height: 8.0),
                        SizedBox(
                          width: 170,
                          child: TextField(
                            onChanged: updateSalary,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter monthly salary'),
                            style: TextStyle(fontSize: 14.0, color: Colors
                                .black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Fixed Expenses',
                          style: TextStyle(fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        SizedBox(height: 8.0,),
                        SizedBox(
                          width: 190,
                          child: TextField(
                            onChanged: updateExpenses,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter total fixed expenses',
                            ),
                            style: TextStyle(fontSize: 14.0, color: Colors
                                .black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: calculateScenarios
                      , child: Text(
                        'Calculate',
                        style: TextStyle(fontSize: 16.0, color: Colors.teal),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton(onPressed: resetFields, child: Text('Reset',
                      style: TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  _resultText,
                  style: const TextStyle(fontSize: 14.0, color: Colors.teal),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        )
    );
  }
}
