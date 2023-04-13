import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/widgets/custom_text_form_field.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  bool isLoading = false;
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
      body: Form(
          key: _formKey,
          child: ListView(
            children: const [
              Custom_Form_Field(
                label: Text('TITULO'),
                icon: Icon(Icons.title),
              
              )
            ],
          )),
    );
  }
}
