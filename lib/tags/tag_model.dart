import 'package:flutter/cupertino.dart';
import 'package:pdf_module/tags/tag_handler.dart';
import 'package:pdf_module/tags/widgets/model/tag_data_model.dart';

class TagModel {
  String uuid;
  String tagId;
  String key;
  double tagCoordinateX;
  double tagCoordinateY;
  Rect rect;
  int pageNumber;
  double width;
  double height;
  TagDataModel data;


  TagModel({
    @required this.uuid,
    @required this.tagId,
    @required this.key,
    @required this.tagCoordinateX,
    @required this.tagCoordinateY,
    @required this.pageNumber,
    this.rect,
    this.height,
    this.width,
    this.data,
  });


}
