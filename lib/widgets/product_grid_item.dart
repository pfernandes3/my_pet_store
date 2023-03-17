import 'package:my_pet_store/imports.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});
 
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(backgroundColor: Colors.black87,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.favorite)),
        trailing: IconButton(onPressed: (){}, icon:  Icon(Icons.shopping_cart,color: Theme.of(context).colorScheme.primary,)) ,
        title: const Text('Product title',textAlign: TextAlign.center ,),
        ),
        child:  const Text('Teste'),
      ),
    );
  }
}