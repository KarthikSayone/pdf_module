import 'package:flutter/cupertino.dart';
import 'package:pdf_module/tags/tag_handler.dart';


class TagModel {
  TagType tagType;
  String tagId;
  double tagCoordinateX;
  double tagCoordinateY;
  int pageNumber;
  double width;
  double height;
  int _position;

  TagModel({
    @required this.tagType,
    this.tagId,
    @required this.tagCoordinateX,
    @required this.tagCoordinateY,
    @required this.pageNumber,
    this.height,
    this.width,
  });

  int get position => _position;

  set position(int value) {
    _position = value;
  }
}
