import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';
// import 'package:image_picker/image_picker.dart';

class UploadImageTag extends StatefulWidget {
  // final String uuid;
  /*final FileCallback selectedImage;
  final FilePickError imagePickError;*/
  // final Color tagColor;
  final Function onTap;
  final Function onComplete;

  UploadImageTag({
    /*this.selectedImage, this.imagePickError,this.tagColor,*/ this.onTap,this.onComplete,
    /* this.uuid*/
  });

  @override
  _UploadImageTagState createState() => _UploadImageTagState();
}

class _UploadImageTagState extends State<UploadImageTag> {
  // bool _isImageAdded = false;
  File _image;

  // final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    /*if (WrapperWidget.of(context).data != null)
      widget.onComplete(null,WrapperWidget.of(context).uuid);*/
    return Positioned(
      top: 100,
      left: 100,
      height: WrapperWidget.of(context).height,
      width: WrapperWidget.of(context).width,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(216, 243, 254, 1.0),
        child: InkWell(
          onTap: () {
            widget.onTap(WrapperWidget.of(context).uuid, "Image");
          },
          child: WrapperWidget.of(context).data == null
              ? Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload Image",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          "PNG,JPEG,JPG only(Max Size: 500 KB)",
                          style: TextStyle(fontSize: 5),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  color: Colors.black,
                  child: Image.file(
                    WrapperWidget.of(context).data,
                    fit: BoxFit.cover,
                  )),
        ),
      ),
    );
  }

/*Future _getImage() async{
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _isImageAdded = true;
          _image = File(pickedFile.path);
          widget.selectedImage(_image);
        } else {
          _isImageAdded = false;
          print('No image selected.');
        }
      });
    } catch (e) {
      widget.imagePickError(e);
    }
  }
  }*/

}
