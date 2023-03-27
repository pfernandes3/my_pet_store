import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/providers/authenticate_provider.dart';
import 'package:provider/provider.dart';

class LoginOrProductScreen extends StatelessWidget {
  const LoginOrProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticateProvider auth = Provider.of(context);

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('OCORREU UM ERRO'),
          );
        } else {
          return auth.getIsAuth ? const ProductsOverViewScreen() : const LoginScreen();
        }
      },
    );
  }
}
