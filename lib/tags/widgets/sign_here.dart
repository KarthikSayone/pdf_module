import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class SignHere extends StatefulWidget {
  // final String uuid;
  final Function onTap;
  final Function onCompleted; // return with a string
  // final Rect rect;
  // final double width;
  // final double height;

  SignHere({this.onTap, this.onCompleted,/* this.rect, this.width, this.height, this.uuid*/});

  @override
  _SignHereState createState() => _SignHereState();
}

class _SignHereState extends State<SignHere> {
  TextEditingController controller = TextEditingController();
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    return FillTagBaseStructure(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        onCompleted: (){

        },
      onTap: (){
          widget.onTap(WrapperWidget.of(context).uuid,"SignHere");
      },
        label: "Sign Here",
      /*),*/
    );
  }
}
