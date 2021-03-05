import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderTag extends StatefulWidget {
  final String uuid;
  final String placeHolderText;
  final Color tagColor;

  CalenderTag({this.placeHolderText, this.tagColor, this.uuid});

  @override
  _CalenderTagState createState() => _CalenderTagState();
}

class _CalenderTagState extends State<CalenderTag> {
  TextEditingController _controller = TextEditingController();
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Calender Build");
    return Positioned(
        top: WrapperWidget.of(context).rect.top,
        left: WrapperWidget.of(context).rect.left,
        height: WrapperWidget.of(context).height,
        width: WrapperWidget.of(context).width,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: widget.tagColor,
          padding: EdgeInsets.all(5),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.1, color: Colors.black)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.grey,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(fontSize: 10),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 10),
                        /*contentPadding: EdgeInsets.only(
                              left: 15, bottom: 0, top: 0, right: 15),*/
                        hintText: widget.placeHolderText),
                    controller: _controller,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                width: 200,
                                child: calenderWidget(context),
                              ),
                            );
                          });
                    },
                  ),
                ),
                InkWell(
                  child: Container(
                    child: Icon(Icons.close, size: 11),
                    padding: EdgeInsets.all(3),
                  ),
                  onTap: () {
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                  },
                ),
                InkWell(
                  child: Container(
                    child: Icon(
                      Icons.calendar_today_rounded,
                      size: 11,
                    ),
                    padding: EdgeInsets.all(3),
                  ),
                  onTap: () {
                    //need to write code here for this functionality
                    FocusScope.of(context).unfocus();
                  },
                )
              ],
            ),
          ),
        ));
  }

  TableCalendar calenderWidget(BuildContext context) {
    return TableCalendar(
      initialCalendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
      },
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      calendarController: _calendarController,
      onDaySelected: (date, events, holidays) {
        final df = new DateFormat('dd/MM/yyyy');
        /*var s = df.format(date);
        _controller.text = s;*/
        setState(() {
          var s = df.format(date);
          _controller.text = s;
          print(s);
        });
        Navigator.of(context).pop();
        FocusScope.of(context).unfocus();
      },
    );
  }
}
