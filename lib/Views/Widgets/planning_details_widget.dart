import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reizen_technologie/ViewModel/DayPlanningViewModel.dart';
import 'package:reizen_technologie/Views/Widgets/planning_widget.dart';
import 'appbar.dart';

class PlanningDetailsPage extends StatefulWidget {
  PlanningDetailsPage({Key key, this.dayPlanning}) : super(key: key);

  int dayPlanning;

  @override
  _PlanningDetailsPageState createState() => _PlanningDetailsPageState();
}

class _PlanningDetailsPageState extends State<PlanningDetailsPage> {
  var content;

  List<DateTime> markedDates = [
    //DateFormat("yyyy-MM-dd").parse("2020-05-21"),
    //DateFormat("yyyy-MM-dd").parse("2020-05-24"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder(
          future: GetAllData(widget.dayPlanning),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            content = snapshot.data;
            if (!snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.done) {
                content = [];
              }
              return Center(child: CircularProgressIndicator());
            }

            return Scaffold(
                appBar: Appbar.getAppbar(
                  content[0]['day_planning'][0]['highlight'], //title
                  context,
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlanningPage()),
                          )),
                ),
                body: Column(
                  children: <Widget>[
                    Container(
                      child: CalendarStrip(
                        startDate: DateFormat("yyyy-MM-dd")
                            .parse(content[0]['day_plannings'][0]['date']),
                        endDate: DateFormat("yyyy-MM-dd").parse(content[0]
                                ['day_plannings']
                            [content[0]['day_plannings'].length - 1]['date']),
                        selectedDate: DateFormat("yyyy-MM-dd")
                            .parse(content[0]['day_planning'][0]['date']),
                        onDateSelected: onSelect,
                        dateTileBuilder: dateTileBuilder,
                        iconColor: Colors.black87,
                        monthNameWidget: _monthNameWidget,
                        markedDates: markedDates,
                        containerDecoration: BoxDecoration(),
                      ),
                    ),Divider(
                        indent: 35,
                        endIndent: 35,color: Colors.black26
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                      child: Text(
                        content[0]['day_planning'][0]['description'],
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    buildPlanning()
                  ],
                ));
          }),
    );
  }

  Widget buildPlanning() {
    var activitiesLength = content[0]['activities_by_day'].length;
    //var start_hour = DateFormat("hh-mm-ss").parse(content[0]['activities_by_day'][index]['start_hour'])
    return
    Expanded(
      child: Scrollbar(
        child: SingleChildScrollView(
      child:
        Padding(
          padding: EdgeInsets.only(left: 4, right: 4, top: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(activitiesLength, (index) {
                  var start_hour = DateFormat("hh:mm:ss").parse(
                      content[0]['activities_by_day'][index]['start_hour']);
                  var end_hour = DateFormat("hh:mm:ss").parse(
                      content[0]['activities_by_day'][index]['end_hour']);
                  return Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              content[0]['activities_by_day'][index]['name'],
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              content[0]['activities_by_day'][index]
                                  ['description'],
                              style: TextStyle(fontSize: 18),
                            ),
                            leading: Text(DateFormat.Hm().format(start_hour) +
                                "\n     -\n" +
                                DateFormat.Hm().format(end_hour)),
                          )
                        ]),
                  );
                }),
              ),
          ),
/*        ListView(
          padding: EdgeInsets.all(10.0),
          children: List.generate(activitiesLength, (index) {
            var start_hour = DateFormat("hh:mm:ss").parse(
                content[0]['activities_by_day'][index]['start_hour']);
            var end_hour = DateFormat("hh:mm:ss").parse(
                content[0]['activities_by_day'][index]['end_hour']);
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      content[0]['activities_by_day'][index]['name'],
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      content[0]['activities_by_day'][index]
                      ['description'],
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Text(DateFormat.Hm().format(start_hour) +
                        "\n     -\n" +
                        DateFormat.Hm().format(end_hour)),
                  )
                ]);
          }),
        ),*/
      )
      )
    );
  }

  void onSelect(data) {
    print("Selected Date -> $data");
    setDayPlanningId(data);
    setState(() {
      build(context);
    });
  }

  void setDayPlanningId(var data) {
    String selectedDayString = '2020-05-24'; //testData
    var selectedDay = new DateFormat("yyyy-MM-dd").parse(data.toString());

    for (int i = 0; i < content[0]['day_plannings'].length; i++) {
      String planningDateString = content[0]['day_plannings'][i]['date'];
      var planningDate = new DateFormat("yyyy-MM-dd").parse(planningDateString);

      if (planningDate == data) {
        widget.dayPlanning = i + 1;
      }
    }
  }

  _monthNameWidget(monthName) {
    var month = monthName.split(' ');
    switch (month[0]) {
      case "January":
        month[0] = "Januari";
        break;
      case "February":
        month[0] = "Februari";
        break;
      case "March":
        month[0] = "Maart";
        break;
      case "May":
        month[0] = "Mei";
        break;
      case "June":
        month[0] = "Juni";
        break;
      case "July":
        month[0] = "Juli";
        break;
      case "August":
        month[0] = "Augustus";
        break;
      case "October":
        month[0] = "Oktober";
        break;
    }

    return Container(
      child: Text(month[0] + ' ' + month[1],
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontStyle: FontStyle.italic)),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      ),
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    //dag vertalen
    switch (dayName) {
      case "Mon":
        dayName = "Ma";
        break;
      case "Tue":
        dayName = "Di";
        break;
      case "Wed":
        dayName = "Wo";
        break;
      case "Thr":
        dayName = "Do";
        break;
      case "Fri":
        dayName = "Vr";
        break;
      case "Sat":
        dayName = "Za";
        break;
      case "Sun":
        dayName = "Zo";
        break;
    }
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate
            ? Colors.transparent
            : Color.fromRGBO(224, 0, 73, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }
}
