import 'package:flutter/material.dart';

class HomeTShirtSection extends StatelessWidget {
  const HomeTShirtSection(
      {super.key,
      required this.theme,
      required this.onTap,
      required this.title});

  final ColorScheme theme;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 470,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  title,
                  style: TextStyle(
                      color: theme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Space between columns
                mainAxisSpacing: 10.0,
                mainAxisExtent: 180,
              ),
              itemCount: 6, // Total number of items
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: theme.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: Image.asset(
                                  'assets/picture/denim-jacket.png',
                                  // color: theme.primary,
                                  fit: BoxFit.cover,
                                ))),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: theme.primary.withOpacity(.1),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Men's Premium T-Shirt Hope",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: theme.primary, fontSize: 10),
                              ),
                              Text(
                                "BDT 599.",
                                style: TextStyle(
                                    color: theme.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
