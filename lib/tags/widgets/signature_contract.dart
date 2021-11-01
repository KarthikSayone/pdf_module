import 'package:flutter/material.dart';
import 'package:pdf_module/common/functions.dart';
import 'package:pdf_module/tags/widgets/model/tag_data_model.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/sign_here.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class SignatureContract extends StatefulWidget {
  final Function onTap;
  final Function onCompleted;

  const SignatureContract({this.onTap,this.onCompleted});

  @override
  _SignatureContractState createState() => _SignatureContractState();
}

class _SignatureContractState extends State<SignatureContract> {
  ResizableWidgetController widgetController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (WrapperWidget.of(context).data== null || WrapperWidget.of(context).data.userUUID == null) {
        widget.onTap( WrapperWidget.of(context).uuid, "UserUUID");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (WrapperWidget.of(context).data != null && Functions().cast<TagDataModel>(WrapperWidget.of(context).data).signature!=null) {
      widget.onCompleted(WrapperWidget.of(context).uuid, "SignatureContract",WrapperWidget.of(context).data);
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
      child: Container(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 4,
                child: SignHere(
                  onTap: widget.onTap,
                )),
            Flexible(
              child: Container(
                child: Text(
                    WrapperWidget.of(context).data==null?"UserId to be shown here: UserId":"Userid to be shown here: ${Functions().cast<TagDataModel>(WrapperWidget.of(context).data).userUUID}",
                  style: const TextStyle(color:Colors.black,fontSize: 4),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
