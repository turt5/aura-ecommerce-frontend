import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeProductDetails extends StatelessWidget {
  HomeProductDetails({super.key});

  final Map<String, String> sizes = {
    "S": "499",
    "M": "499",
    "L": "550",
    "XL": "599",
    "XXL": "650"
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                                    child: Text(
                                        'Men\'s Premium T-Shirt Hope & Love',
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
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: theme.primary.withOpacity(.3),
                                        width: 2)),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Product Size:',
                                            style: TextStyle(
                                                color: theme.onSurface,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quantity: ',
                                          style: TextStyle(
                                              color: theme.onSurface,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: IconButton(
                                                    onPressed: () {},
                                                    color: theme.error,
                                                    icon: Icon(Icons.remove)),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '1000000',
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                    onPressed: () {},
                                                    color: theme.primary,
                                                    icon: Icon(Icons.add)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
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
                                borderRadius: BorderRadius.circular(10))),
                        child: Text('Add to Cart')),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
