import 'package:flutter/material.dart';

class EditableTagBaseStructure extends StatefulWidget {
  final double width;
  final double height;
  final Function onCompleted;
  final Function onTap;
  final String label;
  final bool isTextArea;

  EditableTagBaseStructure(
      {this.width, this.height, this.onCompleted, this.label, this.isTextArea=false, this.onTap});

  @override
  _EditableTagBaseStructureState createState() =>
      _EditableTagBaseStructureState();
}

class _EditableTagBaseStructureState extends State<EditableTagBaseStructure> {
  TextEditingController controller = TextEditingController();
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:widget.isTextArea?
          BoxConstraints(minHeight: widget.height, maxWidth: widget.width):
      BoxConstraints(maxHeight: widget.height, maxWidth: widget.width),
      child: Container(
        color: Color.fromRGBO(216, 243, 254, 1.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: TextField(
            textAlign: TextAlign.center,
            maxLines: widget.isTextArea?null:1,
            style: TextStyle(color: Colors.black, fontSize: 10, ),
            readOnly: readOnly,
            autocorrect: false,
            controller: controller,
            onSubmitted: (text) {
              // print(text);
              setState(() {
                this.readOnly = true;
                // ToDo
                print('onCompleted: $text');
                widget.onCompleted(text);
              });
            },
            onTap: () {
              print('onTap editable');
              setState(() {
                this.readOnly = false;
                // ToDo
                // widget.onTap();
              });
            },
            decoration: new InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: TextStyle(fontSize: 7),
                /*contentPadding:
                    EdgeInsets.symmetric(horizontal: 10),*/
                hintText: widget.label),
          ),
        ),
      ),
    );
  }
}
