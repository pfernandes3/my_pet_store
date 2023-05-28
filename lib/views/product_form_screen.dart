import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/providers/products_provider.dart';
import 'package:my_pet_store/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import '../models/pet_products.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  final _imgFocus = FocusNode();
  final _imgController = TextEditingController();

  bool isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final product = ModalRoute.of(context)!.settings.arguments as Product?;

      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;
        _imgController.text = _formData['imageUrl'];
      } else {
        _formData['price'] = "";
      }
    }
  }

  void _updateImageUrl() {
    if (isValidateImageUrl(_imgController.text)) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    final newProduct = Product(
      id: _formData['id'],
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    );

    setState(() {
      isLoading = true;
    });

    final products = Provider.of<ProductsProvider>(context, listen: false);

    try {
      if (_formData['id'] == null) {
        await products.insertProducts(newProduct);
        await products.loadProducts();
      } else {
        await products.updateProducts(newProduct);
        await products.loadProducts();
      }

      Navigator.of(context).pop();
    } catch (e) {
      await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Ocorreu um erro!'),
                content: const Text(
                    'Ocorreu um erro inesperado ao salvar o produto!'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK')),
                ],
              ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isValidateImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');
    return (startWithHttp ||
        startWithHttps ||
        endsWithJpeg ||
        endsWithJpg ||
        endsWithPng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastro de Produtos'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Custom_Form_Field(
                  label: const Text('Título'),
                  icon: const Icon(Icons.pets),
                  initialValue: _formData['title'],
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Informe um titulo válido';
                    }
                    if (value.trim().length < 3) {
                      return 'Informe um titulo de pelo menos 3 caracteres';
                    }
                    return null;
                  },
                  onsaved: (value) => _formData['title'] = value as String,
                  textinputaction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Custom_Form_Field(
                  label: const Text('Preço'),
                  icon: const Icon(Icons.monetization_on),
                  initialValue: _formData['price'].toString(),
                  validator: (value) {
                    if (value!.trim().isEmpty ||
                        double.tryParse(value) == null ||
                        double.tryParse(value)! <= 0) {
                      return 'Informe um valor válido';
                    }
                    return null;
                  },
                  onsaved: (value) => _formData['price'] = double.parse(value),
                  textinputaction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                Custom_Form_Field(
                  label: const Text('Descrição'),
                  icon: const Icon(Icons.description),
                  initialValue: _formData['description'],
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Informe uma descrição válida';
                    }
                    return null;
                  },
                  onsaved: (value) =>
                      _formData['description'] = value as String,
                  textinputaction: TextInputAction.next,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty ||
                            !isValidateImageUrl(value)) {
                          return 'Informe uma Url válida';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Url da Imagem',
                          prefixIcon: Icon(Icons.image)),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imgController,
                      focusNode: _imgFocus,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) =>
                          _formData['imageUrl'] = value as String,
                    )),
                    Container(
                        width: 200,
                        height: 200,
                        margin: const EdgeInsets.only(top: 25, left: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        alignment: Alignment.center,
                        child: _imgController.text.isEmpty
                            ? const Text(
                                'Informe a URL',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              )
                            : Image.network(
                                _imgController.text,
                                fit: BoxFit.cover,
                              ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
