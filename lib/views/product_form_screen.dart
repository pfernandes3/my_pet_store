import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/widgets/custom_text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastro de Produtos'),
        actions: [
          IconButton(
            onPressed: () {},
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
                const SizedBox(height: 20,),
                Custom_Form_Field(
                  label: const Text('Preço'),
                  icon: const Icon(Icons.monetization_on),
                  initialValue: _formData['price'].toString(),
                  validator: (value) {
                    if (value!.trim().isEmpty || double.tryParse(value) == null || double.tryParse(value)! <= 0) { 
                      return 'Informe um valor válido';
                    }
                    return null;
                  },
                  onsaved: (value) => _formData['price'] = double.parse(value),
                  textinputaction: TextInputAction.next,
                ),
                const SizedBox(height: 20,),
                Custom_Form_Field(
                  label: const Text('Preço'),
                  icon: const Icon(Icons.monetization_on),
                  initialValue: _formData['price'].toString(),
                  validator: (value) {
                    if (value!.trim().isEmpty || double.tryParse(value) == null || double.tryParse(value)! <= 0) { 
                      return 'Informe um valor válido';
                    }
                    return null;
                  },
                  onsaved: (value) => _formData['price'] = double.parse(value),
                  textinputaction: TextInputAction.next,
                ),
              ],
            )),
      ),
    );
  }
}
