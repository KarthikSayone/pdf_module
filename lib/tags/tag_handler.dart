import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/attachment.dart';
import 'package:pdf_module/tags/widgets/calender_tag.dart';
import 'package:pdf_module/tags/widgets/check_box.dart';
import 'package:pdf_module/tags/widgets/custom_text.dart';
import 'package:pdf_module/tags/widgets/custom_text_area.dart';
import 'package:pdf_module/tags/widgets/initials.dart';
import 'package:pdf_module/tags/widgets/reason.dart';
import 'package:pdf_module/tags/widgets/sign_here.dart';
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
    int pageNumber,
    Rect rect,
    double width,
    double height,
    dynamic data,
    Function onTap,
    Function onCompleted,
  ) {
    switch (tagId) {
      case "1":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
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
      case "2":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              child: TimeStamp(
                onCompleted: onCompleted,
              ));
        }
        break;
      case "3":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
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
      case "4":
        {
          return WrapperWidget(
            uuid: uuid,
            pageNumber: pageNumber,
            rect: rect,
            width: width,
            height: height,
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
      case "5":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
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
      case "6":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
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
      case "10":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
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
      case "15":
        /*{
          return Signature21CFR(
            rect: rect,
          );
        }*/
        break;
      case "18":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              data: data,
              child: Attachment(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "19":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              child: /*Signed*/Attachment(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "20":
        {
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              child: CustomText(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "21":
        {
          //id is given as 20 but 20 is already assigned
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              child: CustomTextArea(
                onTap: onTap,
                onCompleted: onCompleted,
              ));
        }
        break;
      case "27":
        {
          print("checkbox");
          return WrapperWidget(
              uuid: uuid,
              pageNumber: pageNumber,
              rect: rect,
              width: width,
              height: height,
              child: CheckBoxTag(
                selectedCallback: onCompleted,
                // rect: rect,
              ));
        }
        break;
      case "31":
        {
          return WrapperWidget(
              uuid: uuid,
              rect: rect,
              pageNumber: pageNumber,
              width: width,
              height: height,
              data: data,
              child: UploadImageTag(
                onTap: onTap,
                onComplete: onCompleted,
                // rect: rect,
              ));
        }
        break;
      case "32":
        {
          //id is given as 4 but 4 is already assigned
          return WrapperWidget(
            uuid: uuid,
            rect: rect,
            pageNumber: pageNumber,
            width: width,
            height: height,
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
