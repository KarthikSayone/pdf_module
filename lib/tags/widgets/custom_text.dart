import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/editable_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/model/tag_data_model.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class CustomText extends StatefulWidget {
  // final String uuid;
  final Function onTap;
  final Function onCompleted;
  /*final Rect rect;
  final double width;
  final double height;*/

  const CustomText({this.onTap, this.onCompleted, });

  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
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
      child: EditableTagBaseStructure(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        onCompleted: (text) {
          if(WrapperWidget.of(context).data==null) {
            WrapperWidget.of(context).data = TagDataModel();
          }
          WrapperWidget.of(context).data.customText = text as String;
          widget.onCompleted( WrapperWidget.of(context).uuid, "CustomText", WrapperWidget.of(context).data);
        },
        label: "Custom Text",),
    );
  }

}