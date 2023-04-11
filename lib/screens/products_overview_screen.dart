import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "./cart_screen.dart";
import "../widgets/badge.dart";
import "../widgets/products_grid.dart";
import "../providers/cart.dart";

enum Filter { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyShop'),
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cart, c) =>
                  BadgeWidget(cart.itemCount.toString(), c!),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
            PopupMenuButton(
                onSelected: (Filter value) {
                  setState(() {
                    if (value == Filter.favorites) {
                      _showFavorites = true;
                    } else {
                      _showFavorites = false;
                    }
                  });
                },
                icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                      const PopupMenuItem(
                          value: Filter.favorites, child: Text('favorites')),
                      const PopupMenuItem(
                          value: Filter.all, child: Text('show all'))
                    ]),
          ],
        ),
        body: ProductsGrid(_showFavorites));
  }
}
