import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lichvannien/calendar/calendar.dart';
import 'package:lichvannien/event/EventList.dart';
import 'package:lichvannien/model/Data/DataBatTu.dart';
import 'package:lichvannien/model/Data/DataDongCong.dart';
import 'package:lichvannien/model/Data/DataThapNhi.dart';
import 'package:lichvannien/model/Data/DataTrangTrinh.dart';
import 'package:lichvannien/model/EventVO.dart';
import 'package:lichvannien/model/DataService.dart';
import 'package:lichvannien/model/ReadData/ModelBatTu.dart';
import 'package:lichvannien/model/ReadData/ModelDongCong.dart';
import 'package:lichvannien/model/ReadData/ModelThapNhiKienTru.dart';
import 'package:lichvannien/model/ReadData/ModelTrangTrinh.dart';
import 'package:lichvannien/screen/auth/main_screen.dart';
import 'package:lichvannien/screen/calendar_month/CheckGioLucNham.dart';
import 'package:lichvannien/screen/calendar_month/tinhtuvi/checknguhanh.dart';
import 'package:lichvannien/screen/calendar_month/tinhtuvi/CheckQuanNiem.dart';
import 'package:lichvannien/screen/calendar_month/CheckXung.dart';
import 'package:lichvannien/screen/calendar_month/widget/HomNay.dart';
import 'package:lichvannien/screen/calendar_month/checkgiohoangdao.dart';
import 'package:lichvannien/screen/calendar_month/tinhtuvi/checknapamngay.dart';
import 'package:lichvannien/screen/calendar_month/tinhtuvi/checkngayhoangdao.dart';
import 'package:lichvannien/screen/calendar_month/tinhtuvi/checknhithap.dart';
import 'package:lichvannien/screen/calendar_month/tinhtuvi/checktruc.dart';
import 'package:lichvannien/screen/calendar_month/tinhtuvi/ngayxuathanh.dart';
import 'package:lichvannien/screen/calendar_month/tinhtuvi/tinhlucdieu.dart';
//import 'package:lichvannien/screen/calendar_month/chonngay.dart';
import 'package:lichvannien/utils/lunar_solar_utils.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class CalendarMonthScreen extends StatefulWidget {
  const CalendarMonthScreen({
    super.key,
    //required this.selectedDate
  });
  //final DateTime selectedDate;

  @override
  State<CalendarMonthScreen> createState() => _CalendarMonthScreenState();
}

class _CalendarMonthScreenState extends State<CalendarMonthScreen> {
  DateTime _selectedDate = DateTime.now();
  //bool returnToday = false;
  List<EventVO> _eventData = [];
  List<EventVO> _eventByMonths = [];
  final List<ItemModelTrangTrinh> _items = itemListTrangTrinh;

  final List<DateTime> _markedDates = [];
  DateTime _calendar = DateTime.now();
  final ValueNotifier<double> fontSizeNotifier = ValueNotifier<double>(16);
  void increaseFontSize() {
    if (fontSizeNotifier.value < 24.0) {
      fontSizeNotifier.value += 1.0;
    }
  }

  void decreaseFontSize() {
    if (fontSizeNotifier.value > 12.0) {
      fontSizeNotifier.value -= 1.0;
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
    DateTime now = DateTime.now();
    _selectedDate = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, now.hour, now.minute, now.second);
  }

  _getData() async {
    var data = await loadEventData();
    setState(() {
      _eventData = data;
    });
    generateEventByMonth(_calendar.month);
    generate_markedDates();
  }

  // ignore: non_constant_identifier_names
  generate_markedDates() {
    _markedDates.clear();
    for (var event in _eventData) {
      _markedDates.add(event.date);
    }
  }

  generateEventByMonth(int month) {
    _eventByMonths.clear();
    for (var event in _eventData) {
      if (event.date.month == month) {
        _eventByMonths.add(event);
      }
    }
    setState(() {
      _eventByMonths = _eventByMonths;
    });
  }

  Widget boxBox(Widget widget, String text) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.yellow,
              ),
              height: 30,
              //width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              height: 2,
            ))
            // Column(
            //   children: [
            //     Container(
            //       height: 10,
            //     ),
            //     const Divider(
            //       height: 5,
            //       thickness: 2,
            //       indent: 190,
            //       endIndent: 0,
            //       color: Colors.white,
            //     ),
            //     Container(),
            //   ],
            // ),
          ],
        ),
        const SizedBox(
          height: 27,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: widget,
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }

  void handleDaySelected(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  // void returnToday(){
  //   setState(() {

  //   });
  // }

  // ignore: non_constant_identifier_names
  // Check11(dynamic nguhanh) {
  //   if (nguhanh > 5) {
  //     nguhanh = nguhanh - 5;
  //   }

  //   if (nguhanh == 2) {
  //     return const Text('Thủy');
  //   } else if (nguhanh == 3) {
  //     return const Text('Hỏa');
  //   } else if (nguhanh == 4) {
  //     return const Text('Thổ');
  //   } else if (nguhanh == 5) {
  //     return const Text('Mộc');
  //   } else {
  //     return const Text('Kim');
  //   }
  // }

  Widget text(String text, String text1) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: text1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget checkXung(String a, String a1) {
    return Container(
      height: 131,
      width: 337,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 3),
              blurRadius: 7,
              spreadRadius: 5,
            ),
          ],
          color: const Color(0xffFCCDB3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 0.3)),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          a,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CheckXung(
            nameDay: a1,
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = min(6, _items.length);
    List<ItemModelTrangTrinh> randomItems = [..._items];
    randomItems.shuffle();
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // super.build(context);
    var isToday = _selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day;
    var lunarDates = convertSolar2Lunar(
        _selectedDate.day, _selectedDate.month, _selectedDate.year, 7);
    var lunarDay = lunarDates[0];
    var lunarMonth = lunarDates[1];
    var lunarYear = lunarDates[2];
    var lunarMonthName = getCanChiMonth(lunarMonth, lunarYear);
    var lunarYearName = getCanChiYear(lunarYear);

    var jd = jdn(_selectedDate.day, _selectedDate.month, _selectedDate.year);
    var dayName = getCanChiDay(jd);
    var tietkhi = getTietKhi(jd);
    var canNgay = getCanDay(jd);
    var chiNgay = getChiDay(jd);
    //var lucnhan = getLucNham(jd);
    var nguhanhCan = getNguHanhCheck(canNgay, '');
    var nguhanhChi = getNguHanhCheck('', chiNgay);
    var check = getTruc(_selectedDate.month, chiNgay);
    var napam = getNapAmNgay(dayName);
    var checkNgayHD = getNgayHoangDao(
      lunarMonth,
      chiNgay,
    );

    var dongCong = ('$check $chiNgay');
    print('$dongCong');
    var quanniem = getQuanNIem(lunarDay);
    var lunarMansion = getLunarMansion(_selectedDate);
    var lucdieu = getNgayLucDieu(lunarMonth, lunarDay);
    print('tan vlog: $lucdieu');
    var xuathanh = getThongBao(lunarMonth, lunarDay);

    // print(xuathanh.toString());
    //print('${check.runtimeType}');
    List<ItemModelThapNhi> listThapNhi = itemListThapNhi
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == check)
        .toList();
    List<ItemModelDongCong> listDongCong = itemListDongCong
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == dongCong)
        .toList();
    List<ItemModelBatTu> listBatTu = itemListBatTu
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == lunarMansion)
        .toList();
    //print(listDongCong);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFCCDB3),
        title: Text(
          ' ${_selectedDate.month}, ${_selectedDate.year}',
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ));
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: const Color(0xffFBBA95),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: (screenHeight * 30 / 100),
                        width: (screenWidth * 30 / 100),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 7,
                              child: ScrollDatePicker(
                                minimumDate: DateTime(2000, 1, 1),
                                maximumDate: DateTime(2060),
                                options: const DatePickerOptions(
                                    backgroundColor: Color(0xffFBBA95)),
                                selectedDate: _selectedDate,
                                locale: Locale('en'.tr()),
                                onDateTimeChanged: (DateTime value) {
                                  setState(() {
                                    _selectedDate = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(0, 3),
                                        blurRadius: 7,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                    color: const Color(0xffFCCDB3),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'choose_adate',
                                      style: TextStyle(
                                        color: Color(0xffFF5C00),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        //fontFamily: 'CCGabrielBautistaLito'
                                      ),
                                    ).tr(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.search,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 60),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 3),
                                blurRadius: 7,
                                spreadRadius: 5,
                              ),
                            ],
                            color: const Color(0xffFCCDB3),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.white, width: 0.3)),
                        width: 340,
                        child: Calendar(
                          //returnToday: returnToday,
                          //returnToday: returnToday,
                          onDaySelected: handleDaySelected,
                          markedDays: _markedDates,
                          onDateTimeChanged: (newDate) {
                            setState(() {
                              _calendar = newDate;
                            });
                            generateEventByMonth(newDate.month);
                          },
                          selectedDate: _selectedDate,
                        ),
                      )),
                  boxBox(
                      Column(
                        children: [
                          HomNay(
                            a: 'duong_lich'.tr(),
                            a1: _selectedDate.day.toString(),
                            a2: _selectedDate.month.toString(),
                            a3: _selectedDate.year.toString(),
                            a4: '',
                            a5: '',
                            a6: '',
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          HomNay(
                              a: 'am_lich'.tr(),
                              a1: lunarDay.toString(),
                              a2: lunarMonth.toString(),
                              a3: lunarYear.toString(),
                              a4: dayName,
                              a5: lunarMonthName,
                              a6: lunarYearName),
                        ],
                      ),
                      'Today'.tr()),
                  boxBox(
                      CheckGioHoangDao(
                        nameDay: chiNgay,
                      ),
                      'gio_hoang_dao'.tr()),
                  boxBox(
                      Column(
                        children: [
                          checkXung('tuoi_xung_theo_ngay'.tr(), dayName),
                          const SizedBox(
                            height: 32,
                          ),
                          checkXung(
                              'tuoi_xung_theo_thang'.tr(), lunarMonthName),
                        ],
                      ),
                      'tuoi_xung'.tr()),
                  boxBox(
                      EventList(
                        data: _eventByMonths,
                      ),
                      'event'.tr()),
                  boxBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text('tietkhi'.tr(), tietkhi),
                          text('daitieunguyet'.tr(), 'thang_du'.tr()),
                          text('napam'.tr(), napam),
                          text('checkNgayHD'.tr(), checkNgayHD),
                          text('lucdieu'.tr(), lucdieu),
                          text('xuathanh'.tr(), xuathanh),
                          text('quanniem'.tr(), quanniem),
                          text('chingay'.tr(), '$chiNgay ($nguhanhChi)'),
                          text('canngay'.tr(), '$canNgay ($nguhanhCan)'),
                        ],
                      ),
                      'tongquan'.tr()),
                  //boxBox(Container(), 'Sao tốt - Sao xấu'),
                  boxBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            'truc'.tr(),
                            check,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listThapNhi.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  listThapNhi[index].noidung,
                                  style: const TextStyle(fontSize: 16),
                                ).tr();
                              },
                            ),
                          )
                        ],
                      ),
                      'thap_nhi'.tr()),
                  boxBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            'sao'.tr(),
                            lunarMansion,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listBatTu.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  listBatTu[index].noidung.tr(),
                                  style: const TextStyle(fontSize: 16),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      'nhi_thap'.tr()),
                  boxBox(
                      CheckLucNham(lucnhamngay: lucdieu), 'gio_lucnham'.tr()),

                  boxBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            'Day'.tr(),
                            dongCong,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listDongCong.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  listDongCong[index].noidung.tr(),
                                  style: const TextStyle(fontSize: 16),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      'dong_cong'.tr()),
                  boxBox(
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: Text(
                              randomItems[index].ten.tr(),
                            ),
                            children: [Text(randomItems[index].noidung).tr()],
                          );
                        },
                      ),
                      'trang_trinh'.tr()),
                ],
              ),
            ),
            Positioned(
              right: 10,
              bottom: 40,
              child: Column(
                children: [
                  //        InkWell(

                  //   onTap: (){
                  //      LocalizationChecker.changeLanguge(context);
                  //   }
                  // ),
                  if (!isToday)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = DateTime.now();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: Colors.white, width: 0.3)),
                        height: 30,
                        width: 100,
                        child: Center(
                            child: Text(
                          'Today',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ).tr()),
                      ),
                    )
                  // ElevatedButton(
                  //     onPressed: () {
                  //
                  //     },
                  //     child: const Text(
                  //       'Hôm nay',
                  //       style: TextStyle(fontSize: 16, color: Colors.red),
                  //     )),
                  // TextButton(
                  //   onPressed: increaseFontSize,
                  //   child: const Icon(
                  //     Icons.add_circle,
                  //     color: Colors.yellow,
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: decreaseFontSize,
                  //   child: const Icon(
                  //     Icons.remove_circle,
                  //     color: Colors.yellow,
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
