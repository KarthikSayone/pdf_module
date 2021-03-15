import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf_module/common/functions.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
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
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    if (WrapperWidget.of(context).data != null)
      widget.onCompleted(
          WrapperWidget.of(context).data, WrapperWidget.of(context).uuid, "Attachment");
    return Positioned(
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      height: WrapperWidget.of(context).height,
      width: WrapperWidget.of(context).width,
      child: FillTagBaseStructure(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        onCompleted: () {},
        onTap: () {
          widget.onTap(WrapperWidget.of(context).uuid, "Attachment");
        },
        label: WrapperWidget.of(context).data == null
            ? "Attachment"
            : Functions()
                .cast<File>(WrapperWidget.of(context).data)
                .path
                .substring(Functions()
                        .cast<File>(WrapperWidget.of(context).data)
                        .path
                        .lastIndexOf("/") +
                    1),
      ),
    );
  }
}
