import 'package:flutter/material.dart';

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({super.key});

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      color: const Color.fromARGB(99, 244, 67, 54),
    );
  }
}

Container a = new Container(
  child: MaterialButton(
    onPressed: () {},
  ),
);
