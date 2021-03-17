import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/editable_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class SignerText extends StatefulWidget {
  // final String uuid;
  final Function onTap;
  final Function onCompleted;

  /*final Rect rect;
  final double width;
  final double height;*/

  SignerText({
    /*this.width, this.height, this.rect,*/ this.onTap,
    this.onCompleted,
    /* this.uuid*/
  });

  @override
  _SignerTextState createState() => _SignerTextState();
}

class _SignerTextState extends State<SignerText> {
  ResizableWidgetController widgetController;
  @override
  Widget build(BuildContext context) {
    return /*Positioned(
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      height: WrapperWidget.of(context).height,
      width: WrapperWidget.of(context).width,
      child: */
        ResizebleWidget(
          width: WrapperWidget.of(context).width,
          height: WrapperWidget.of(context).height,
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      widgetController: widgetController,
      onWidgetControllerInitialized: (ResizableWidgetController c){
        widgetController = c;
        c.resize(WrapperWidget.of(context).scaledWidth, WrapperWidget.of(context).scaledHeight);
      },
      isDraggable: false,
      child: EditableTagBaseStructure(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        onCompleted: (text) {
          print('Text: $text');
          widget.onCompleted(
              WrapperWidget.of(context).uuid, "SignerText", text);
        },
        onTap: () {
          print("signer tap");
          widget.onTap();
        },
        label: "Signer Text",
      ),
      /*),*/
    );
  }
}
