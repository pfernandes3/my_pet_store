import 'package:my_pet_store/providers/authenticate_provider.dart';
import 'package:my_pet_store/providers/cart_provider.dart';
import 'package:my_pet_store/providers/order_provider.dart';
import 'package:my_pet_store/providers/products_provider.dart';
import 'package:my_pet_store/utils/app_routes.dart';
import 'package:my_pet_store/views/cart_screen.dart';
import 'package:my_pet_store/views/login_or_product_screen.dart';
import 'package:my_pet_store/views/order_screen.dart';
import 'package:my_pet_store/views/products_detail.dart';
import 'imports.dart';
import 'package:provider/provider.dart';


void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthenticateProvider(),
          ),
          ChangeNotifierProxyProvider<AuthenticateProvider, ProductsProvider>(
            create: (_) => ProductsProvider(null, [], null),
            update: (context, auth, previous) => ProductsProvider(
                auth.getToken, previous!.getProducts, auth.idUser),
          ),
          ChangeNotifierProvider(
            create: (_) => Cart(),
          ),
          ChangeNotifierProxyProvider<AuthenticateProvider, Orders>(
            update: (context, auth, previous) =>
                Orders(auth.getToken, previous!.orders,auth.idUser),
            create: (_) => Orders(null, [],null),
          ),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
            .copyWith(secondary: Colors.purple),
      ),
      routes: {
        AppRoutes.LOGIN_HOME: (_) => const LoginOrProductScreen(),
        AppRoutes.PRODUCT_SCREEN: (_) => const ProductDetailScreen(),
        AppRoutes.CART_ROUTE: (_) => const CartScreen(),
        AppRoutes.ORDERS_ROUTE : (_) => const OrderScreen(),
      },
    );
  }
}
