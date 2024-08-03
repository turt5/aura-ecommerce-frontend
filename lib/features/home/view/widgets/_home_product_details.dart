import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeProductDetails extends StatelessWidget {
  const HomeProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: theme.surface,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/picture/banner-1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text('Men\'s Premium T-Shirt Hope & Love',
                                  style: TextStyle(
                                      color: theme.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text('BDT 599.',
                                style: TextStyle(
                                    color: theme.primary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: theme.primary.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Product Size',
                                  style: TextStyle(
                                      color: theme.onSurface,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                  "Proin feugiat dapibus lectus, non faucibus risus euismod nec. Nunc blandit nulla a mauris ullamcorper, sed maximus ligula viverra. Donec sagittis leo nec turpis suscipit, in faucibus nisi venenatis. Vestibulum at tristique nibh. Integer rhoncus odio enim, eget vulputate metus lobortis ac. Maecenas pretium faucibus dui. Nam ac nisi facilisis, tristique justo sed, maximus libero. Sed sem tortor, rhoncus vel quam mattis, suscipit tempor sapien. Vivamus pulvinar, leo id pellentesque rutrum, tortor metus ultricies leo, vel accumsan est enim a lacus. Donec accumsan magna vel mi elementum feugiat at sed ipsum. Nam fermentum lacinia sapien sit amet ultricies. Praesent tincidunt rhoncus lorem, ut semper odio fermentum et. Mauris molestie enim in neque aliquet, quis blandit ante maximus.. Proin feugiat dapibus lectus, non faucibus risus euismod nec. Nunc blandit nulla a mauris ullamcorper, sed maximus ligula viverra. Donec sagittis leo nec turpis suscipit, in faucibus nisi venenatis. Vestibulum at tristique nibh. Integer rhoncus odio enim, eget vulputate metus lobortis ac. Maecenas pretium faucibus dui. Nam ac nisi facilisis, tristique justo sed, maximus libero. Sed sem tortor, rhoncus vel quam mattis, suscipit tempor sapien. Vivamus pulvinar, leo id pellentesque rutrum, tortor metus ultricies leo, vel accumsan est enim a lacus. Donec accumsan magna vel mi elementum feugiat at sed ipsum. Nam fermentum lacinia sapien sit amet ultricies. Praesent tincidunt rhoncus lorem, ut semper odio fermentum et. Mauris molestie enim in neque aliquet, quis blandit ante maximus.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: theme.onSurface,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: theme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text('Quantity',
                                style: TextStyle(
                                    color: theme.onPrimary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.onPrimary,
                                      foregroundColor: theme.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text('Add to Cart')),
                            )),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.primary,
                                        foregroundColor: theme.onPrimary,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: () {},
                                    child: Text('Buy Now')),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                childCount: 1, // Number of dummy items
              ),
            ),
          ],
        ),
      ),
    );
  }
}
