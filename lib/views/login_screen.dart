import 'package:my_pet_store/imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.network(
                'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/c9107729093353.55e1c74b8fa4c.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 100,
              ),
              const LoginWidget()
            ],
          ),
        ),
      ),
    );
  }
}
