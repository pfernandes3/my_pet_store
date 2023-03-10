import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/views/products_screen.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool inLoader = false;
  submit() {
    setState(() {
      inLoader = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((_) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProductsOverViewScreen(),)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.all(30.0),
        height: 300,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary)),
                labelText: 'Login',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary)),
                labelText: 'Senha',
                border: const OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            inLoader
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 8,
                          )),
                      onPressed: submit,
                      child: const Text('ENTRAR'),
                    ),
                  )
          ],
        )),
      ),
    );
  }
}
