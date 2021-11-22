import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
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
  int ind = 0;
  Uint8List image;

  @override
  Widget build(BuildContext context) {
    if (Functions().cast<TagDataModel>(WrapperWidget.of(context).data) !=
            null &&
        Functions()
                .cast<TagDataModel>(WrapperWidget.of(context).data)
                .signature !=
            null &&
        !widget.isCfr) {
      image = Functions()
          .cast<TagDataModel>(WrapperWidget.of(context).data)
          .signature as Uint8List;
      ind = 1;
      setState(() {});
    }
    return InkWell(
      onTap: () {
        if (!widget.autoFill) {
          widget.onTap();
          setState(() {
          });
        }
      },
      child: IndexedStack(
        index: ind,
        children: [
          Container(
            height: widget.height,
            width: widget.width,
            color: const Color.fromRGBO(216, 243, 254, 1.0),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: AutoSizeText(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
            ),
          ),
          Container(
            color: const Color.fromRGBO(216, 243, 254, 1.0),
            height: widget.height,
            width: widget.width,
            child: FittedBox(
              fit: BoxFit.fill,
              child: image != null ? Image.memory(image) : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
