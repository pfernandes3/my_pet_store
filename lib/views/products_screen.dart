import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/widgets/product_grid.dart';
class ProductsOverViewScreen extends StatelessWidget {
  const ProductsOverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
  
        appBar: AppBar(
          title: const Text('Pet Store'),
        ),
      body: (
        const ProductGrid()
      ),  
      
    );
  }
}