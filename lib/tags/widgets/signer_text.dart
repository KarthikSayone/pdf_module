import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/editable_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

import 'model/tag_data_model.dart';

class SignerText extends StatefulWidget {
  final Function onTap;
  final Function onCompleted;

  const SignerText({this.onTap,
    this.onCompleted,
  });

  @override
  _SignerTextState createState() => _SignerTextState();
}

class _SignerTextState extends State<SignerText> {
  ResizableWidgetController widgetController;
  @override
  Widget build(BuildContext context) {
    return
        ResizebleWidget(
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
          WrapperWidget.of(context).data.signerText = text as String;
          widget.onCompleted(
              WrapperWidget.of(context).uuid, "SignerText", WrapperWidget.of(context).data);
        },
        label: "Signer Text",
      ),
    );
  }
}
