import 'package:flutter/material.dart';
import 'package:traversal_slider/traversal_slider.dart';
import 'package:any_image_view/any_image_view.dart';
import 'package:stylish_pull_to_refresh/stylish_pull_to_refresh.dart';

void main() {
  runApp(TraversalSliderDemoApp());
}

class TraversalSliderDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traversal Slider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TraversalSliderDemo(),
    );
  }
}

class TraversalSliderDemo extends StatefulWidget {
  @override
  _TraversalSliderDemoState createState() => _TraversalSliderDemoState();
}

class _TraversalSliderDemoState extends State<TraversalSliderDemo> {
  int _currentIndex = 0;
  final List<String> foodImages = [
    'assets/images 2.png',
    'assets/flutter_mobile.json',
    'assets/image.svg',
    'https://assets-global.website-files.com/6270e8022b05abb840d27d6f/6308d1ab615e60c9047c9d06_AppDev_Flutter-tools.png',
  ];
  final List<String> captions = [
    'Burger',
    'Snack',
    'Flutter Image',
    'Network Image',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Traversal Slider Demo'),
        backgroundColor: Colors.blue,
      ),
      body: StylishPullToRefresh(
        style: Style.sandTimer,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2)); // Simulating a refresh delay
          setState(() {
            _currentIndex = 0; // Reset to the first image on refresh
          });
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                captions[_currentIndex],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TraversalSlider(
                  widgets: List.generate(
                    foodImages.length,
                        (index) => AnyImageView(
                      boxFit: BoxFit.contain,
                      imagePath: foodImages[index],
                      width: double.infinity,
                      errorPlaceHolder: 'assets/no image.jpeg',
                      onTap: () {
                        print('Image $index tapped');
                      },
                    ),
                  ),
                  sliderType: SliderType.multipleViewSlider,
                  onIndexChanged: (value) {
                    setState(() {
                      _currentIndex = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
