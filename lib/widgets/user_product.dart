import 'package:flutter/material.dart';

class UserProduct extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProduct(this.title, this.imageUrl);

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
              onPressed: () {},
              icon: Icon(Icons.edit,
                  color: Theme.of(context).colorScheme.primary),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
            ),
          ],
        ),
      ),
    );
  }
}
