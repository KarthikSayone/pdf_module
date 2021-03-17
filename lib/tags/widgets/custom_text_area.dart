import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/editable_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class CustomTextArea extends StatefulWidget {
  // final String uuid;
  final Function onTap;
  final Function onCompleted;
  /*final Rect rect;
  final double width;
  final double height;*/

  CustomTextArea({/*this.width, this.height, this.rect,*/ this.onTap, this.onCompleted,/* this.uuid*/});

  @override
  _CustomTextAreaState createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
ResizableWidgetController widgetController;

  @override
  Widget build(BuildContext context) {
    return ResizebleWidget(
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
          widget.onCompleted(WrapperWidget.of(context).uuid, "CustomTextArea",text);
        },
        isTextArea: true,
        label: "Custom TextArea",),
    );
  }

}