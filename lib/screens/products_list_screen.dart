import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/bloc/product_bloc.dart';
import 'package:infoware/screens/product_screen.dart';
import 'package:infoware/widgets/product_card.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => ProductBloc()..add(FetchProducts()),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductError) {
                print(state.error);
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is ProductLoaded) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 140.0,
                      titleSpacing: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(bottom: 15),
                        centerTitle: true,
                        title: Text(
                          'Products',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 1,
                      pinned: true,
                      foregroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                    ),
                    SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.565,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        var product = state.products[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductScreen(product: product),
                              ),
                            );
                          },
                          child: ProductCard(
                            title: product.name,
                            price: product.price,
                            imageUrl: product.imageMUrl,
                            category: product.category,
                            colors: product.colors,
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
