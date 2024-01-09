// // ignore_for_file: dead_code
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:html/parser.dart';

// Future<void> parseData() async {
//   const String url = 'https://lichvn.net/xem-giai-ma-giac-mo-b21.html';
//   Dio dio = Dio();
//   var response = await dio.get(
//     url,
//     options: Options(
//       headers: {'cookie': 'any_cookie'},
//       // method: 'POST',
//     ),
//   );
//   //print the data to console.
//   // if (kDebugMode) {
//   //   print('_alexTR_logging_: response : $response');
//   // }
//   // set document
//   var document = parse(response.data);
//   // ket qua
//   String resultsJson = '';
//   //declaring a list of String to hold all the data.
//   List<String> data = [];
//   var boxTuViTronDoi = document.getElementsByClassName("chitiet_hd");
//   // var boxTuoi = document.getElementsByTagName("p");
//   List<String> Test = [];
//   // List<String> ThongTin = [];
//   // List<String> ThoBinh = [];
//   // List<String> CuocSong = [];
//   // List<String> TinhDuyen = [];
//   // List<String> GiaDao = [];
//   // List<String> TuoiHop = [];
//   // List<String> TuoiKy = [];
//   // List<String> HonNhan = [];
//   // List<String> NamKhoKhan = [];
//   // List<String> GioXuatHanh = [];
//   // List<String> DienBien = [];
//   // List<String> Test1 = [];
//   // List<String> Test2 = [];
//   // List<String> Test3 = [];
//   // List<String> Test4 = [];
//   // List<String> Test5 = [];
//   // List<String> Test6 = [];
//   // List<String> Test7 = [];
//   // List<String> Test8 = [];
//   // List<String> Test9 = [];
//   // List<String> Test10 = [];
//   // List<String> Test11 = [];
//   // List<String> Test12 = [];
//   // List<String> Test13 = [];
//   // List<String> Test14 = [];
//   // List<String> Test15 = [];
//   // resultsJson = '[{"id": $i,"a":"Có bao nhiêt cách chọn ra 3 học sinh từ một nhóm có 5 học sinh?","image": "","trueAnswer": "C_{5}^{3}","falseAnswer1": "5!","falseAnwser2": "A_{5}^{3}","falseAnwer3": "5^{3}"},';
//   // if (boxTuoi.isNotEmpty) {

//   //     if (boxTuoi[i].getElementsByTagName('td') != null &&
//   //         boxTuoi[i].getElementsByTagName('td').length >= 4) {
//   //       //for answer A
//   //       var Q1 = boxTuoi[i].getElementsByTagName('td')[0];
//   //       if (Q1 != null) {
//   //         ten.add(Q1.innerHtml);
//   //       }
//   //       //for answer B
//   //       var A1 = boxTuoi[i].getElementsByTagName('td')[1];
//   //       if (A1 != null) {
//   //         DapAn.add(A1.innerHtml.trim());
//   //         String DapAn1 = A1.innerHtml;
//   //         if (kDebugMode) {
//   //           print('DAP AN :${DapAn1.trim()}');
//   //         }
//   //       }
//   //       //for answer C
//   //       var Q2 = boxTuoi[i].getElementsByTagName('td')[2];
//   //       if (Q1 != null) {
//   //         ten.add(Q1.innerHtml);
//   //       }
//   //       //for answer B
//   //       var A2 = boxTuoi[i].getElementsByTagName('td')[3];
//   //       if (A2 != null) {
//   //         DapAn.add(A2.innerHtml.trim());
//   //         String DapAn2 = A1.innerHtml;
//   //         if (kDebugMode) {
//   //           print('DAP AN :${DapAn2.trim()}');
//   //         }
//   //       }
//   //       if (kDebugMode) {
//   //         print('_NGADAPAN:${boxTuoi.length}');
//   //       }
//   //     }

//   // }
//   // if (kDebugMode) {
//   //   print('Nga Xứng Đáng Có 10 ny');
//   // }

//   //     if (boxTuViTronDoi[i].getElementsByTagName('a') != null &&
//   //         boxTuViTronDoi[i].getElementsByTagName('a').isNotEmpty) {
//   //       var aTagA = boxTuViTronDoi[i].getElementsByTagName('a')[0];
//   //       if (aTagA != null &&
//   //           aTagA.getElementsByClassName('underline') != null &&
//   //           aTagA.getElementsByClassName('underline').isNotEmpty) {
//   //         a = aTagA.getElementsByClassName('underline')[0].innerHtml;
//   //         if (kDebugMode) {
//   //           print('_alexTR_logging_: a : ${a.trim()}');
//   //         }
//   //       }
//   //     }

//   // if (boxTuViTronDoi[i].getElementsByTagName('a') != null &&
//   //     boxTuViTronDoi[i].getElementsByTagName('a').length >= 0) {
//   //   var Quesion1 = boxTuViTronDoi[i].getElementsByTagName('a')[0];
//   //   if (Quesion1 != null) {
//   //     var attrs = Quesion1.attributes['title'];
//   //     if (attrs != null && attrs.isNotEmpty) {
//   //       a.add(attrs.trim());
//   //     }
//   //   }
//   // }
//   // if (boxTuViTronDoi[i].getElementsByTagName('a') != null &&
//   //     boxTuViTronDoi[i].getElementsByTagName('a').isNotEmpty) {
//   //   var aTagA = boxTuViTronDoi[i].getElementsByTagName('a')[0];
//   //   if (aTagA != null &&
//   //       aTagA.getElementsByClassName('underline') != null &&&&
//   //       aTagA.getElementsByClassName('underline').isNotEmpty) {
//   //     a.add(aTagA
//   //         .getElementsByClassName('underline')[0]
//   //         .innerHtml
//   //         .trim());
//   //     // if (kDebugMode) {
//   //     //   print('_alexTR_logging_: a : ${a}');
//   //     // }
//   //   }
//   // }
//   //image:
//   // if (boxTuViTronDoi[i].getElementsByTagName('img') != null &&
//   //     boxTuViTronDoi[i].getElementsByTagName('img').length > 0) {
//   //   var image1 = boxTuViTronDoi[i].getElementsByTagName('img')[0];
//   //   if (image1 != null) {
//   //     var attrs = image1.attributes['src'];
//   //     if (attrs != null && attrs.isNotEmpty) {
//   //       image.add(attrs.trim());
//   //     }
//   //   }
//   // } else {
//   //   image.add("");
//   // }
//   // answer A,b,c,d
//   if (boxTuViTronDoi[0].getElementsByTagName('p') != null &&
//       boxTuViTronDoi[0].getElementsByTagName('p').length >= 12) {
//     //for answer A
//     // var TestHtml = boxTuViTronDoi[0].getElementsByTagName('p')[0];
//     // if (TestHtml != null) {
//     //   Test.add(TestHtml.innerHtml.trim());

//     // }
//     // for answer B
//     var TestHtml = boxTuViTronDoi[0].getElementsByTagName('p')[1];
//     if (TestHtml != null) {
//       Test.add(TestHtml.innerHtml.trim());
//       //print(ThongTin[0]);
//       // }
//       // //for answer C
//       // var ThoBinhHtml = boxTuViTronDoi[0].getElementsByTagName('p')[2];
//       // if (ThoBinhHtml != null) {
//       //   ThoBinh.add(ThoBinhHtml.innerHtml.trim());
//       //   //print(ThoBinh[0]);
//       // }
//       // //for answer D
//       // var CuocSongHtml = boxTuViTronDoi[0].getElementsByTagName('p')[3];
//       // if (CuocSongHtml != null) {
//       //   CuocSong.add(CuocSongHtml.innerHtml.trim());
//       //   //print(CuocSong[0]);
//       // }
//       // var TinhDuyenHtml = boxTuViTronDoi[0].getElementsByTagName('p')[4];
//       // if (TinhDuyenHtml != null) {
//       //   TinhDuyen.add(TinhDuyenHtml.innerHtml.trim());
//       //   //print(TinhDuyen[0]);
//       // }
//       // var GiaDaoHtml = boxTuViTronDoi[0].getElementsByTagName('p')[5];
//       // if (GiaDaoHtml != null) {
//       //   GiaDao.add(GiaDaoHtml.innerHtml.trim());
//       //   //print(GiaDao[0]);
//       // }
//       // var TuoiHopHtml = boxTuViTronDoi[0].getElementsByTagName('p')[6];
//       // if (TuoiHopHtml != null) {
//       //   TuoiHop.add(TuoiHopHtml.innerHtml.trim());
//       //   //print(TuoiHop[0]);
//       // }
//       // var TuoiKyHtml = boxTuViTronDoi[0].getElementsByTagName('p')[7];
//       // if (TuoiKyHtml != null) {
//       //   TuoiKy.add(TuoiKyHtml.innerHtml.trim());
//       //   //print(TuoiKy[0]);
//       // }
//       // var HonNhanHtml = boxTuViTronDoi[0].getElementsByTagName('p')[8];
//       // if (HonNhanHtml != null) {
//       //   HonNhan.add(HonNhanHtml.innerHtml.trim());
//       //   //print(HonNhan[0]);
//       // }
//       // var NamKhoKhanHtml = boxTuViTronDoi[0].getElementsByTagName('p')[9];
//       // if (NamKhoKhanHtml != null) {
//       //   NamKhoKhan.add(NamKhoKhanHtml.innerHtml.trim());
//       //   //print(NamKhoKhan[0]);
//       // }
//       // var GioXuatHanhHtml = boxTuViTronDoi[0].getElementsByTagName('p')[10];
//       // if (GioXuatHanhHtml != null) {
//       //   GioXuatHanh.add(GioXuatHanhHtml.innerHtml.trim());
//       //   //print(GioXuatHanh[0]);
//       // }
//       // var DienBienHtml = boxTuViTronDoi[0].getElementsByTagName('p')[11];
//       // if (DienBienHtml != null) {
//       //   DienBien.add(DienBienHtml.innerHtml.trim());
//       //   //print(DienBien[0]);
//       // }
//       // var TestHtml = boxTuViTronDoi[0].getElementsByTagName('p')[12];
//       // if (TestHtml != null) {
//       //   Test.add(TestHtml.innerHtml.trim());
//       //   //print(Test[0]);
//       // }
//       // var Test1Html = boxTuViTronDoi[0].getElementsByTagName('p')[13];
//       // if (Test1Html != null) {
//       //   Test1.add(Test1Html.innerHtml.trim());
//       //   //print(Test1[0]);
//       // }
//       // var Test2Html = boxTuViTronDoi[0].getElementsByTagName('p')[14];
//       // if (Test2Html != null) {
//       //   Test2.add(Test2Html.innerHtml.trim());
//       //   //print(Test2[0]);
//       // }
//       // var Test3Html = boxTuViTronDoi[0].getElementsByTagName('p')[15];
//       // if (Test3Html != null) {
//       //   Test3.add(Test3Html.innerHtml.trim());
//       //   //print(DienBien[0]);
//       // }
//       // var Test4Html = boxTuViTronDoi[0].getElementsByTagName('p')[16];
//       // if (Test4Html != null) {
//       //   Test4.add(Test4Html.innerHtml.trim());
//       //   //print(DienBien[0]);
//       // }
//       // var Test5Html = boxTuViTronDoi[0].getElementsByTagName('p')[17];
//       // if (Test5Html != null) {
//       //   Test5.add(Test5Html.innerHtml.trim());
//       //   //print(Test5[0]);
//       // }
//       // var Test6Html = boxTuViTronDoi[0].getElementsByTagName('p')[18];
//       // if (Test6Html != null) {
//       //   Test6.add(Test6Html.innerHtml.trim());
//       //   //print(Test[0]);
//       // }
//       // var Test7Html = boxTuViTronDoi[0].getElementsByTagName('p')[19];
//       // if (Test7Html != null) {
//       //   Test7.add(Test7Html.innerHtml.trim());
//       //   //print(Test7[0]);
//       // }
//       // var Test8Html = boxTuViTronDoi[0].getElementsByTagName('p')[20];
//       // if (Test8Html != null) {
//       //   Test8.add(Test8Html.innerHtml.trim());
//       //   //print(Test[0]);
//       // }
//       // var Test9Html = boxTuViTronDoi[0].getElementsByTagName('p')[21];
//       // if (Test9Html != null) {
//       //   Test9.add(Test9Html.innerHtml.trim());
//       //   //print(Test9[0]);
//       // }
//       // var Test10Html = boxTuViTronDoi[0].getElementsByTagName('p')[22];
//       // if (Test10Html != null) {
//       //   Test10.add(Test10Html.innerHtml.trim());
//       //   //print(Test[0]);
//       // }
//       // var Test11Html = boxTuViTronDoi[0].getElementsByTagName('p')[23];
//       // if (Test11Html != null) {
//       //   Test11.add(Test11Html.innerHtml.trim());
//       //   //print(Test[0]);
//       // }
//       // var Test12Html = boxTuViTronDoi[0].getElementsByTagName('p')[24];
//       // if (Test12Html != null) {
//       //   Test12.add(Test12Html.innerHtml.trim());
//       //   //print(Test[0]);
//       // }
//       // var Test13Html = boxTuViTronDoi[0].getElementsByTagName('p')[25];
//       // if (Test13Html != null) {
//       //   Test13.add(Test13Html.innerHtml.trim());
//       //   //print(Test[0]);
//       // }
//       // var Test14Html = boxTuViTronDoi[0].getElementsByTagName('p')[26];
//       // if (Test14Html != null) {
//       //   Test14.add(Test14Html.innerHtml.trim());
//       //   //print(Test14[0]);
//       // }
//     }

//     // if (kDebugMode) {
//     //   print('THANNNNNNNNNNNNNNNNNN');
//     // }

//     // resultsJson +=
//     //     ('''ItemModelTuViTronDoi(id: 0,image: 'assets/images/rong.png', tongquat: '${ThongTin[0]}',cuocsong: '${TinhDuyen[0]}', tinhduyen:'${GiaDao[0]}', giadao:'${TuoiHop[0]} ${TuoiKy[0]}', tuoihop: '${HonNhan[0]}',vochong:  '${Test[0]} ${Test1[0]} ${Test2[0]} ${Test3[0]} ${Test4[0]} ${Test5[0]} ${Test6[0]}', tuoiky: '${NamKhoKhan[0]} ${GioXuatHanh[0]} ${DienBien[0]}', namkhokhan:'${Test7[0]}', gioxuathanh:'${Test8[0]}',dientien:'${Test9[0]} ${Test10[0]} ${Test11[0]} ${Test12[0]} ${Test13[0]} ${Test14[0]}',check: 'Nam',),''');
//     if (kDebugMode) {
//       debugPrint(resultsJson, wrapWidth: 1050);
//     }
//     // for (int i = 0; i <40; i++) {
//     //   if (DapAn[i] == "A") {
//     //     resultsJson.add(
//     //         '{"id": "${i + 1}   ","a":"${a[i]}","trueAnswer": "${nam[i]}","falseAnswer1": "${ThongTin[i]}","falseAnwser2": "${ThoBinh[i]}","falseAnwer3": "${CuocSong[i]}"},');
//     //   } else if (DapAn[i] == "B") {
//     //     resultsJson.add(
//     //         '{"id": "${i + 1}","a":"${a[i]}","trueAnswer": "${ThongTin[i]}","falseAnswer1": "${nam[i]}","falseAnwser2": "${ThoBinh[i]}","falseAnwer3": "${CuocSong[i]}"},');
//     //   } else if (DapAn[i] == "C") {
//     //     resultsJson.add(
//     //         '{"id": "${i + 1}","a":"${a[i]}","trueAnswer": "${ThoBinh[i]}","falseAnswer1": "${nam[i]}","falseAnwser2": "${ThongTin[i]}","falseAnwer3": "${CuocSong[i]}"},');
//     //   } else if (DapAn[i] == "D") {
//     //     resultsJson.add(
//     //         '{"id": "${i + 1}","a":"${a[i]}","trueAnswer": "${CuocSong[i]}","falseAnswer1": "${nam[i]}","falseAnwser2": "${ThoBinh[i]}","falseAnwer3": "${ThongTin[i]}"},');
//     //   }
//     // }

//     return;
//     data.add(document.getElementsByClassName("chitiet_hd")[0].innerHtml);
//     //declaring variable for temp since we will be using it multiple places
//     var temp = document.getElementsByClassName("temp")[0];
//     data.add(temp.innerHtml.substring(0, temp.innerHtml.indexOf("<span>")));
//     data.add(temp
//         .getElementsByTagName("small")[0]
//         .innerHtml
//         .replaceAll(RegExp("[(|)|℃]"), ""));

//     //We can also do document.getElementsByTagName("td") but I am just being more specific here.
//     var rows =
//         document.getElementsByTagName("table")[0].getElementsByTagName("td");
// //Map elememt to its innerHtml,  because we gonna need it.
//     //Iterate over all the table-data and store it in the data list
//     rows.map((e) => e.innerHtml).forEach((element) {
//       if (element != "-") {
//         data.add(element);
//       }
//     });

//     //print the data to console.
//     // if (kDebugMode) {
//     //   print('_alexTR_logging_: data : $data');
//     // }
//   }
// }
