import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pdf_module/pdf_module_widget.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/signer_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PdfViewerController controller;
  PdfViewer pdf;

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  /*// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    */ /*try {
      platformVersion = await PdfModule.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }*/ /*

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }*/

  void onPress() {
    // pdf.addString("hello");
  }

  @override
  Widget build(BuildContext context) {
    pdf = PdfViewer(
      assetName: 'assets/hello.pdf',
      padding: 10,
      minScale: 1.0,
      viewerController: controller,
      onViewerControllerInitialized: (PdfViewerController c) {
        controller = c;
        c.goToPage(pageNumber: 1); // scrolling animation to page 3.
      },
      // tagList: tagList,
      buildPageOverlay: (context, index, rect) {
        return ResizebleWidget(
          height: 250.0,
        width: 250.0,
        isDraggable: true,
        child: SignerText(
        onTap: () {
        },
        onCompleted: (DD, F , DF) {
          
        },
              ),
        );
      },
      onLongPressDone: (details) {
        print("LongPress");
        print(details.globalPosition);
        setState(() {
          onPress();

          /*list.add((context, pageNumber, pageRect, _pages) {
            var rect1 = getPos(10, 227, 521, _pages, pageNumber);
            if (pageNumber == 1)
              return EditablePlaceHolder(
                onSubmitted: (text) {
                  print(text);
                },
                onTap: () {
                  print("tapped");
                },
                rect: rect1,
              );
            else
              return Container();
          });*/
        });
      },
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: pdf,
      ),
    );
  }
}
