import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class Reason extends StatefulWidget {
  Function onCompleted;
  Function onTap;
  final String value;

  Reason({this.onCompleted, this.onTap, this.value});

  @override
  _ReasonState createState() => _ReasonState();
}

class _ReasonState extends State<Reason> {
  var _pickerData = "Select a reason";
  ResizableWidgetController widgetController;

  List<String> _arrayData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTap(WrapperWidget
          .of(context)
          .uuid, "Reason");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (WrapperWidget
        .of(context)
        .data != null) {
      _arrayData = WrapperWidget
          .of(context)
          .data;
      // _pickerData = widget.value == null ? "Select a reason" : widget.value;
      // _pickerData = _arrayData.elementAt(0);
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
      isDraggable: false,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(216, 243, 254, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(isExpanded: true,
                value: _pickerData,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 18,
                elevation: 14,
                style: TextStyle(color: Colors.black54,fontSize: 13),
                onChanged: (String newValue) {
                  setState(() {
                    _pickerData = newValue;
                    widget.onCompleted(WrapperWidget
                        .of(context)
                        .uuid, "Reason", newValue);
                  });
                },
                items: _arrayData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,),
                  );
                }).toList(),
              ),
            ),
        ),
        // ),

      ),
    );
  }
}
