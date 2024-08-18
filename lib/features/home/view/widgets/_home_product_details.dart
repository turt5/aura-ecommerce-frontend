import 'package:attira/features/home/controller/_products_details_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProductDetails extends ConsumerWidget {
  HomeProductDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final pdProviderRead = ref.watch(productsDetailsProvider);
    final pdProviderWrite = ref.read(productsDetailsProvider);

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: IconButton(
                        onPressed: () {
                          pdProviderWrite.selectedQuantity = 1;
                          pdProviderWrite.setKey = null;
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back)),
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
                                  Text(
                                      pdProviderRead.getSelectedKey == null
                                          ? "-"
                                          : "BDT ${pdProviderRead.getSizes[pdProviderRead.getSelectedKey]} ",
                                      style: TextStyle(
                                          color: Colors.green,
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
                                        color: theme.primary.withOpacity(.1),
                                        width: 2)),
                                padding: EdgeInsets.all(10),
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
                                      height: 10,
                                    ),
                                    Row(
                                      children: pdProviderRead.getSizes.entries
                                          .map((entry) {
                                        return Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: InkWell(
                                            onTap: () {
                                              pdProviderWrite.setKey =
                                                  entry.key;
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 13,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                  color: pdProviderRead
                                                                  .getSelectedKey !=
                                                              null &&
                                                          entry.key
                                                                  .toString() ==
                                                              pdProviderRead
                                                                  .getSelectedKey
                                                      ? theme.primary
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.grey
                                                          .withOpacity(.5))),
                                              child: Text(
                                                entry.key,
                                                style: TextStyle(
                                                    color: pdProviderRead
                                                                    .getSelectedKey !=
                                                                null &&
                                                            entry.key
                                                                    .toString() ==
                                                                pdProviderRead
                                                                    .getSelectedKey
                                                        ? theme.onPrimary
                                                        : theme.onSurface),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
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
                                                    onPressed: () {
                                                      if (pdProviderRead
                                                              .selectedQuantity >
                                                          1) {
                                                        pdProviderWrite
                                                                .selectedQuantity =
                                                            pdProviderRead
                                                                    .selectedQuantity -
                                                                1;
                                                      }
                                                    },
                                                    color: theme.error,
                                                    icon: Icon(Icons.remove)),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${pdProviderRead.selectedQuantity}',
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
                                                    onPressed: () {
                                                      pdProviderWrite
                                                              .selectedQuantity =
                                                          pdProviderRead
                                                                  .selectedQuantity +
                                                              1;
                                                    },
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
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Product Details:',
                                    style: TextStyle(
                                        color: theme.onSurface,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
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
