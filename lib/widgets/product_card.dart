import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;
  final String category;
  final List<dynamic> colors;
  const ProductCard(
      {required this.title,
      required this.price,
      required this.imageUrl,
      super.key,
      required this.category,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(82, 223, 244, 247),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 7.5),
          Expanded(
            child: Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.5),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fitWidth,
                  )),
            ),
          ),
          const SizedBox(
            height: 7.5,
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 5, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title',
                    style: TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        color: Color.fromARGB(193, 0, 0, 0),
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$category' == null ? '' : "$category",
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 18,
                        width: 100,
                        child: ListView.builder(
                            reverse: true,
                            itemCount: colors.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var color = colors[index].toString().substring(1);
                              return Container(
                                margin: EdgeInsets.only(right: 5),
                                height: 18,
                                width: 18,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(105, 134, 134, 134),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        width: 1, color: Colors.black)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(int.parse("0xFF$color")),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              );
                            }),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
