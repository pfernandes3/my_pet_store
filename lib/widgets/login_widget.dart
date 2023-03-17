import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/utils/app_routes.dart';
import 'package:string_validator/string_validator.dart' as validator;

enum _AuthenticationMode { Login, Register }

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool inLoader = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordControler = TextEditingController();
  final Map<String, String> _formData = {'email': "", 'senha': ""};

  _AuthenticationMode _authenticationMode = _AuthenticationMode.Login;
  _switchAuthMode() {
    if (_authenticationMode == _AuthenticationMode.Login) {
      setState(() {
        _authenticationMode = _AuthenticationMode.Register;
      });
    } else {
      setState(() {
        _authenticationMode = _AuthenticationMode.Login;
      });
    }
  }

  submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      inLoader = true;
    });
    Future.delayed(const Duration(seconds: 2))
        .then((_) => Navigator.of(context).pushNamed(AppRoutes.PRODUCT_SCREEN));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.all(28.0),
        height: _authenticationMode == _AuthenticationMode.Login ? 340 : 420,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field can't be empty ";
                    }
                    if (!validator.isEmail(value)) {
                      return 'Value must be email type';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary)),
                    labelText: 'Digite seu e-mail',
                    border: const OutlineInputBorder(),
                  ),
                  onSaved: (newValue) =>
                      _formData['email'] = newValue.toString(),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field can't be empty";
                    }
                    if (!validator.isLength(value, 6)) {
                      return 'Password value must min be 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary)),
                    labelText: 'Digite sua senha',
                    border: const OutlineInputBorder(),
                  ),
                  onSaved: (newValue) =>
                      _formData['senha'] = newValue.toString(),
                ),
                const SizedBox(
                  height: 12.5,
                ),
                if (_authenticationMode == _AuthenticationMode.Register)
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Confirmar Senha',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary)),
                        border: const OutlineInputBorder()),
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                const SizedBox(
                  height: 12.5,
                ),
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
                          child: Text(
                            _authenticationMode == _AuthenticationMode.Login
                                ? 'ENTRAR'
                                : 'REGISTRAR',
                          ),
                        ),
                      ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: _switchAuthMode,
                      style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          backgroundColor: Colors.white),
                      child: Text(
                        _authenticationMode == _AuthenticationMode.Login
                            ? 'CADASTRE-SE'
                            : 'VOLTAR PARA LOGIN',
                      )),
                )
              ],
            )),
      ),
    );
  }
}
