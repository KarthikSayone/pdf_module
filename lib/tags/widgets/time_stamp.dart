import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class TimeStamp extends StatefulWidget {
  final bool isCfrChild;
  final Function onTap;
  final Function onCompleted;
  final double width;
  final double height;

  const TimeStamp({ this.onTap,
    this.onCompleted,
    this.isCfrChild = false,
    this.width, this.height,
  });

  @override
  _TimeStampState createState() => _TimeStampState();
}

class _TimeStampState extends State<TimeStamp> {
  ResizableWidgetController widgetController;

  @override
  Widget build(BuildContext context) {
    widget.onCompleted(  WrapperWidget.of(context).uuid, "TimeStamp", null);
    return widget.isCfrChild?FillTagBaseStructure(
      width: widget.width ?? WrapperWidget.of(context).width,
      height:widget.height ?? WrapperWidget.of(context).height,
      autoFill: true,
      onCompleted: () {},
      isCfr: true,
      label: "Time Stamp",
    ):ResizebleWidget(
      width: WrapperWidget.of(context).width,
      height: WrapperWidget.of(context).height,
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      widgetController: widgetController,
      onWidgetControllerInitialized: (ResizableWidgetController c){
        widgetController = c;
        c.resize(WrapperWidget.of(context).scaledWidth, WrapperWidget.of(context).scaledHeight);
      },
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
