import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/attachment.dart';
import 'package:pdf_module/tags/widgets/calender_tag.dart';
import 'package:pdf_module/tags/widgets/check_box.dart';
import 'package:pdf_module/tags/widgets/custom_text.dart';
import 'package:pdf_module/tags/widgets/custom_text_area.dart';
import 'package:pdf_module/tags/widgets/initials.dart';
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
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data,
              child: SignerName(
                onTap: onTap,
                onCompleted: onCompleted,
                /*uuid: uuid,
            rect: rect,
            width: width,
            height: height,*/
              ));
        }
        break;
      case "2signTimeStamp":
        {
          return WrapperWidget(
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
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              child: SignerText(
                /*uuid: uuid,
            rect: rect,
            width: width,
            height: height,*/
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "4Reason":
        {
          return WrapperWidget(
            uuid: uuid,
            pageNumber: pageNumber,
            rect: rect,
            width: width,
            height: height,
            scaledHeight: scaledHeight,
            scaledWidth: scaledWidth,
            data: data,
            child: Reason(
              /*uuid: "12334235434",
            rect: rect,*/
              onCompleted: onCompleted,
              onTap: onTap,
            ),
          );
        }
        break;
      case "5Signature":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data,
              child: SignatureContract(
                onTap: onTap,
                onCompleted: onCompleted,
                /*uuid: uuid,
            rect: rect,
            width: width,
            height: height,*/
              ));
        }
        break;
      case "6signerInitial":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data,
              child: Initials(
                onTap: onTap,
                onCompleted: onCompleted,
                /*uuid: uuid,
            rect: rect,
            width: width,
            height: height,*/
              ));
        }
        break;
      case "7":
        /*{
          return CustodianText(
            uuid: "12334235434",
            rect: rect,
          );
        }*/
        break;
      case "10signerTitle":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data,
              child: SignerTitle(
                /*uuid: uuid,
            rect: rect,
            width: width,
            height: height,*/
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "15Signature":
        {
          return WrapperWidget(
            uuid: uuid,
            pageNumber: pageNumber,
            rect: rect,
            width: width,
            height: height,
            scaledHeight: scaledHeight,
            scaledWidth: scaledWidth,
            data: data,
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
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              data: data,
              child: Attachment(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "19selfSignAttachment":
        {
          return WrapperWidget(
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
          //id is given as 20 but 20 is already assigned
          return WrapperWidget(
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
          print("checkbox");
          return WrapperWidget(
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
              uuid: uuid,
              rect: rect,
              pageNumber: pageNumber,
              width: width,
              height: height,
              data: data,
              scaledHeight: scaledHeight,
              scaledWidth: scaledWidth,
              child: UploadImageTag(
                onTap: onTap,
                onComplete: onCompleted,
                // rect: rect,
              ));
        }
        break;
      case "4Calendar":
        {
          //id is given as 4 but 4 is already assigned
          return WrapperWidget(
            uuid: uuid,
            rect: rect,
            pageNumber: pageNumber,
            width: width,
            height: height,
            scaledHeight: scaledHeight,
            scaledWidth: scaledWidth,
            data: data,
            child: CalenderTag(
              onComplete: onCompleted,
              // rect: rect,
            ),
          );
        }
        break;
    }
    return null;
  }
}
