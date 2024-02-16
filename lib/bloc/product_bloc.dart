import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:infoware/models/product.dart';
import 'dart:convert';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await _fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products: $e'));
      }
    });
  }

  // @override
  // Stream<ProductState> mapEventToState(
  //   ProductEvent event,
  // ) async {
  //   on<FetchProducts>(()) {
  //     emit(ProductLoading());
  //     try {
  //       final products = await _fetchProducts();
  //       emit(ProductLoaded(products));
  //     } catch (e) {
  //       emit(ProductError('Failed to load products: $e'));
  //     }
  //   }
}

Future<List<Product>> _fetchProducts() async {
  final url = Uri.parse(
      'https://apidojo-hm-hennes-mauritz-v1.p.rapidapi.com/products/list');
  final response = await http.get(
    url,
    headers: {
      'X-RapidAPI-Key': '3c05dd1a81msh3c5c1ba9d0e6c7dp1800bbjsn839b38aae395',
      'X-RapidAPI-Host': 'apidojo-hm-hennes-mauritz-v1.p.rapidapi.com'
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body)['results'];
    List<Product> products =
        jsonList.map((json) => Product.fromJson(json)).toList();
    print('done');
    return products;
  } else {
    throw Exception('Failed to load products');
  }
}
