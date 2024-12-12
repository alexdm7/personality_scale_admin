import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SurveyResultsScreen extends StatelessWidget {
  var surveyDocs = <DocumentSnapshot>[];
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تأكيد الخروج'),
        content: Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // إغلاق نافذة التأكيد
            },
            child: Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // تسجيل الخروج
              Navigator.of(context).pop(); // إغلاق نافذة التأكيد
              Navigator.of(context).pushReplacementNamed(
                  '/login'); // التوجيه إلى شاشة تسجيل الدخول
            },
            child: Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  Future<void> createExcelFile(List<DocumentSnapshot> surveyDocs) async {
    try {
      CellStyle cellStyle = CellStyle( fontFamily :getFontFamily(FontFamily.David),
          backgroundColorHex: ExcelColor.fromHexString('#faf487'));

      cellStyle.underline = Underline.Single;

      var excel = Excel.createExcel();
      var sheet = excel['Sheet1'];
      var headerCell = sheet.cell(CellIndex.indexByString('A1'));
      var headerCell2 = sheet.cell(CellIndex.indexByString('B1'));
      var headerCell3 = sheet.cell(CellIndex.indexByString('C1'));
      var headerCell4 = sheet.cell(CellIndex.indexByString('D1'));
      var headerCell5 = sheet.cell(CellIndex.indexByString('E1'));
      headerCell.value = null;
      headerCell2.value = null;
      headerCell3.value = null;
      headerCell4.value = null; // removing any value
      headerCell.value = TextCellValue('المستخدم');
      headerCell2.value = TextCellValue('العمر');
      headerCell3.value = TextCellValue('أقرب نمط');
      headerCell4.value = TextCellValue('الدرجات');
      headerCell5.value = TextCellValue('أسئلة الحاسمة');
      headerCell.cellStyle;
      headerCell.cellStyle = (headerCell.cellStyle ?? CellStyle()).copyWith(


      );

//
      int rowIndex = 2;
      for (var doc in surveyDocs) {
        var username = doc['username'] ?? 'مستخدم غير معروف';
        var age = doc['age'] ?? 'العمر غير معروف';
        var closestPattern = doc['closest_pattern'] ?? 'لا يوجد نمط';
        var responses = _sortedData(doc, 'responses');
        var critical = _sortedData(doc, 'critical_question_scores');
        var headerCell = sheet.cell(CellIndex.indexByString('A$rowIndex'));
        var headerCell2 = sheet.cell(CellIndex.indexByString('B$rowIndex'));
        var headerCell3 = sheet.cell(CellIndex.indexByString('C$rowIndex'));
        var headerCell4 = sheet.cell(CellIndex.indexByString('D$rowIndex'));
        var headerCell5 = sheet.cell(CellIndex.indexByString('E$rowIndex'));
        headerCell.value = TextCellValue(username);
        headerCell2.value = TextCellValue(age);
        headerCell3.value = TextCellValue(closestPattern);
        headerCell4.value = TextCellValue(_buildDataColumnString(responses));
        headerCell5.value = TextCellValue(_buildDataColumnString(critical));



        rowIndex++;
      }

      final path = (await getApplicationDocumentsDirectory()).path;
      final fileName = '$path/SurveyResults2.xlsx';
      final file = File(fileName);
      await file.writeAsBytes(excel.encode()!);
      await OpenFile.open(fileName);
    } catch (e) {
      print("Error while creating Excel file: $e");
    }
  }
  Future<void> createExcelFile2(List<DocumentSnapshot> surveyDocs) async {
    try {
      CellStyle cellStyle = CellStyle( fontFamily :getFontFamily(FontFamily.David),
          backgroundColorHex: ExcelColor.fromHexString('#faf487'));

      cellStyle.underline = Underline.Single;

      var excel = Excel.createExcel();
      var sheet = excel['Sheet2'];
      var headerCell = sheet.cell(CellIndex.indexByString('A1'));
      var headerCell2 = sheet.cell(CellIndex.indexByString('B1'));
      var headerCell3 = sheet.cell(CellIndex.indexByString('C1'));
      var headerCell4 = sheet.cell(CellIndex.indexByString('D1'));
      var headerCell5 = sheet.cell(CellIndex.indexByString('E1'));
      headerCell.value = null;
      headerCell2.value = null;
      headerCell3.value = null;
      headerCell4.value = null; // removing any value
      headerCell.value = TextCellValue('المستخدم');
      headerCell2.value = TextCellValue('العمر');
      headerCell3.value = TextCellValue('أقرب نمط');
      headerCell4.value = TextCellValue('الدرجات');
      headerCell5.value = TextCellValue('أسئلة الحاسمة');
      headerCell.cellStyle;
      headerCell.cellStyle = (headerCell.cellStyle ?? CellStyle()).copyWith(


      );

//
      int rowIndex = 2;
      for (var doc in surveyDocs) {
        var username = doc['username'] ?? 'مستخدم غير معروف';
        var age = doc['age'] ?? 'العمر غير معروف';
        var closestPattern = doc['closest_pattern'] ?? 'لا يوجد نمط';
        var responses = _sortedData(doc, 'responses');
        var critical = _sortedData(doc, 'critical_question_scores');
        var headerCell = sheet.cell(CellIndex.indexByString('A$rowIndex'));
        var headerCell2 = sheet.cell(CellIndex.indexByString('B$rowIndex'));
        var headerCell3 = sheet.cell(CellIndex.indexByString('C$rowIndex'));
        var headerCell4 = sheet.cell(CellIndex.indexByString('D$rowIndex'));
        var headerCell5 = sheet.cell(CellIndex.indexByString('E$rowIndex'));
        headerCell.value = TextCellValue(username);
        headerCell2.value = TextCellValue(age);
        headerCell3.value = TextCellValue(closestPattern);
        headerCell4.value = TextCellValue(_buildDataColumnString2(responses));
        headerCell5.value = TextCellValue(_buildDataColumnString2(critical));



        rowIndex++;
      }

      final path = (await getApplicationDocumentsDirectory()).path;
      final fileName = '$path/SurveyResults2.xlsx';
      final file = File(fileName);
      await file.writeAsBytes(excel.encode()!);
      await OpenFile.open(fileName);
    } catch (e) {
      print("Error while creating Excel file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عرض النتائج'),
        actions: [
          Text('طريقة الاولى'),
          IconButton(
            onPressed: () {
              createExcelFile(surveyDocs);
            },
            icon: const Icon(Icons.download),
          ),
          Text('طريقة ثانيه'),
          IconButton(
            onPressed: () {
              createExcelFile2(surveyDocs);
            },
            icon: const Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {
              _showLogoutConfirmationDialog(context); // استدعاء نافذة التأكيد
            },
            icon: const Icon(Icons.exit_to_app),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('survey_results').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> surveySnapshot) {
          if (surveySnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (surveySnapshot.hasError) {
            return Center(child: Text('حدث خطأ أثناء تحميل البيانات.'));
          }
          if (!surveySnapshot.hasData || surveySnapshot.data!.docs.isEmpty) {
            return Center(child: Text('لا توجد نتائج متاحة.'));
          }

          surveyDocs = surveySnapshot.data!.docs;

          return InteractiveViewer(
            constrained: false,
            minScale: 0.5,
            maxScale: 2.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('المستخدم')),
                    DataColumn(label: Text('العمر')),
                    DataColumn(label: Text('أقرب نمط')),
                    DataColumn(label: Text('الدرجات')),
                    DataColumn(label: Text('أسئلة الحاسمة')),
                  ],
                  rows: surveyDocs.map((doc) {
                    final responses = _sortedData(doc, 'responses');
                    final critical = _sortedData(doc, 'critical_question_scores');

                    return DataRow(
                      cells: [
                        DataCell(Text(doc['username'] ?? 'مستخدم غير معروف')),
                        DataCell(Text(doc['age'] ?? 'غير معروف')),
                        DataCell(Text(doc['closest_pattern'] ?? 'لا يوجد نمط')),
                        DataCell(_buildDataColumn(responses)),
                        DataCell(_buildDataColumn(critical)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _sortedData(DocumentSnapshot doc, String field) {
    final data = List<Map<String, dynamic>>.from(doc[field] as List<dynamic>);
    data.sort((a, b) => (a['code'] ?? '').compareTo(b['code'] ?? ''));
    return data;
  }

  Widget _buildDataColumn(List<Map<String, dynamic>> data) {
    return Row(
      children: data.map<Widget>((entry) {
        final patternName = entry['code'] ?? 'نمط غير معروف';
        final score = entry['answer_score'] ?? 0;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Text(patternName, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(score.toString()),
            ],
          ),
        );
      }).toList(),
    );
  }
}
String _buildDataColumnString(List<Map<String, dynamic>> data) {
  return data.map((entry) {
    final patternName = entry['code'] ?? 'نمط غير معروف';
    final score = entry['answer_score'] ?? 0;
    return '$patternName: $score';
  }).join(', ');
}
String _buildDataColumnString2(List<Map<String, dynamic>> data) {
  return data.map((entry) {
    final patternName = entry['code'] ?? 'نمط غير معروف';
    final score = entry['answer_score'] ?? 0;
    return '$patternName: $score';
  }).join('\n');
}
