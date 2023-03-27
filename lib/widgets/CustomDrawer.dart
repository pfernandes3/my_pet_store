import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/providers/authenticate_provider.dart';
import 'package:my_pet_store/utils/app_routes.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Seja Bem Vindo'),
            centerTitle: true,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.LOGIN_HOME),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Seus Pedidos'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.ORDERS_ROUTE),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gerenciar Produtos'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.PRODUCTS_SETTINGS),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Provider.of<AuthenticateProvider>(context, listen: false)
                  .logout();
            },
          ),
        ],
      ),
    );
  }
}
