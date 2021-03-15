import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  /*showPicker() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 250,
            child: DropdownButton<String>(
              value: _arrayData.elementAt(0),
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  // dropdownValue = newValue;
                });
              },
              items: _arrayData.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),*/ /*CupertinoPicker(
                // backgroundColor: Colors.white,
                onSelectedItemChanged: (value) {
                  setState(() {
                    _pickerData = _arrayData[value];
                    widget.onSelected(_pickerData);
                  });
                },
                itemExtent: 25.0,
                children: _arrayData.map((title) {
                  return Text(
                    title,
                    style: TextStyle(fontSize: 13),
                    maxLines: 1,
                  );
                }).toList()),*/ /*
          );
        });
  }*/

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
    return Positioned(
      top: WrapperWidget
          .of(context)
          .rect
          .top,
      left: WrapperWidget
          .of(context)
          .rect
          .left,
      height: WrapperWidget
          .of(context)
          .height,
      width: WrapperWidget
          .of(context)
          .width,
      child: /*InkWell(
        onTap: () {
          showPicker();
        },
        child: */Container(
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
