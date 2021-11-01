import 'package:flutter/material.dart';

class EditableTagBaseStructure extends StatefulWidget {
  final double width;
  final double height;
  final Function onCompleted;
  final String label;
  final bool isTextArea;
  final String initialData;

  const EditableTagBaseStructure(
      {this.width, this.height, this.onCompleted, this.label, this.isTextArea=false, this.initialData});

  @override
  _EditableTagBaseStructureState createState() =>
      _EditableTagBaseStructureState();
}

class _EditableTagBaseStructureState extends State<EditableTagBaseStructure> {
  TextEditingController controller = TextEditingController();
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    if(widget.initialData!=null){
      controller.text= widget.initialData;
      widget.onCompleted(widget.initialData);
    }
    return ConstrainedBox(
      constraints:widget.isTextArea?
      BoxConstraints(minHeight: widget.height, maxWidth: widget.width):
      BoxConstraints(maxHeight: widget.height, maxWidth: widget.width),
      child: Container(
          color: const Color.fromRGBO(216, 243, 254, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
      textAlign: TextAlign.left,
      maxLines: widget.isTextArea?null:1,
      minLines: widget.isTextArea?2:1,
      style: const TextStyle(color: Colors.black, fontSize: 14, ),
      readOnly: readOnly,
      autocorrect: false,
      controller: controller,
      onChanged: (text){
        widget.onCompleted(text);
      },
      onSubmitted: (text) {
        setState(() {
          readOnly = true;
          widget.onCompleted(text);
        });
      },
      onTap: () {
        setState(() {
          readOnly = false;
        });
      },
      decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.black,fontSize: 10,),
          hintText: widget.label),
            ),
          ),
        ),
    );
  }
}
