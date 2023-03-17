import 'package:my_pet_store/utils/app_routes.dart';
import 'imports.dart';

void main() => runApp(const MyApp());

enum _authenticationMode { Login, Register }

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
        AppRoutes.LOGIN_HOME: (_) => const LoginScreen(),
        AppRoutes.PRODUCT_SCREEN: (_) => const ProductsOverViewScreen(),
      },
    );
  }
}
