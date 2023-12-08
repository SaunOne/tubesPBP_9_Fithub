import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:slideable/slideable.dart';
import 'package:ugd6_b_9/constant/app_constant.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/database/Client/ScheduleGymClient.dart';
import 'package:ugd6_b_9/dummy/dummyAll.dart';
import 'package:ugd6_b_9/entity/model/scheduleGym.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:dialogs/dialogs.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarScreenState();
  }
}

class CalendarScreenState extends State<CalendarScreen> {
  bool showEvents = true;

  List<NeatCleanCalendarEvent> _todaysEvents = [
    NeatCleanCalendarEvent(
      'Event A',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0),
      description: 'A special event',
      color: Colors.blue[700],
    ),
  ];

  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent(
      'MultiDay Event A',
      description: 'test desc',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 2, 12, 0),
      color: Colors.orange,
      isMultiDay: true,
    ),
    NeatCleanCalendarEvent(
      'Allday Event B',
      description: 'test desc',
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day - 2, 14, 30),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 2, 17, 0),
      color: Colors.pink,
      isAllDay: true,
      // icon: 'assets/event1.jpg',
    ),
    NeatCleanCalendarEvent(
      'Normal Event D',
      description: 'test desc',
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 14, 30),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 0),
      color: Colors.indigo,
      // icon: 'assets/events.jpg',
    ),
    NeatCleanCalendarEvent(
      'Normal Event E',
      description: 'test desc',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 45),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
      color: Colors.indigo,
      // icon: 'assets/profile01.jpg',
    ),
  ];

  Widget deleteDialog = CupertinoAlertDialog(
    title: Text('Confirmation '),
    content: Text('Are your sure want to Delete this schedule?'),
    actions: [
      CupertinoDialogAction(
        child: Text('NO'),
      ),
      CupertinoDialogAction(
        child: Text('Yes'),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    // Force selection of today on first load, so that the list of today's events gets shown.
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
        tanggal = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
        print('tanggal sekarang : ${tanggal}');
  }

  void changeContent(index) {
    setState(() {
      this.index = index;
    });
  }

  

  int index = 0;
  Duration duration = Duration.zero;
  String? exercise;
  String? note;
  DateTime? tanggal;
  int id = 0;
  TextEditingController noteController = new TextEditingController();
  bool isDuration = false;
  bool isInput = true;

  void setDuration(int minute){
    setState(() {
      duration = Duration(minutes: minute);
    });
  }

  void setTanggal(DateTime tanggal){
    setState(() {
      tanggal = tanggal;
    });
  }

  void inputSchedule(index) {
    var respon = ScheduleClient().create(
        tanggal: tanggal.toString(),
        durasi: duration.toString(),
        note: noteController.text,
        scheduleName: exercise);
    // print('INI VALUE YANG MAU DI CREATE tanggal : ${tanggal.toString()}, duration : ${duration.toString()}, note: ${noteController.text}, shceduleName : ${exercise}');
    changeContent(index);
  }

  void updateSchedule(index) {
    if (id == 0) {
      print('Id Kosong');
    }
    {
      var respon = ScheduleClient().update(
          id: id,
          tanggal: tanggal.toString(),
          durasi: duration.toString(),
          note: noteController.text,
          scheduleName: exercise);
    } 
    changeContent(index);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery
        .of(context)
        .size
        .height;
    double w = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
       child: Scaffold(
         backgroundColor: Colors.white,
         body: Stack(
           children: [
      //       //Decoration Backorund blue
            Positioned(
                child: Container(
              height: 320,
              decoration: BoxDecoration(
                color: ColorC().primaryColor1,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
              ),
            )),

      //       //App Content
            Positioned(
              top: 15,
              left: 5,
              right: 5,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 30, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () { 
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                FontAwesomeIcons.chevronLeft,
                                color: Colors.white,
                                weight: 300,
                              ),),
                          Text(
                            'Training Schedule',
                            style: StyleText(color: Colors.white)
                                .styleH2bWithColor,
                          ),
                        ],
                      ),
                      if (isInput ==
                          true) //menghasus data di var penampung ketika add
                        IconButton(
                          key: Key('createButton'),
                          onPressed: () {
                            noteController.text = '';
                            exercise = null;
                            duration = Duration.zero;
                            changeContent(1);
                          },
                          icon: Icon(
                            FontAwesomeIcons.plus,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

      //       //Calender
             Positioned(
               child: Container(
                 padding: EdgeInsets.only(top: 100, left: 30, right: 30),
                 child: Column(
                   children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          const BoxShadow(
                            color:  Colors.grey, // Warna bayangan
                            offset: const Offset(0, 1), // Posisi bayangan (x, y)
                            blurRadius: 6, // Radius blur
                            spreadRadius: 0.5, // Radius penyebaran
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SafeArea(
                        child: Calendar(
                          startOnMonday: true,
                          weekDays: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
                          // eventsList: _eventList,
                          isExpandable: false,
                          eventDoneColor: Colors.green,
                          selectedColor: Colors.pink,
                          selectedTodayColor: Colors.green,
                          todayColor: Colors.blue,
                          eventColor: null,
                          locale: 'de_DE',
                          todayButtonText: 'Heute',
                          allDayEventText: 'Ganztägig',
                          multiDayEndText: 'Ende',
                          isExpanded: true,
                          expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                          // onEventSelected: (value) {
                          //   print('sembarang');
                          //   print('Event selected ${value.summary}');
                          // },
                          onDateSelected: (value) {
                            tanggal = value;
                          },
                          onEventLongPressed: (value) {
                            print('Event long pressed ${value.summary}');
                          },
                          onMonthChanged: (value) {
                            print('Month changed $value');
                          },
                          onRangeSelected: (value) {
                            print('Range selected ${value.from} - ${value.to}');
                          },
                          datePickerType: DatePickerType.date,
                          dayOfWeekStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 11),
                          showEvents: showEvents,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

      //               //Isi Schedule
                    if (index == 0)
                      Flexible(
                        child: FutureBuilder<List<ScheduleGym>>(
                          future: ScheduleClient().showAll(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Tampilkan indikator loading jika masih menunggu data
                            } else if (snapshot.hasError) {
                              print(snapshot);
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Text('Tidak ada data.');
                            } else {
                              List<ScheduleGym> scheduleList = snapshot.data!;
                              return ListView.builder(
                                itemCount: scheduleList.length,
                                itemBuilder: (context, index) {
                                  ScheduleGym schedule = scheduleList[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    child: Slideable(
                                      items: [
                                        ActionItems(
                                        
                                          backgroudColor: Colors.transparent,
                                          radius: BorderRadius.circular(10),
                                          icon: Icon(
                                              FontAwesomeIcons.penToSquare),
                                          onPress: () {
                                            isInput = false; //update
                                            _handleNewDate(tanggal);
                                            id = schedule.id;
                                            tanggal = DateTime.tryParse(schedule.tanggal);
                                            noteController.text = schedule.note;
                                            exercise = schedule.scheduleName;
                                            duration = convetDuration(schedule.durasi);
                                            changeContent(1);
                                          },
                                        ),
                                        ActionItems(
                                          backgroudColor: Colors.transparent,
                                          icon: Icon(FontAwesomeIcons.trash),
                                          onPress: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  CupertinoAlertDialog(
                                                title: Text('Confirmation '),
                                                content: Text(
                                                    'Are your sure want to Delete ${schedule.scheduleName} schedule?'),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    onPressed: () {
                                                      print('masuk delete');
                                                      isInput = false;
                                                      id = schedule.id;
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('No'),
                                                  ),
                                                  CupertinoDialogAction(
                                                    onPressed: () {
                                                      print('ini idnya');
                                                      ScheduleClient()
                                                          .destroy(schedule.id);
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.all(3),
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey, // Warna bayangan
                                              offset: Offset(0,
                                                  1), // Posisi bayangan (x, y)
                                              blurRadius: 3, // Radius blur
                                              spreadRadius:
                                                  0.5, // Radius penyebaran
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  schedule.note,
                                                  style: StyleText().stylePl,
                                                ),
                                                Text(schedule.durasi,
                                                    style: StyleText().stylePl),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  schedule.scheduleName,
                                                  style: StyleText(
                                                          color: ColorC()
                                                              .primaryColor1)
                                                      .styleH3b,
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: Text(
                                                        schedule.tanggal,
                                                        style: StyleText(
                                                                color: ColorC()
                                                                    .primaryColor1)
                                                            .styleH4lWithColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons.calendar,
                                                      size: 20,
                                                      color: ColorC()
                                                          .primaryColor1,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),

      //               //Input Jadwal Gym
                    if (index == 1)
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' Gym Excersise',
                                        style: StyleText().styleH4b,
                                      ),
                                      SizedBox(height: 8),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          isExpanded: true,
                                          hint: const Row(
                                            children: [
                                              Icon(
                                                Icons.list,
                                                size: 16,
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Select Item',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 5, 5, 5),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: items
                                              .map((String item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: StyleText(
                                                              color:
                                                                  Colors.black)
                                                          .stylePbWithColor,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: exercise,
                                          onChanged: (String? value) {
                                            setState(() {
                                              exercise = value;
                                              print(
                                                  exercise); // Perbarui nilai selectedValues
                                            });
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            height: 50,
                                            width: 220,
                                            padding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: Colors.black26,
                                              ),
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                            elevation: 2,
                                          ),
                                          iconStyleData: const IconStyleData(
                                            icon: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            ),
                                            iconSize: 14,
                                            iconEnabledColor:
                                                Color.fromARGB(255, 0, 0, 0),
                                            iconDisabledColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 200,
                                            width: 220,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                            offset: const Offset(0, 0),
                                            scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: MaterialStateProperty
                                                  .all<double>(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all<
                                                      bool>(true),
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' Duration',
                                        style: StyleText().styleH4b,
                                      ),
                                      SizedBox(height: 5),
                                      MaterialButton(
                                        padding: EdgeInsets.all(3),
                                        onPressed: () {
                                          print('masuk');
                                          setState(() {
                                            isDuration = true;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10, left: 15),
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors
                                                    .grey, // Warna bayangan
                                                offset: Offset(0,
                                                    1), // Posisi bayangan (x, y)
                                                blurRadius: 3, // Radius blur
                                                spreadRadius:
                                                    0.5, // Radius penyebaran
                                              ),
                                            ],
                                          ),
                                          child: duration == Duration.zero
                                              ? Text('Durasi Latihan')
                                              : Text(
                                                  duration.inMinutes
                                                          .toString() +
                                                      '  Minutes',
                                                  style: StyleText().styleH4l,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                margin: EdgeInsets.only(bottom: 30),
                                child: TextFormField(
                                  maxLines: 3,
                                  minLines: 2,
                                  controller: noteController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Note',
                                    hintText: 'Enter your Note',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    // Shadow

                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.5),
                                    //     spreadRadius: 2,
                                    //     blurRadius: 5,
                                    //     offset: Offset(0, 3),
                                    //   ),
                                    // ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(bottom: 30),
                                    child: MaterialButton(
                                      onPressed: () {
                                        changeContent(0);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 5, bottom: 5, left: 20, right: 20),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 171, 24, 13),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: StyleText(color: Colors.white)
                                              .styleH4bWithColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(bottom: 30),
                                    child: MaterialButton(
                                      onPressed: () {
                                        print(isInput);
                                        isInput == true
                                            ? inputSchedule(0)
                                            : updateSchedule(0);
                                        isInput = true;
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 5, bottom: 5, left: 20, right: 20),
                                        decoration: BoxDecoration(
                                          color: ColorC().primaryColor1,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'Save',
                                          style: StyleText(color: Colors.white)
                                              .styleH4bWithColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (isDuration == true)
              Positioned(
                child: Container(
                  width: 100 * w,
                  height: 100 * h,
                  color: Color.fromARGB(88, 0, 0, 0),
                ),  
              ),
            if (isDuration == true)
              Positioned(
                child: Container(
                  width: 100 * w,
                  height: 100 * h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Expanded(
                            child: DurationPicker(
                              duration: duration,
                              baseUnit: BaseUnit.minute,
                              onChange: (val) {
                                setState(() => duration = val);
                              },
                              snapToMins: 1.0,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              print('masuk ke duration');
                              isDuration = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: ColorC().primaryColor1,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Okey',
                              style: StyleText(color: Colors.white)
                                  .styleH4bWithColor,
                            ),
                          ),
                        ),
                       ],
                    ),
                   ),
                 ),
              ),
           ],
         ),
       ),
    );
  }

  //List Content

  void _handleNewDate(date) {
    print('Date selected: $date');
  }

  Duration convetDuration(String durasi){
    print('durasi : ${durasi}');
    List<String> waktuParts = durasi.split(':');

    int jam = int.parse(waktuParts[0]);
    int menit = int.parse(waktuParts[1]);
    int detik = int.parse(waktuParts[2]);

    
    Duration waktuDuration = Duration(hours: jam, minutes: menit, seconds: detik);
    print('hasil : ${waktuDuration}');
    return waktuDuration;
  }
}