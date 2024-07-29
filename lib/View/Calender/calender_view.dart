import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vizmo_lakshmi_calender/Model/ApiInterface.dart';
import 'package:vizmo_lakshmi_calender/Model/Response/events_model.dart';
import 'package:vizmo_lakshmi_calender/Utils/StyleData.dart';
import 'package:vizmo_lakshmi_calender/ViewModel/calender_vm.dart';

import '../../Model/ApiResponse.dart';
import '../../Model/Status.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {

  final ApiInterface apiClient = ApiInterface();

  Map<String, List<Map<String, dynamic>>> _events = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateFormat formatter = DateFormat('EEE dd MMM');
  final DateFormat timeFormatter = DateFormat('h:mm a');
  bool isFetching = true;
  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {

    final data1 =await apiClient.getEVentsDetails(query: {});

    var data = data1.toJson();

    print("DATA LOADED----");
    print(data);
    final eventsList = data['data'] as List<dynamic>;

    for (var event in eventsList) {
      final eventMap = event as Map<String, dynamic>;
      final startAt = DateTime.parse(eventMap['startAt']);
      final eventDetails = {
        'title': eventMap['title'],
        'description': eventMap['description'],
        'status': eventMap['status'],
        'duration': eventMap['duration'],
        'time':timeFormatter.format(startAt) ,
      };

      if (_events[startAt] != null) {
        _events[StyleData.dateFormat.format(startAt)]!.add(eventDetails);
      } else {
        _events[StyleData.dateFormat.format(startAt)] = [eventDetails];
      }
    }


    Map today = {
      "createdAt": "2024-07-30T04:24:39.551Z",
    "title": "impedit",
    "description": "Fugit ad laboriosam deleniti nemo ipsum. Accusantium quaerat sit delectus consectetur unde similique exercitationem quisquam error. Fugiat eveniet voluptates at sint.",
    "status": "Confirmed",
    "startAt": "2024-07-30T21:59:48.742Z",
    "duration": 105,
    "id": "b6ad1f4289aad5b3a2135bab"
  };
    final startAt = DateTime.parse(today['startAt']);
    Map<String,dynamic> eventDetails = {
      'title': today['title'],
      'description': today['description'],
      'status': today['status'],
      'duration': today['duration'],
      'time':timeFormatter.format(startAt) ,
    };

    // _events[startAt]!.add(eventDetails);
    if (_events[startAt] != null) {
      _events[StyleData.dateFormat.format(startAt)]!.add(eventDetails);
    } else {
      _events[StyleData.dateFormat.format(startAt)] = [eventDetails];
    }

    log("LIST ALL EVENTS");
    log(_events.toString());

    setState(() {
      isFetching = !isFetching;
    });

  }

  int currentMonth = DateTime.now().month;
  DateTime selectedYear = DateTime.now();
  int? selectedColor = DateTime.now().month - 1 ;
  double animatedHieght =150;
  bool _visible=false;
  enableSet(int min){
    Future.delayed(Duration(milliseconds: min), () { //asynchronous delay
      if (mounted) { //checks if widget is still active and not disposed
        setState(() { //tells the widget builder to rebuild again because ui has updated
          _visible=!_visible; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(_events[StyleData.dateFormat.format(_selectedDay ?? DateTime.now()) ?? StyleData.dateFormat.format(_focusedDay)] ?? [] );
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[200],
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  children: [
                    SizedBox(width: width * 0.03,),
                     Text("Your schedule",style: TextStyle(fontFamily: StyleData.boldFont),),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 90),
                    // height: animatedHieght ,
                    width: width * 0.95,
                    curve: Curves.bounceIn,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.3),
                            blurRadius: 3,
                            offset: const Offset(2,5),
                          )
                        ],
                        gradient:const LinearGradient(
                            colors: [
                              Colors.white,
                              Color(0xFFEEEEEE),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp)
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            // InkWell(
                            //   onTap: (){
                            //     // showDialog(
                            //     //   context: context,
                            //     //   builder: (_) => selectMonth(),
                            //     // );
                            //   },
                            //   child: Container(
                            //     width: width * 0.36,
                            //     height: 40,
                            //     decoration: BoxDecoration(
                            //       // border:
                            //       borderRadius: BorderRadius.circular(2),
                            //       border: Border.all(color: Colors.transparent),
                            //     ),
                            //     child: const Row(
                            //       children:  [
                            //         SizedBox(width: 10),
                            //         // Text(listOfMonth[currentMonth-1],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.black38)),
                            //         Spacer(),
                            //         Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,size: 19),
                            //         SizedBox(width: 4),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(width: 10),
                            // InkWell(
                            //   onTap: (){
                            //     // selectYearCalender( context);
                            //   },
                            //   child: Container(
                            //     width: width/4.2,
                            //     height: 40,
                            //     decoration: BoxDecoration(
                            //       // border:
                            //       borderRadius: BorderRadius.circular(2),
                            //       border: Border.all(color: Colors.transparent),
                            //     ),
                            //     child: const Row(
                            //       children:  [
                            //         SizedBox(width: 10),
                            //         // Text("${selectedYear.year}",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black38),),
                            //         Spacer(),
                            //         Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,size: 19),
                            //         SizedBox(width: 4),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            const Spacer(),
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    if (animatedHieght == 150) {
                                      animatedHieght = height * 0.52;
                                      enableSet(90);
                                    } else {
                                      enableSet(0);
                                      Future.delayed(const Duration(milliseconds: 100), () { //asynchronous delay
                                        if (mounted) { //checks if widget is still active and not disposed
                                          setState(() { //tells the widget builder to rebuild again because ui has updated
                                            animatedHieght = 150; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
                                          });
                                        }
                                      });

                                    }
                                  });

                                },
                                child: Icon(_visible ? Icons.fullscreen_exit :Icons.fullscreen,color: Colors.black12,size: 28,)),
                            const SizedBox(width: 8,)
                          ],
                        ),
                        TableCalendar(
                          calendarFormat: _visible ? CalendarFormat.month : CalendarFormat.week,
                          // firstDay: DateTime(selectedYear.year,currentMonth,1),
                          firstDay: DateTime(2020,1,1),
                          lastDay: DateTime(selectedYear.year, currentMonth,numberOfDay(currentMonth)),
                          pageAnimationEnabled: false,
                          formatAnimationCurve:Curves.slowMiddle,
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          // formatAnimationDuration: Duration(milliseconds:isFullSizedCalender ? 500: 0),
                          daysOfWeekStyle: const DaysOfWeekStyle (
                              weekdayStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
                              weekendStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w500)
                          ),
                          calendarStyle:  CalendarStyle(
                              todayDecoration:BoxDecoration(
                                  color:  Colors.transparent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              isTodayHighlighted: false,
                              selectedDecoration:  BoxDecoration(
                                color:  StyleData.appBarColor,
                                shape: BoxShape.circle,
                              ),
                              markersAlignment:Alignment.center,

                            markerDecoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          ),


                          eventLoader: (day) {
                            return _events[StyleData.dateFormat.format(day)] ?? [];
                          },
                          headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              leftChevronVisible: true,
                              rightChevronVisible: true,
                              titleCentered: true,
                              titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)
                          ),


                          onDaySelected: (selectedDay, focusedDay) {
                            // if (!isSameDay(_selectedDay, selectedDay)) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            // }

                          },


                        ),
                        const SizedBox(height: 7),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 17,),
                Row(
                  children: [
                    SizedBox(width: width * 0.03,),
                    Text(formatter.format(_selectedDay ?? DateTime.now()),style: TextStyle(fontFamily: StyleData.regularFont,color: Colors.black38),),
                  ],
                ),
                const SizedBox(height: 5,),

               isFetching ? CircularProgressIndicator(strokeWidth: 2,) : SizedBox(
                  height: height * 0.6,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 25),
                    // itemCount: leadList.length,
                    // itemCount:(_events[day] ?? [] )state.data?.data?.length,
                    itemCount:(_events[StyleData.dateFormat.format(_selectedDay ?? DateTime.now()) ?? StyleData.dateFormat.format(_focusedDay)] ?? [] ).length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    // controller: _scrollController,
                    itemBuilder:
                        (BuildContext context, int index) {
                      // var data = leadList[index];

                          final  data = _events[StyleData.dateFormat.format(_selectedDay ?? DateTime.now()) ?? StyleData.dateFormat.format(_focusedDay)];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 5.0, offset: Offset(1, 2), spreadRadius: 1),
                              ],
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white
                          ),
                          child: ListTile(
                            title: Text(data![index]['title'] ?? "",style: TextStyle(fontFamily: StyleData.boldFont)),
                            subtitle: Text(data[index]['time'] ?? ""),
                            trailing: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:data[index]['status'] == "Confirmed"  ?Colors.green : Colors.red
                              ),
                              child: Center(child:Icon(data[index]['status'] == "Confirmed"  ?Icons.done : Icons.clear,color: Colors.white,size: 14,)),
                            ),
                          ),
                        ),
                      );

                    },
                  ),
                ),
                // BlocBuilder<CalenderVM, ApiResponse<EventModel>>(
                //     builder: (BuildContext context, state) {
                //       switch (state.status) {
                //         case (Status.completed):
                //           {
                //             return  SizedBox(
                //               height: height * 0.6,
                //               child: ListView.builder(
                //                 padding: const EdgeInsets.only(bottom: 25),
                //                 // itemCount: leadList.length,
                //                 itemCount: state.data?.data?.length,
                //                 shrinkWrap: true,
                //                 scrollDirection: Axis.vertical,
                //                 // controller: _scrollController,
                //                 itemBuilder:
                //                     (BuildContext context, int index) {
                //                   // var data = leadList[index];
                //                   var data = state.data?.data?[index];
                //                   return ListTile(
                //                     title:Text(data?.title?? "") ,
                //                     subtitle: Text(data?.description?? "") ,
                //                   );
                //
                //                 },
                //               ),
                //             );
                //           }
                //         case (Status.loading):
                //           {
                //             return const SizedBox(
                //               height:60,
                //               width:60,
                //               child: CircularProgressIndicator(),
                //             );
                //           }
                //         case (Status.error):
                //           {
                //             return  Center(child: Text(state.message ?? ""));
                //           }
                //         default:
                //           return Container();
                //       }
                //     })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

numberOfDay(int month){
  switch(month){
    case(1):
      return 31;
    case(2):
      return 28;
    case(3):
      return 31;
    case(4):
      return 30;
    case(5):
      return 31;
    case(6):
      return 30;
    case(7):
      return 31;
    case(8):
      return 31;
    case(9):
      return 30;
    case(10):
      return 31;
    case(11):
      return 30;
    case(12):
      return 31;
  }
}