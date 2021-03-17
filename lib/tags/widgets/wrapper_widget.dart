import 'package:flutter/material.dart';

class WrapperWidget extends InheritedWidget{
  final String uuid;
  final int pageNumber;
  final Rect rect;
  final double width;
  final double height;
  final dynamic data;
  final double scaledWidth;
  final double scaledHeight;

  const WrapperWidget({
    Key key,
    @required this.uuid,
    @required this.pageNumber,
    @required this.rect,
    @required this.width,
    @required this.height,
    @required this.scaledHeight,
    @required this.scaledWidth,
    this.data,
    @required Widget child,
}):super(key: key, child: child);

  static WrapperWidget of(BuildContext context){
    final WrapperWidget result = context.dependOnInheritedWidgetOfExactType<WrapperWidget>();
    assert(result != null, 'No WrapperWidget found in context');
    return result;
  }

  @override
  bool updateShouldNotify(WrapperWidget old)=> old.data!= null || data != old.data;

  set data(dynamic value) {
    data = value;
  }

}