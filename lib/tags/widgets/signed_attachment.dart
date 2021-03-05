import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class SignedAttachment extends StatefulWidget {
  // final String uuid;
  final Function onTap;
  final Function onCompleted; // return with a string
  /*final Rect rect;
  final double width;
  final double height;*/

  SignedAttachment({this.onTap, this.onCompleted,/* this.rect, this.width, this.height, this.uuid*/});

  @override
  _SignedAttachmentState createState() => _SignedAttachmentState();
}

class _SignedAttachmentState extends State<SignedAttachment> {
  TextEditingController controller = TextEditingController();
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      height: WrapperWidget.of(context).height,
      width: WrapperWidget.of(context).width,
      child: FillTagBaseStructure(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        onCompleted: (){

        },
        label: "Signed Attachment",
      ),
    );
  }
}
