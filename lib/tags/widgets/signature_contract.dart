import 'package:flutter/material.dart';
import 'package:pdf_module/common/functions.dart';
import 'package:pdf_module/tags/widgets/model/signature_contract_model.dart';
import 'package:pdf_module/tags/widgets/sign_here.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class SignatureContract extends StatefulWidget {
  /*final String uuid;
  final Image signature;*/
  final Function onTap;
  final Function onCompleted;
  /*final Rect rect;
  final double width;
  final double height;*/

  SignatureContract({/*this.uuid, this.signature,*/ this.onTap,this.onCompleted/* this.rect, this.width, this.height*/});

  @override
  _SignatureContractState createState() => _SignatureContractState();
}

class _SignatureContractState extends State<SignatureContract> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTap( WrapperWidget.of(context).uuid, "UserUUID");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (WrapperWidget.of(context).data != null && Functions().cast<SignatureContractModel>(WrapperWidget.of(context).data).signature!=null)
      widget.onCompleted(WrapperWidget.of(context).data,WrapperWidget.of(context).uuid, "SignatureContract");
    return Positioned(
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      height: WrapperWidget.of(context).height,
      width: WrapperWidget.of(context).width,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 4,
                child: SignHere(
                  onTap: widget.onTap,
                )),
            Flexible(
              flex: 1,
              child: Container(
                height: 8,
                width: WrapperWidget.of(context).width,
                child: Text(
                    WrapperWidget.of(context).data==null?"UserId to be shown here: UserId":"Userid to be shown here: ${Functions().cast<SignatureContractModel>(WrapperWidget.of(context).data).userUUID}",
                  style: TextStyle(fontSize: 4),
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
