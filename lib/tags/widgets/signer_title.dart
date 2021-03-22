import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/editable_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

import 'model/tag_data_model.dart';

class SignerTitle extends StatefulWidget {
  // final String uuid;
  final Function onTap;
  final Function onCompleted;
  // final Rect rect;
  // final double width;
  // final double height;

  SignerTitle({/*this.width, this.height, this.rect, */this.onTap, this.onCompleted,/* this.uuid*/});

  @override
  _SignerTitleState createState() => _SignerTitleState();
}

class _SignerTitleState extends State<SignerTitle> {
  ResizableWidgetController widgetController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTap( WrapperWidget.of(context).uuid, "SignerTitle");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("TagBuilder: SignerTitle");
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
      child: EditableTagBaseStructure(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        initialData: WrapperWidget.of(context).data!=null?WrapperWidget.of(context).data.signerTitle:null,
        onCompleted: (text) {
          print('Text: $text');
          if(WrapperWidget.of(context).data==null)
            WrapperWidget.of(context).data = TagDataModel();
          WrapperWidget.of(context).data.signerTitle = text;
          widget.onCompleted( WrapperWidget.of(context).uuid, "SignerTitle", WrapperWidget.of(context).data);
        },
        /*onTap: (){
          print("signer tap");
        },*/
        label: "Signer Title",),
    );
  }

}