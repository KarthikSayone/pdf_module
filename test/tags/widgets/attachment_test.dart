import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_module/tags/widgets/attachment.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

void main(){
Widget makeTestableWidget({Widget child}){
  return MaterialApp(
    home:Scaffold(body: Stack(children: [WrapperWidget(
      key: const Key('1'),
      uuid: '1',
      pageNumber: 1,
      rect: const Rect.fromLTWH(10.0,10.0,100.0,40.0),
      width: 100.0,
      height: 40.0,
      scaledHeight: 60.0,
      scaledWidth: 23.0,
      child: child)],))
  );
}

testWidgets('Init', (WidgetTester tester) async{
  final Attachment widget = Attachment(onCompleted: (){
   log("Completed");
  },onTap: (){
    log("Tapped");
  },);

  await tester.pumpWidget(makeTestableWidget(child: widget));
});
}