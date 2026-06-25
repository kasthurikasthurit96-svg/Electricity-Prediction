import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("AI Electricity Predictor"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(),
                  ),
                );

              },

              child: Text("Login"),
            )

          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {

  @override
  _DashboardPageState createState() =>
      _DashboardPageState();
}

class _DashboardPageState
    extends State<DashboardPage> {

  final previousController = TextEditingController();
  final acController = TextEditingController();
  final fanController = TextEditingController();
  final tvController = TextEditingController();

  double predictedUnits = 0;
  double estimatedBill = 0;

  void predictUsage() {

    double previous =
        double.tryParse(previousController.text) ?? 0;

    double ac =
        double.tryParse(acController.text) ?? 0;

    double fan =
        double.tryParse(fanController.text) ?? 0;

    double tv =
        double.tryParse(tvController.text) ?? 0;

    predictedUnits =
        previous +
        (ac * 5) +
        (fan * 2) +
        (tv * 1.5);

    estimatedBill = predictedUnits * 7;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.all(20),

          child: Column(
            children: [

              // Electricity Usage Card

              Card(
                child: ListTile(
                  leading: Icon(Icons.flash_on),

                  title: Text("Current Usage"),

                  subtitle: Text(
                    "${predictedUnits.toStringAsFixed(2)} Units",
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Input Fields

              TextField(
                controller: previousController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: "Previous Units",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: acController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: "AC Usage Hours",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: fanController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: "Fan Usage Hours",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: tvController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: "TV Usage Hours",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: predictUsage,

                child: Text("Predict"),
              ),

              SizedBox(height: 30),

              // Prediction Result

              Card(
                elevation: 5,

                child: Padding(
                  padding: EdgeInsets.all(20),

                  child: Column(
                    children: [

                      Text(
                        "Prediction Result",

                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        "Predicted Units: ${predictedUnits.toStringAsFixed(2)} kWh",

                        style: TextStyle(fontSize: 18),
                      ),

                      SizedBox(height: 10),

                      // Bill Estimation

                      Text(
                        "Estimated Bill: ₹${estimatedBill.toStringAsFixed(2)}",

                        style: TextStyle(fontSize: 18),
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Graph Chart

              Container(
                height: 300,

                child: LineChart(
                  LineChartData(
                    lineBarsData: [

                      LineChartBarData(
                        spots: [

                          FlSpot(1, 100),
                          FlSpot(2, 120),
                          FlSpot(3, 150),
                          FlSpot(4, predictedUnits),

                        ],

                        isCurved: true,
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Alert Notification

              Card(
                color: Colors.red.shade100,

                child: ListTile(
                  leading: Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),

                  title: Text(
                    "High Electricity Usage Alert",
                  ),

                  subtitle: Text(
                    "Reduce appliance usage to save energy.",
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Energy Saving Tips

              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.energy_savings_leaf,
                  ),

                  title: Text(
                    "Energy Saving Tip",
                  ),

                  subtitle: Text(
                    "Turn off unused appliances.",
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}