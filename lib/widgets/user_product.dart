import 'package:flutter/material.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';

class UserProduct extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProduct(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100.0,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: Icon(Icons.edit,
                  color: Theme.of(context).colorScheme.primary),
            ),
            IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              },
              icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
            ),
          ],
        ),
      ),
    );
  }
}
