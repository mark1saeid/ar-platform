import 'package:flutter/material.dart';

Widget buildActiveUserSearchBox({
  BuildContext context,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.1,
    width: MediaQuery.of(context).size.width,
    child: TextField(
      readOnly: true,
      showCursor: true,
      decoration: InputDecoration(
        hintText: "Search...",

        hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey.shade400,
          size: 20,
        ),
        filled: true,
        fillColor: Colors.transparent,
        //grey.shade100,
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade100)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade100)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade100)),
      ),
    ),
  );
}
