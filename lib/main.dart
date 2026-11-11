import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Demo Home Page')),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _width = 50.0;
  double _height = 50.0;
  double _radius = 0.0;

  static const double _min = 10.0;
  static const double _max = 100.0;

  @override
  Widget build(BuildContext context) {
    final double t = (_radius / _max).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Width', _width),
          Slider(
            value: _width,
            min: _min,
            max: _max,
            onChanged: (v) => setState(() => _width = v),
          ),
          _label('Height', _height),
          Slider(
            value: _height,
            min: _min,
            max: _max,
            onChanged: (v) => setState(() => _height = v),
          ),
          _label('Radius', _radius),
          Slider(
            value: _radius,
            min: 0,
            max: _max,
            onChanged: (v) => setState(() => _radius = v),
          ),
          const SizedBox(height: 8),
          Center(
            child: ClipPath(
              clipper: _CornerClipper(t),
              child: Container(
                width: _width,
                height: _height,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String name, double value) {
    return Row(
      children: [
        Text('$name: '),
        Text(
          value.toStringAsFixed(2),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _CornerClipper extends CustomClipper<Path> {
  final double t;
  _CornerClipper(this.t);

  @override
  Path getClip(Size s) => Path()
    ..addRRect(
      RRect.fromRectAndCorners(
        Offset.zero & s,
        topRight: Radius.elliptical(s.width * t, s.height * t),
      ),
    );

  @override
  bool shouldReclip(_CornerClipper old) => old.t != t;
}