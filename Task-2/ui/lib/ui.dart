import 'package:flutter/material.dart';

class UI extends StatelessWidget {
  const UI({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              height: size.height * 0.50,
              width: size.width * 0.80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.pink.shade300, Colors.orange.shade100]),
                borderRadius: BorderRadius.circular(20)
                    .copyWith(topRight: const Radius.circular(125)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        const Text(
                          'Breakfast',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 46,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Bread,',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Peanut butter,',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Apple',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '525',
                                style: TextStyle(
                                  fontSize: 55,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: ' kcal',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 135,
            left: 60,
            child: SizedBox(
              height: 180,
              width: 180,
              child: Image.network(
                "http://clipart-library.com/image_gallery/n701592.png",
                height: 170,
                width: 170,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: 65,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 90,
                    blurRadius: 20,
                    offset: const Offset(25, -35),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
