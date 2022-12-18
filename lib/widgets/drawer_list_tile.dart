import 'package:flutter/material.dart';
import 'package:vizstore_manager/constants.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading:
            Icon(icon, color: selected ? Colors.white : TextColor2, size: 16),
        title: Text(
          title,
          style: selected
              ? TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
              : TextStyle(color: TextColor2),
        ));
  }
}
