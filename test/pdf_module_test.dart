
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_module/pdf_module.dart';

void main() {

  const MethodChannel channel = MethodChannel('pdf_module');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method){
        case 'file':
          return {'docId':1,'pageCount':4, 'verMajor':2, 'verMinor':3,'isEncrypted':false};
        case 'asset':
          return {'docId':1,'pageCount':4, 'verMajor':2, 'verMinor':3,'isEncrypted':false};
        case 'data':
          return {'docId':1,'pageCount':4, 'verMajor':2, 'verMinor':3,'isEncrypted':false};
        case 'page':
          return {'width':13.0,'height':12.0};
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });


  test('open pdf from a file', () async{
    PdfDocument pdf = await PdfDocument.openFile("/hello.pdf");

    expect(pdf.pageCount,4);
    expect(pdf.isEncrypted, false);
  });

  test('open pdf from asset', () async{
    PdfDocument pdf = await PdfDocument.openAsset("hello.pdf");

    expect(pdf.pageCount,4);
    expect(pdf.isEncrypted, false);
  });

  test('open pdf from data', () async{
    Uint8List data = new Uint8List(10);
    PdfDocument pdf = await PdfDocument.openData(data);

    expect(pdf.pageCount,4);
    expect(pdf.isEncrypted, false);
  });

  test('get page from a pdf', () async{
    PdfDocument pdf = await PdfDocument.openFile("/hello.pdf");
    PdfPage pdfPage = await pdf.getPage(1);

    expect(pdfPage.width,13.0);
    expect(pdfPage.height,12.0);
  });


}
