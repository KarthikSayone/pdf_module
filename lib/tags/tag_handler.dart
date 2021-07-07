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
  WrapperWidget createTag(
      Key widgetKey,
      String uuid,
      String tagId,
      String key,
      int pageNumber,
      Rect rect,
      double width,
      double height,
      double scaledWidth,
      double scaledHeight,
      dynamic data,
      Function onTap,
      Function onCompleted,
      ) {
    switch (tagId+key) {
      case "1signerName":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data as TagDataModel,
              child: SignerName(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "2signTimeStamp":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              child: TimeStamp(
                onCompleted: onCompleted,
              ));
        }
        break;
      case "3signerText":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              child: SignerText(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "4Reason":
        {
          return WrapperWidget(
            key: widgetKey,
            uuid: uuid,
            pageNumber: pageNumber,
            rect: rect,
            width: width,
            height: height,
            scaledHeight: scaledHeight,
            scaledWidth: scaledWidth,
            data: data as TagDataModel,
            child: Reason(
              onCompleted: onCompleted,
              onTap: onTap,
            ),
          );
        }
        break;
      case "5Signature":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data as TagDataModel,
              child: SignatureContract(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "6signerInitial":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data as TagDataModel,
              child: Initials(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "7":
        break;
      case "10signerTitle":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data as TagDataModel,
              child: SignerTitle(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "15Signature":
        {
          return WrapperWidget(
            key: widgetKey,
            uuid: uuid,
            pageNumber: pageNumber,
            rect: rect,
            width: width,
            height: height,
            scaledHeight: scaledHeight,
            scaledWidth: scaledWidth,
            data: data as TagDataModel,
            child: Signature21CFR(
              onTap: onTap,
              onCompleted: onCompleted,
            ),
          );
        }
        break;
      case "18attachment":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data as TagDataModel,
              child: Attachment(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "19selfSignAttachment":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              child: /*Signed*/ Attachment(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "20customText":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              child: CustomText(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "20customTextArea":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              child: CustomTextArea(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "27checkbox":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              child: CheckBoxTag(
                selectedCallback: onCompleted,
                // rect: rect,
              ));
        }
        break;
      case "31image":
        {
          return WrapperWidget(
              key: widgetKey,
              uuid: uuid,
              rect: rect,
              pageNumber: pageNumber,
              width: width,
              height: height,
              data: data as TagDataModel,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              child: UploadImageTag(
                onTap: onTap,
                onComplete: onCompleted,
              ));
        }
        break;
      case "4Calendar":
        {
          return WrapperWidget(
            key: widgetKey,
            uuid: uuid,
            rect: rect,
            pageNumber: pageNumber,
            width: width,
            height: height,
            scaledHeight: scaledHeight,
            scaledWidth: scaledWidth,
            data: data as TagDataModel,
            child: CalenderTag(
              onComplete: onCompleted,
            ),
          );
        }
        break;
    }
    return null;
  }
}
