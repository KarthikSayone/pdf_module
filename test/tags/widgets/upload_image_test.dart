import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_module/tags/widgets/upload_image.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
        home:Scaffold(body: Stack(children: [WrapperWidget(
            key: const Key('1'),
            uuid: '1',
            pageNumber: 1,
            rect: const Rect.fromLTWH(10.0,10.0,100.0,40.0),
            width: 200.0,
            height: 200.0,
            scaledHeight: 100.0,
            scaledWidth: 100.0,
            child: child)],))
    );
  }

  testWidgets('Init', (WidgetTester tester) async{
    final UploadImageTag widget = UploadImageTag(onComplete: (){
      log("Completed");
    },onTap: (){
      log("Tapped");
    },);

    await tester.pumpWidget(makeTestableWidget(child: widget));
  });
}