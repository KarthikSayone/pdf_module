import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf_module/common/functions.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class Attachment extends StatefulWidget {
  // final String uuid;
  final Function onTap;
  final Function onCompleted; // return with a string
  // final Rect rect;
  // final double width;
  // final double height;

  Attachment({
    this.onTap,
    this.onCompleted,
    /* this.rect, this.width, this.height, this.uuid*/
  });

  @override
  _AttachmentState createState() => _AttachmentState();
}

class _AttachmentState extends State<Attachment> {
  TextEditingController controller = TextEditingController();
  ResizableWidgetController widgetController;
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    print("TagBuilder: Attachment");
    if (WrapperWidget.of(context).data!= null && WrapperWidget.of(context).data.attachmentData != null)
      widget.onCompleted(
           WrapperWidget.of(context).uuid, "Attachment",WrapperWidget.of(context).data);
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
        onCompleted: () {},
        onTap: () {
          widget.onTap(WrapperWidget.of(context).uuid, "Attachment");
        },
        label: WrapperWidget.of(context).data == null
            ? "Attachment"
            : WrapperWidget.of(context).data.attachmentFileName,
      ),
    );
  }
}
