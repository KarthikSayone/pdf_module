import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/attachment.dart';
import 'package:pdf_module/tags/widgets/calender_tag.dart';
import 'package:pdf_module/tags/widgets/check_box.dart';
import 'package:pdf_module/tags/widgets/custom_text.dart';
import 'package:pdf_module/tags/widgets/custom_text_area.dart';
import 'package:pdf_module/tags/widgets/initials.dart';
import 'package:pdf_module/tags/widgets/model/tag_data_model.dart';
import 'package:pdf_module/tags/widgets/reason.dart';
import 'package:pdf_module/tags/widgets/sign_here.dart';
import 'package:pdf_module/tags/widgets/signature_21cfr.dart';
import 'package:pdf_module/tags/widgets/signature_contract.dart';
import 'package:pdf_module/tags/widgets/signed_attachment.dart';
import 'package:pdf_module/tags/widgets/signer_name.dart';
import 'package:pdf_module/tags/widgets/signer_text.dart';
import 'package:pdf_module/tags/widgets/signer_title.dart';
import 'package:pdf_module/tags/widgets/time_stamp.dart';
import 'package:pdf_module/tags/widgets/upload_image.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class TagHandler {
  Widget createTag(
      String tagId,
      String key,
      Function onTap,
      Function onCompleted,
      ) {
    switch (tagId+key) {
      case "1signerName":
        {
          return SignerName(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "2signTimeStamp":
        {
          return TimeStamp(
            onCompleted: onCompleted,
          );
        }
        break;
      case "3signerText":
        {
          return SignerText(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "4Reason":
        {
          return Reason(
            onCompleted: onCompleted,
            onTap: onTap,
          );
        }
        break;
      case "5Signature":
        {
          return SignatureContract(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "6signerInitial":
        {
          return Initials(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "7":
        break;
      case "10signerTitle":
        {
          return SignerTitle(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "15Signature":
        {
          return Signature21CFR(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "18attachment":
        {
          return Attachment(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "19selfSignAttachment":
        {
          return Attachment(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "20customText":
        {
          return CustomText(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "20customTextArea":
        {
          return CustomTextArea(
            onTap: onTap,
            onCompleted: onCompleted,
          );
        }
        break;
      case "27checkbox":
        {
          return CheckBoxTag(
            selectedCallback: onCompleted,
            // rect: rect,
          );
        }
        break;
      case "31image":
        {
          return UploadImageTag(
            onTap: onTap,
            onComplete: onCompleted,
          );
        }
        break;
      case "4Calendar":
        {
          return CalenderTag(
            onComplete: onCompleted,
          );
        }
        break;
    }
    return null;
  }
}
