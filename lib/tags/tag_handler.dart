import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/signature.dart';
import 'package:pdf_module/tags/widgets/signer_name.dart';

enum TagType {
  SignerName,
  Signature,
}

class TagHandler {
  Widget getTag(
    TagType tagType,
    Rect rect,
  ) {
    switch (tagType) {
      case TagType.SignerName:
        {
          return SignerName(
            rect: rect,
          );
        }
        break;
      case TagType.Signature:
        {
          return Signature(
            uuid: "12334235434",
            rect: rect,
          );
        }
        break;
    }
    return null;
  }

}
