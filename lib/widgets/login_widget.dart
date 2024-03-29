import 'package:my_pet_store/exceptions/firebase_except.dart';
import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/providers/authenticate_provider.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validator;
import 'package:my_pet_store/generated/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum AuthenticateMode { Login, Register }

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
    setState(() {
      // S.load(Locale("en"));
    });

  }

  bool inLoader = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordControler = TextEditingController();
  final Map<String, String> _formData = {'email': "", 'senha': ""};
  AuthenticateMode _authenticationMode = AuthenticateMode.Login;
  _switchAuthMode() {
    if (_authenticationMode == AuthenticateMode.Login) {
      setState(() {
        _authenticationMode = AuthenticateMode.Register;
      });
    } else {
      setState(() {
        _authenticationMode = AuthenticateMode.Login;
      });
    }
  }

  void _showException(message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('OCORREU UM ERRO'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'))
        ],
      ),
    );
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      inLoader = true;
    });

    _formKey.currentState!.save();

    try {
      if (_authenticationMode == AuthenticateMode.Login) {
        await Provider.of<AuthenticateProvider>(context, listen: false)
            .login(_formData['email'], _formData['senha']);
      } else {
        await Provider.of<AuthenticateProvider>(context, listen: false)
            .register(_formData['email'], _formData['senha']);
      }
    } on FireBaseException catch (e) {
      _showException(e.toString());
    } catch (error) {
      _showException('Ocorreu um erro inesperado');
    }
    setState(() {
      inLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.all(28.0),
        height: _authenticationMode == AuthenticateMode.Login ? 370 : 440,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Form(
            key: _formKey,
            child: Column(
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
                    prefixIcon: const Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary)),
                    labelText: AppLocalizations.of(context)!.loginInput,
                    border: const OutlineInputBorder(),
                  ),
                  onSaved: (newValue) =>
                      _formData['email'] = newValue.toString(),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  obscureText: true,
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
                    prefixIcon: const Icon(Icons.key),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary)),
                    labelText: AppLocalizations.of(context)!.passInput,
                    border: const OutlineInputBorder(),
                  ),
                  onSaved: (newValue) =>
                      _formData['senha'] = newValue.toString(),
                ),
                const SizedBox(
                  height: 12.5,
                ),
                if (_authenticationMode == AuthenticateMode.Register)
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
                  height: 17.5,
                ),
                inLoader
                    ? Container(child: const CircularProgressIndicator())
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
                            _authenticationMode == AuthenticateMode.Login
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
                        _authenticationMode == AuthenticateMode.Login
                            ? AppLocalizations.of(context)!.button
                            : 'VOLTAR PARA LOGIN',
                      )),
                )
              ],
            )),
      ),
    );
  }
}
