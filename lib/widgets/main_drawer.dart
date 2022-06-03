import 'package:flutter/material.dart';

import '../screens/filter_screen.dart';
import '../shared/colors.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);
  Widget _buildListTile(
      String title, IconData icon, void Function() tapHandler, context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(title, style: Theme.of(context).textTheme.headline5!),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Theme.of(context).canvasColor.withOpacity(0.7),
            offset: Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 3),
      ]),
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: card.withOpacity(0.6),
              child: Text(
                "Cooking Up!",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: const Color.fromRGBO(250, 240, 206, 1.0),
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildListTile(
              'Meal',
              Icons.restaurant,
              () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              context,
            ),
            _buildListTile(
              'Settings',
              Icons.settings,
              () {
                Navigator.of(context)
                    .pushReplacementNamed(FilterScreen.routeName);
              },
              context,
            ),
          ],
        ),
      ),
    );
  }
}
