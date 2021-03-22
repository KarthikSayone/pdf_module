import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf_module/common/functions.dart';
import 'package:pdf_module/tags/widgets/model/tag_data_model.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class FillTagBaseStructure extends StatefulWidget {
  final double width;
  final double height;
  final bool autoFill;
  bool isCfr;
  final Function onCompleted;
  final Function onTap;
  final String label;

  FillTagBaseStructure(
      {this.width,
      this.height,
      this.autoFill = false,
      this.onCompleted,
      this.onTap,
      this.label,
      this.isCfr = false});

  @override
  _FillTagBaseStructureState createState() => _FillTagBaseStructureState();
}

class _FillTagBaseStructureState extends State<FillTagBaseStructure> {
  var ind = 0;
  Uint8List image;

  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(Functions().cast<SignatureContractModel>(WrapperWidget.of(context).data)!= null){
        image = Functions().cast<SignatureContractModel>(WrapperWidget.of(context).data).signature;
        ind=0;
        setState(() {

        });
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    print("TagBuilder: FillTagBase");
    if (Functions()
                .cast<TagDataModel>(WrapperWidget.of(context).data) !=
            null &&
        Functions()
                .cast<TagDataModel>(WrapperWidget.of(context).data)
                .signature !=
            null&& !widget.isCfr) {
      image = Functions()
          .cast<TagDataModel>(WrapperWidget.of(context).data)
          .signature;
      ind = 1;
      setState(() {});
    }
    return InkWell(
      onTap: () {
        if (!widget.autoFill) {
          widget.onTap();
          setState(() {
            /*if (ind == 0) {
              ind = 1;
            } else {
              ind = 0;
            }*/
          });
        }
      },
      child: IndexedStack(
        index: ind,
        children: [
          Container(
            height: widget.height,
            width: widget.width,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.grey,
                  // fontSize: 12
                ),
              ),
            ),
            color: Color.fromRGBO(216, 243, 254, 1.0),
          ),
          Container(
            color: Color.fromRGBO(216, 243, 254, 1.0),
            height: widget.height,
            width: widget.width,
            child: Center(
                child: image != null ? Image.memory(image) : Container()),
          ),
        ],
      ),
    );
  }
}
