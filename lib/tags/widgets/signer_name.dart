import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class SignerName extends StatefulWidget {
  /*final String uuid;*/
  final Function onTap;
  final Function onCompleted; // return with a string
  /*final Rect rect;
  final double width;
  final double height;*/

  SignerName({
    /*this.uuid,*/ this.onTap,
    this.onCompleted,
    /*this.rect, this.width, this.height*/
  });

  @override
  _SignerNameState createState() => _SignerNameState();
}

class _SignerNameState extends State<SignerName> {
  TextEditingController controller = TextEditingController();
  ResizableWidgetController widgetController;
  bool readOnly = false;
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTap( WrapperWidget.of(context).uuid, "SignerName");
    });
  }
  @override
  Widget build(BuildContext context) {
    if (WrapperWidget.of(context).data != null)
      widget.onCompleted(WrapperWidget.of(context).uuid, "SignerName",WrapperWidget.of(context).data);
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
        label: WrapperWidget.of(context).data == null
            ? "Signer Name"
            : WrapperWidget.of(context).data,
      ),
    );
  }
}
