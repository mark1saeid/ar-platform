import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  Function onTap;
  SubmitButton({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 2, 6, 10),
                  Color.fromARGB(255, 12, 42, 54)
                ])),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class TitleAr extends StatelessWidget {
  const TitleAr({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("AR PLATFORM",
        style: GoogleFonts.rowdies(fontSize: 22, color: Colors.black));
  }
}

class AccountLabel extends StatelessWidget {
  final String title, subtitle;
  Function onTap;
  AccountLabel({Key key, this.title, this.onTap, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                  color: Color.fromARGB(255, 12, 42, 54),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class EntryField extends StatelessWidget {
  final String title;
  final String hint;
  bool isPassword = false;
  Color color = Colors.white;
  TextEditingController controller;
  Function(String) validator;
  Function(String) onFieldSubmitted;


  EntryField({
    this.title,
    this.isPassword,
    this.hint,
    this.color,
    this.controller,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onFieldSubmitted: onFieldSubmitted,
            
            controller: controller,
            obscureText: isPassword,
            validator: validator,
            
            decoration: InputDecoration(
              hintText: hint ?? "",
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          )
        ],
      ),
    );
  }
}
