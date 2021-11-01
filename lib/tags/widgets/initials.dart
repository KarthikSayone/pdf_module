import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class Initials extends StatefulWidget {
  final Function onTap;
  final Function onCompleted;

  const Initials({
    this.onTap,
    this.onCompleted,
  });

  @override
  _InitialsState createState() => _InitialsState();
}

class _InitialsState extends State<Initials> {
  ResizableWidgetController widgetController;

  @override
  Widget build(BuildContext context) {
    if (WrapperWidget.of(context).data!=null && WrapperWidget.of(context).data.initials != null) {
      widget.onCompleted(
         WrapperWidget.of(context).uuid, "Initials",WrapperWidget.of(context).data);
    }
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
      child: FillTagBaseStructure(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        onCompleted: () {
          widget.onCompleted(
              WrapperWidget.of(context).uuid, "Initials",WrapperWidget.of(context).data);
        },
        onTap: (){
          widget.onTap(WrapperWidget.of(context).uuid, "Initials");
        },
        label: "Initials",
      ),
    );
  }
}
