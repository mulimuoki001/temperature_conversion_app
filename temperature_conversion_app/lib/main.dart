import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConversionApp());
}

class TemperatureConversionApp extends StatefulWidget {
  @override
  _TemperatureConversionAppState createState() =>
      _TemperatureConversionAppState();
}

class _TemperatureConversionAppState extends State<TemperatureConversionApp> {
  bool isFahrenheitToCelsius = true;

  List<ConversionHistory> conversionHistory = [];

  double temperature = 10.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > constraints.maxHeight) {
            // Landscape layout
            return _buildLandscapeLayout(context, constraints);
          } else {
            // Portrait layout
            return _buildPortraitLayout(context, constraints);
          }
        },
      ),
    );
  }

  Widget _buildPortraitLayout(
      BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Temperature Conversion',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, size: 30, color: Colors.white),
            onPressed: () {
              setState(() {
                conversionHistory.clear();
              });
              // Implement home functionality here
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.purple,
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Conversion Type:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20, width: 30),
            Row(
              children: <Widget>[
                SizedBox(width: 25),
                Radio(
                  value: true,
                  groupValue: isFahrenheitToCelsius,
                  onChanged: (value) {
                    setState(() {
                      isFahrenheitToCelsius = true;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'Fahrenheit to Celsius',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Radio(
                  value: false,
                  groupValue: isFahrenheitToCelsius,
                  onChanged: (value) {
                    setState(() {
                      isFahrenheitToCelsius = false;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'Celsius to Fahrenheit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              'Enter Temperature',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 30),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      // Adjust the font size here
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 15,
                          style: BorderStyle.solid,
                        ),
                      ),
                      suffixText: isFahrenheitToCelsius ? '°F' : '°C',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 8.0), // Adjust padding to reduce size
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        temperature = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 30),
                Text(
                  '=>',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    '${conversionHistory.isNotEmpty ? conversionHistory.last.convertedTemperature.toStringAsFixed(2) : ''}° ${conversionHistory.isNotEmpty ? conversionHistory.last.conversionType == 'Fahrenheit to Celsius' ? 'C' : 'F' : ''}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(250, 50)),
                backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.blue), // Set the button color
              ),
              child: Text('Convert',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 40),
            Expanded(
                child: ListView.builder(
              itemCount: conversionHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 26.0, vertical: 4.0),
                  title: Text(
                    conversionHistory[index].conversionType,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        '${conversionHistory[index].temperature.toStringAsFixed(2)}° ${conversionHistory[index].conversionType == 'Fahrenheit to Celsius' ? 'F' : 'C'}',
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 30),
                      Icon(Icons
                          .arrow_forward), // Add an arrow icon for visual separation
                      SizedBox(width: 20.0),
                      Text(
                        '${conversionHistory[index].convertedTemperature.toStringAsFixed(2)}° ${conversionHistory[index].conversionType == 'Fahrenheit to Celsius' ? 'C' : 'F'}',
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(
      BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Temperature Conversion',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: false,
        actions: [
          ElevatedButton(
            onPressed: _convertTemperature,
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(Size(250, 50)),
              backgroundColor: WidgetStateProperty.all<Color>(
                  Colors.blue), // Set the button color
            ),
            child: Text('Convert',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 100),
          IconButton(
            icon: const Icon(Icons.delete, size: 50, color: Colors.white),
            onPressed: () {
              setState(() {
                conversionHistory.clear();
              });
              // Implement home functionality here
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.purple,
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 50,
              child: SingleChildScrollView(
                child: Container(
                  width: 400,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'Conversion Type:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: true,
                                    groupValue: isFahrenheitToCelsius,
                                    onChanged: (value) {
                                      setState(() {
                                        isFahrenheitToCelsius = true;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Fahrenheit to Celsius',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: false,
                                    groupValue: isFahrenheitToCelsius,
                                    onChanged: (value) {
                                      setState(() {
                                        isFahrenheitToCelsius = false;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Celsius to Fahrenheit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Enter Temperature',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                // Adjust the font size here
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 15,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                suffixText: isFahrenheitToCelsius ? '°F' : '°C',

                                // Adjust padding to reduce size
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  temperature = double.tryParse(value) ?? 0.0;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 30),
                          Text(
                            '=>',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              '${conversionHistory.isNotEmpty ? conversionHistory.last.convertedTemperature.toStringAsFixed(2) : ''}° ${conversionHistory.isNotEmpty ? conversionHistory.last.conversionType == 'Fahrenheit to Celsius' ? 'C' : 'F' : ''}',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 490,
              top: 10,
              child: Container(
                width: 500,
                height: 400,
                child: Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: conversionHistory.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 26.0, vertical: 4.0),
                              title: Text(
                                conversionHistory[index].conversionType,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    '${conversionHistory[index].temperature.toStringAsFixed(2)}° ${conversionHistory[index].conversionType == 'Fahrenheit to Celsius' ? 'F' : 'C'}',
                                    style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Icon(Icons
                                      .arrow_forward), // Add an arrow icon for visual separation
                                  SizedBox(width: 20.0),
                                  Text(
                                    '${conversionHistory[index].convertedTemperature.toStringAsFixed(2)}° ${conversionHistory[index].conversionType == 'Fahrenheit to Celsius' ? 'C' : 'F'}',
                                    style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _convertTemperature() {
    double convertedTemperature;
    if (isFahrenheitToCelsius) {
      convertedTemperature = (temperature - 32) * 5 / 9;
    } else {
      convertedTemperature = temperature * 9 / 5 + 32;
    }
    setState(() {
      conversionHistory.add(ConversionHistory(
        conversionType: isFahrenheitToCelsius
            ? 'Fahrenheit to Celsius'
            : 'Celsius to Fahrenheit',
        temperature: temperature,
        convertedTemperature: convertedTemperature,
      ));
    });
  }
}

class ConversionHistory {
  final String conversionType;
  final double temperature;
  final double convertedTemperature;

  ConversionHistory({
    required this.conversionType,
    required this.temperature,
    required this.convertedTemperature,
  });
}
