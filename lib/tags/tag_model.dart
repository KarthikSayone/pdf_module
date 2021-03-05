import 'package:flutter/cupertino.dart';
import 'package:pdf_module/tags/tag_handler.dart';

class TagModel {
  String uuid;
  String tagId;
  double tagCoordinateX;
  double tagCoordinateY;
  int pageNumber;
  double width;
  double height;
  dynamic data;


  TagModel({
    @required this.uuid,
    @required this.tagId,
    @required this.tagCoordinateX,
    @required this.tagCoordinateY,
    @required this.pageNumber,
    this.height,
    this.width,
    this.data,
  });


}
