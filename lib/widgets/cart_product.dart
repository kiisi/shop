import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartProduct extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  CartProduct(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.productId,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
        child: Icon(Icons.delete, color: Colors.white, size: 30),
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Warning!"),
            content: Text("Do you want to remove the item from cart!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No"),
              ),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
