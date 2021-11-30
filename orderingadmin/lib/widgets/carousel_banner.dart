import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      //height: 250,
      //    width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(height: 200.0),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.red),
                  child: Text(
                    'text $i',
                    style: const TextStyle(fontSize: 16.0),
                  ));
            },
          );
        }).toList(),
      ),
    );
  }
}
