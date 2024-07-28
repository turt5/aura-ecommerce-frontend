import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class HomeOffersSection extends StatelessWidget {
  const HomeOffersSection(
      {super.key, required this.theme, required this.imageUrl});

  final ColorScheme theme;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
                left: 0,
                top: 0,
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width ,
                  height: 120,
                )),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 200,
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Colors.transparent
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Check-Out Offers',style: TextStyle(
                          color: theme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                        ),),
                        const SizedBox(width: 8,),

                        Icon(Icons.arrow_forward_ios_rounded,size: 13,color: theme.onPrimary,)
                      ],
                    )
                  ],
                ),
              ).frosted(
                blur: 5,
                  frostColor: theme.primary.withOpacity(.05),
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(100))
              ),
            ),
          ],
        ),
      ),
    );
  }
}
