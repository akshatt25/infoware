import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infoware/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductScreen> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> images =
        widget.product.imageUrls.map((item) => item.toString()).toList();
    List<String> sizes = ['S', 'M', "L", "XL", "XXL"];

    CarouselController carouselController = CarouselController();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          margin: EdgeInsets.all(0),
          color: Colors.white,
          elevation: 5,
          child: Container(
            height: 75,
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          0), // Adjust the radius as needed
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(Colors.black)),
              onPressed: () {},
              label: const Text(
                'Add',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 650,
                width: double.infinity,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CarouselSlider(
                      carouselController: carouselController,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            print(reason.toString());
                            _currentIndex = index;
                            print(_currentIndex);
                          });
                        },
                        height: 650,
                        viewportFraction: 1,
                      ),
                      items: images.map((String imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: DotsIndicator(
                      dotsCount: images.length,
                      position: _currentIndex,
                      decorator: DotsDecorator(activeColor: Colors.black),
                    ),
                  )),
                  Positioned(
                    top: 20,
                    left: 15,
                    child: IconButton(
                        iconSize: 20,
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                        )),
                  ),
                  Positioned(
                    top: 20,
                    right: 15,
                    child: IconButton(
                        iconSize: 20,
                        onPressed: () {},
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                        )),
                  ),
                  Positioned(
                    top: 75,
                    right: 15,
                    child: IconButton(
                        iconSize: 20,
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_outline,
                        )),
                  ),
                  Positioned(
                    bottom: 75,
                    right: 15,
                    child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(230, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'View Products',
                          style: TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.w500),
                        )),
                  ),
                ]),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                      Icon(Icons.share, size: 20)
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'MRP inclusive of all taxes',
                  style: TextStyle(
                      letterSpacing: 1,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  '\$${widget.product.price}',
                  style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Colour : ',
                    style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  TextSpan(
                      text: '${widget.product.color}',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      )),
                ])),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Sizes',
                  style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ListView.builder(
                    itemCount: sizes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var size = sizes[index];
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Chip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.5)),
                          side: BorderSide(width: 0.5),
                          label: Text(size),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
