import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreventativeCare {
  final String id;
  final String title;

  const PreventativeCare(this.id, this.title);

  PreventativeCare.name(this.id, this.title);
}

class PreventativeCareItem extends StatelessWidget {
  final String title;

  const PreventativeCareItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextButton( // TODO make button depress when pressed
        style: TextButton.styleFrom(primary: Colors.deepOrange),
        onPressed: () {
          print("hi");
        },
        child: Text(title,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20)
      ),
    );
  }
}
