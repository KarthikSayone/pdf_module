import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class UploadImageTag extends StatefulWidget {
  final Function onTap;
  final Function onComplete;

  const UploadImageTag({this.onTap,this.onComplete,
  });

  @override
  _UploadImageTagState createState() => _UploadImageTagState();
}

class _UploadImageTagState extends State<UploadImageTag> {
  ResizableWidgetController widgetController;

  @override
  Widget build(BuildContext context) {
    if (WrapperWidget.of(context).data!=null && WrapperWidget.of(context).data.image != null) {
      widget.onComplete(WrapperWidget.of(context).uuid, "Image",WrapperWidget.of(context).data,);
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
        color: const Color.fromRGBO(216, 243, 254, 1.0),
        child: InkWell(
          onTap: () {
            widget.onTap(WrapperWidget.of(context).uuid, "Image");
          },
          child: WrapperWidget.of(context).data == null
              ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Upload Image",
                          style: TextStyle(color:Colors.black,fontSize: 13),
                        ),
                        Text(
                          "PNG,JPEG,JPG only(Max Size: 500 KB)",
                          style: TextStyle(color:Colors.black,fontSize: 5),
                        )
                      ],
                    ),
                  )
              : Container(
                  color: Colors.black,
                  child: Image.file(
                    WrapperWidget.of(context).data.image as File,
                    fit: BoxFit.cover,
                  )),
        ),
      ),
    );
  }

}
