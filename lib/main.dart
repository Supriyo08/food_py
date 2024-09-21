import 'package:campus_haat/cubit/cart_cubit.dart';
import 'package:campus_haat/cubit/product_cubit.dart';
import 'package:campus_haat/navigation/route.dart';
import 'package:campus_haat/services/campus_haat_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String baseUrl =
        'http://chprod-env.eba-psapqnmi.ap-south-1.elasticbeanstalk.com/webapi/products/productSearch';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit(ApiService(url: baseUrl))),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
