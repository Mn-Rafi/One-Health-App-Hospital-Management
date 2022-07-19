import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:one_health_hospital_app/logic/models/prescriptions_response_model.dart';
import 'package:one_health_hospital_app/presentation/helpers/colors.dart';
import 'package:one_health_hospital_app/repositories/pdf_generator_services.dart';

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;
  final bool? width;
  const PrescriptionCard({
    Key? key,
    required this.prescription,
    this.width = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      // margin: const EdgeInsets.only(left: .0, bottom: 5.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          final pdfFile = await PdfApi().generatePdf(prescription);
          PdfApi.openFile(pdfFile);
        },
        child: SizedBox(
          width: !width! ? 250.0 : double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  width: 70.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kBlueColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12.0),
                      topLeft: Radius.circular(12.0),
                    ),
                  ),
                  child:
                      Icon(Icons.picture_as_pdf_rounded, color: Colors.white),
                ),
              ),
              Positioned(
                top: 30.0,
                left: 15.0,
                right: 18.0,
                bottom: 15.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Tap to download',
                        style: theme.textTheme.subtitle2!
                            .copyWith(color: kBlueColor)),
                    const SizedBox(height: 15.0),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 2.0,
                            color: kBlueColor,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. : ${prescription.doctor}',
                                  style: theme.textTheme.subtitle2!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(height: 5.0),
                              Text(
                                  'Reason : ${prescription.prescribedFor![0]},...',
                                  maxLines: !width! ? 1 : 3,
                                  // overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.subtitle2!
                                      .copyWith(color: Colors.black)),
                              const SizedBox(height: 5.0),
                              Text('Date : ${prescription.date} ',
                                  style: theme.textTheme.subtitle2!.copyWith(
                                      color: Colors.blueGrey, fontSize: 15)),
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
