import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class TimeStamp extends StatefulWidget {
  /*final String uuid;*/
  final Function onTap;
  final Function onCompleted; // return with a string
  /*final Rect rect;
  final double width;
  final double height;*/

  TimeStamp({
    /*this.uuid,*/ this.onTap,
    this.onCompleted,
    /*this.rect, this.width, this.height*/
  });

  @override
  _TimeStampState createState() => _TimeStampState();
}

class _TimeStampState extends State<TimeStamp> {
  TextEditingController controller = TextEditingController();
  ResizableWidgetController widgetController;
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    widget.onCompleted(  WrapperWidget.of(context).uuid, "TimeStamp", null);
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
      child: FillTagBaseStructure(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        autoFill: true,
        onCompleted: () {},
        label: "Time Stamp",
      ),
    );
  }
}
