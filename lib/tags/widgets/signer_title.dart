import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/editable_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

import 'model/tag_data_model.dart';

class SignerTitle extends StatefulWidget {
  final Function onTap;
  final Function onCompleted;

  const SignerTitle({this.onTap, this.onCompleted,});

  @override
  _SignerTitleState createState() => _SignerTitleState();
}

class _SignerTitleState extends State<SignerTitle> {
  ResizableWidgetController widgetController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (WrapperWidget.of(context).data== null || WrapperWidget.of(context).data.signerTitle == null) {
        widget.onTap( WrapperWidget.of(context).uuid, "SignerTitle");
      }
    });
  }

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
        initialData: WrapperWidget.of(context).data?.signerTitle,
        onCompleted: (text) {
          if(WrapperWidget.of(context).data==null) {
            WrapperWidget.of(context).data = TagDataModel();
          }
          WrapperWidget.of(context).data.signerTitle = text as String;
          widget.onCompleted( WrapperWidget.of(context).uuid, "SignerTitle", WrapperWidget.of(context).data);
        },
        label: "Signer Title",),
    );
  }

}