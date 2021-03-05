import 'package:flutter/material.dart';

class EditablePlaceHolder extends StatefulWidget {
  final Function onTap;
  final ValueChanged<String> onSubmitted; // return with a string
  EditablePlaceHolder({this.onTap, this.onSubmitted});
  @override
  _EditablePlaceHolderState createState() => _EditablePlaceHolderState();
}
class _EditablePlaceHolderState extends State<EditablePlaceHolder> {
  TextEditingController controller = TextEditingController();
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
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
            });},onTap: () {
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
              contentPadding: EdgeInsets.only(left: 10, bottom: 11, top: 11, right: 10),
              hintText: "blah blah"),

        ),
      ),
    );
  }
}

