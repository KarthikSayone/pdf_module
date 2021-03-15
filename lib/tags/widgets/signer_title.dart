import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/editable_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class SignerTitle extends StatefulWidget {
  // final String uuid;
  final Function onTap;
  final Function onCompleted;
  // final Rect rect;
  // final double width;
  // final double height;

  SignerTitle({/*this.width, this.height, this.rect, */this.onTap, this.onCompleted,/* this.uuid*/});

  @override
  _SignerTitleState createState() => _SignerTitleState();
}

class _SignerTitleState extends State<SignerTitle> {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      height: WrapperWidget.of(context).height,
      width: WrapperWidget.of(context).width,
      child: EditableTagBaseStructure(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        onCompleted: (text) {
          print('Text: $text');
          widget.onCompleted(text, WrapperWidget.of(context).uuid, "SignerTitle");
        },
        /*onTap: (){
          print("signer tap");
        },*/
        label: "Signer Title",),
    );
  }

}