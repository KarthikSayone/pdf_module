import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class Initials extends StatefulWidget {
  // final String uuid;
  final Function onTap;
  final Function onCompleted; // return with a string
  // final Rect rect;
  // final double width;
  // final double height;

  Initials({
    this.onTap,
    this.onCompleted,
    /*this.rect, this.width, this.height, this.uuid*/
  });

  @override
  _InitialsState createState() => _InitialsState();
}

class _InitialsState extends State<Initials> {
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
        autoFill: false,
        onCompleted: () {
          // widget.onTap(WrapperWidget.of(context).uuid, "Initials");
        },
        onTap: (){
          widget.onTap(WrapperWidget.of(context).uuid, "Initials");
        },
        label: WrapperWidget.of(context).data == null
            ? "Initials"
            : WrapperWidget.of(context).data,
      ),
    );
  }
}
