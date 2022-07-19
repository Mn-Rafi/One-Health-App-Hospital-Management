import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_health_hospital_app/logic/models/prescriptions_response_model.dart';
import 'package:one_health_hospital_app/presentation/helpers/colors.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
  static List<UserLocalData> userLocalDataList = userLocalData.values.toList();
  Future<File> generatePdf(Prescription prescription) async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
          build: (context) =>
              [buildTitle(prescription), buildMedicineList(prescription)]),
    );
    return saveDocument(name: 'prescription.pdf', pdf: pdf);
  }

  static Future<File> showBlooadTypePdf() {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
          build: (context) => [buildTitleForBloodType(), buildBloodTypeList()]),
    );
    return saveDocument(name: 'prescription.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Widget buildTitle(Prescription prescription) => Column(children: [
        Text('ONE HEALTH HOSPITAL',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 2 * PdfPageFormat.cm),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Prescribed for : ${prescription.user!}',
              style: TextStyle(
                fontSize: 14,
              )),
          Text('Age : ${userLocalDataList[0].age}',
              style: TextStyle(
                fontSize: 14,
              )),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Prescribed by : ${prescription.doctor!}',
              style: TextStyle(
                fontSize: 14,
              )),
          Text('Date : ${prescription.date}',
              style: TextStyle(
                fontSize: 14,
              )),
        ]),
        SizedBox(height: 1.5 * PdfPageFormat.cm),
      ]);

  static Widget buildTitleForBloodType() => Column(children: [
        Text('ONE HEALTH HOSPITAL',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 2 * PdfPageFormat.cm),
        Text('BLOOD TYPE COMPATIBILITY LIST',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 1.5 * PdfPageFormat.cm),
      ]);

  static Widget buildMedicineList(Prescription prescription) {
    final header = ['Medicine', 'Prescribed for', 'Dosage'];
    final data =
        List<List<String>>.generate(prescription.medicine!.length, (index) {
      return [
        prescription.medicine![index].toString(),
        prescription.prescribedFor![index].toString(),
        prescription.dosage![index].toString(),
      ];
    }, growable: false);
    return Table.fromTextArray(
        cellAlignment: Alignment.center,
        headers: header,
        headerAlignment: Alignment.center,
        data: data,
        border: TableBorder.all(
          color: PdfColors.grey300,
          width: 1,
        ),
        headerStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        cellStyle: TextStyle(
          fontSize: 14,
        ),
        headerDecoration: BoxDecoration(color: PdfColors.grey300));
  }

  static Widget buildBloodTypeList() {
    final header = ['Blood Type', 'Gives', 'Recieves'];

    return Table.fromTextArray(
        cellAlignment: Alignment.center,
        headers: header,
        headerAlignment: Alignment.center,
        data: bloodTableData,
        border: TableBorder.all(
          color: PdfColors.grey300,
          width: 1,
        ),
        headerStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        cellStyle: const TextStyle(
          fontSize: 14,
        ),
        headerDecoration: BoxDecoration(color: PdfColors.grey300));
  }
}

List<List<String>> bloodTableData = [
  ['A +ve', 'A +ve, AB +ve', 'A +ve, A -ve, O +ve, O -ve'],
  ['A -ve', 'A +ve, A -ve, AB +ve, AB -ve', 'A -ve, O -ve'],
  ['B +ve', 'B +ve, AB +ve', 'B +ve, B -ve, O +ve, O -ve'],
  ['B -ve', 'B +ve, B -ve, AB +ve, AB -ve', 'B -ve, O -ve'],
  ['AB +ve', 'AB +ve', 'Everyone'],
  ['AB -ve', 'AB -ve, AB +ve', 'AB -ve, A -ve, B -ve, O -ve'],
  ['O +ve', 'O +ve, A +ve, B +ve, AB +ve', 'O +ve, O -ve'],
  ['O -ve', 'Everyone', 'O -ve'],
];
