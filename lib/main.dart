import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // <--- TAMBAHKAN IMPORT INI
import 'core/injection_container.dart';
import 'core/app_router.dart';
import 'features/store/presentation/cubit/product_cubit.dart'; // <--- TAMBAHKAN IMPORT INI
import 'features/store/presentation/cubit_cart/cart_cubit.dart'; // <--- TAMBAHKAN IMPORT INI

void main(){
  WidgetsFlutterBinding.ensureInitialized();

setupLocator(); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // DISINI TEMPATNYA:
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<ProductCubit>()),
        BlocProvider(create: (_) => locator<CartCubit>()),
      ],
      child: MaterialApp.router(
        title: 'UTD Store & Crypto Hub',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
