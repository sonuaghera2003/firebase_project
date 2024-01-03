import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderDemo extends StatefulWidget {
  const CarouselSliderDemo({super.key});

  @override
  State<CarouselSliderDemo> createState() => _CarouselSliderDemoState();
}

class _CarouselSliderDemoState extends State<CarouselSliderDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewPage(),));
          },
          child: Hero(
            tag: "new",
            child: Image.network(
              "https://images.unsplash.com/photo-1621155346337-1d19476ba7d6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGltYWdlfGVufDB8fDB8fHww",
              height: 100,
              width: 100,
            ),
          ),
        ),
      ), /*CarouselSlider(
          options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              viewportFraction: 0.4,
              enlargeCenterPage: true,
              enlargeFactor: 0.2),
          items: [1, 2, 3, 4, 5].map((i) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: Text(
                  'text $i',
                  style: TextStyle(fontSize: 16.0),
                ));
          }).toList(),
        ),*/
    );
  }
}

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: "new",
        child: Image.network(
          "https://images.unsplash.com/photo-1621155346337-1d19476ba7d6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGltYWdlfGVufDB8fDB8fHww",
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
