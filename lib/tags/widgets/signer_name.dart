import 'package:flutter/material.dart';

class SignerName extends StatefulWidget {
  final Function onTap;
  final ValueChanged<String> onSubmitted; // return with a string
  final Rect rect;
  final double width;
  final double height;

  SignerName({this.onTap, this.onSubmitted, this.rect, this.width=100, this.height=60});

  @override
  _SignerNameState createState() => _SignerNameState();
}

class _SignerNameState extends State<SignerName> {
  TextEditingController controller = TextEditingController();
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.rect.top,
      left: widget.rect.left,
      height: widget.height,
      width: widget.width,
      child: Container(
        width: widget.height,
        height: widget.width,
        color: Color.fromRGBO(216, 243, 254, 1.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 10),
            readOnly: readOnly,
            autocorrect: false,
            controller: controller,
            onSubmitted: (text) {
              // print(text);
              setState(() {
                this.readOnly = true;
                widget.onSubmitted(text);
              });
            },
            onTap: () {
              setState(() {
                this.readOnly = false;
                widget.onTap();
              });
            },
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: TextStyle(fontSize: 7),
                contentPadding:
                    EdgeInsets.only(left: 10, bottom: 11, top: 11, right: 10),
                hintText: "Signer Name"),
          ),
        ),
      ),
    );
  }
}
