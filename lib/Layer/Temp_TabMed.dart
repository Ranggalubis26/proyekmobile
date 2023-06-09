import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/DarkModeProvider.dart';

class MyTabMed extends StatefulWidget {
  final Map<String, dynamic> pasienData;
  const MyTabMed({Key? key, required this.pasienData}) : super(key: key);

  @override
  State<MyTabMed> createState() => _MyTabMedState();
}

class _MyTabMedState extends State<MyTabMed> {
  TextEditingController anamnesaController = TextEditingController();
  TextEditingController diagnosaController = TextEditingController();
  TextEditingController therapyController = TextEditingController();

  bool isEditingAnamnesa = false;
  bool isEditingDiagnosa = false;
  bool isEditingTherapy = false;

  String editedAnamnesaText = "";
  String editedDiagnosaText = "";
  String editedTherapyText = "";

  int editedRecordIndex = -1;

  @override
  void dispose() {
    anamnesaController.dispose();
    diagnosaController.dispose();
    therapyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
      builder: (context, darkModeProvider, _) {
        bool isDarkMode = darkModeProvider.isDarkMode;

        Color containerColor = isDarkMode ? Colors.black : Colors.white;
        Color textColor = isDarkMode ? Colors.white : Colors.black;
        Color textFieldColor =
            isDarkMode ? Colors.grey[900]! : Color.fromRGBO(0, 154, 205, 100);
        Color? snackBarColor =
            isDarkMode ? Color.fromRGBO(127, 218, 244, 100) : Colors.grey[800]!;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.pasienData['Mrecord']!.length,
              itemBuilder: (context, index) {
                List<Map<String, dynamic>> record =
                    widget.pasienData["Mrecord"] as List<Map<String, dynamic>>;
                Map<String, dynamic> currentRecord = record[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: containerColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: Text(
                                      "Tanggal Masuk\n${currentRecord['TanggalBerkunjung']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: textColor),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 1.0),
                                    child: Container(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            if (editedRecordIndex == index) {
                                              // Save the changes
                                              if (isEditingAnamnesa) {
                                                if (editedAnamnesaText
                                                        .isNotEmpty &&
                                                    editedAnamnesaText !=
                                                        currentRecord[
                                                            'Anamnesa']) {
                                                  currentRecord['Anamnesa'] =
                                                      editedAnamnesaText;
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      'Anamnesa pasien telah diubah!',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    backgroundColor:
                                                        snackBarColor,
                                                  ));
                                                }
                                                editedAnamnesaText = "";
                                              }
                                              if (isEditingDiagnosa) {
                                                if (editedDiagnosaText
                                                        .isNotEmpty &&
                                                    editedDiagnosaText !=
                                                        currentRecord[
                                                            'Diagnosa']) {
                                                  currentRecord['Diagnosa'] =
                                                      editedDiagnosaText;
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      'Diagnosa pasien telah diubah!',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    backgroundColor:
                                                        snackBarColor,
                                                  ));
                                                }
                                                editedDiagnosaText = "";
                                              }
                                              if (isEditingTherapy) {
                                                if (editedTherapyText
                                                        .isNotEmpty &&
                                                    editedTherapyText !=
                                                        currentRecord[
                                                            'Therapy']) {
                                                  currentRecord['Therapy'] =
                                                      editedTherapyText;
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      'Therapy Pasien telah diubah!',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    backgroundColor:
                                                        snackBarColor,
                                                  ));
                                                }
                                                editedTherapyText = "";
                                              }

                                              editedRecordIndex =
                                                  -1; // Menghentikan mode edit
                                            } else {
                                              // Start editing this row
                                              editedRecordIndex = index;
                                              editedAnamnesaText =
                                                  currentRecord['Anamnesa'] ??
                                                      '';
                                              editedDiagnosaText =
                                                  currentRecord['Diagnosa'] ??
                                                      '';
                                              editedTherapyText =
                                                  currentRecord['Therapy'] ??
                                                      '';
                                            }

                                            isEditingAnamnesa =
                                                editedRecordIndex == index;
                                            isEditingDiagnosa =
                                                editedRecordIndex == index;
                                            isEditingTherapy =
                                                editedRecordIndex == index;
                                          });
                                        },
                                        child: Text(
                                          editedRecordIndex == index
                                              ? "Save"
                                              : "Edit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: textColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 330,
                                      decoration:
                                          BoxDecoration(color: textFieldColor),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 8, 16),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: Row(
                                                children: [
                                                  Text("Anamnesa / Cek Fisik",
                                                      style: TextStyle(
                                                          color: textColor)),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: isEditingAnamnesa &&
                                                          editedRecordIndex ==
                                                              index
                                                      ? TextField(
                                                          controller:
                                                              anamnesaController,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              editedAnamnesaText =
                                                                  value;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            fillColor:
                                                                textFieldColor,
                                                            filled: true,
                                                          ),
                                                          style: TextStyle(
                                                              color: textColor),
                                                        )
                                                      : Text(
                                                          isEditingAnamnesa &&
                                                                  editedRecordIndex ==
                                                                      index
                                                              ? editedAnamnesaText
                                                                      .isNotEmpty
                                                                  ? editedAnamnesaText
                                                                  : currentRecord[
                                                                          'Anamnesa'] ??
                                                                      ''
                                                              : currentRecord[
                                                                      'Anamnesa'] ??
                                                                  '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: textColor),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: Container(
                                        width: 330,
                                        decoration: BoxDecoration(
                                            color: textFieldColor),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 8, 16),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Text("Diagnosa",
                                                        style: TextStyle(
                                                            color: textColor)),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: isEditingDiagnosa &&
                                                            editedRecordIndex ==
                                                                index
                                                        ? TextField(
                                                            controller:
                                                                diagnosaController,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                editedDiagnosaText =
                                                                    value;
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              fillColor:
                                                                  textFieldColor,
                                                              filled: true,
                                                            ),
                                                            style: TextStyle(
                                                                color:
                                                                    textColor),
                                                          )
                                                        : Text(
                                                            isEditingDiagnosa &&
                                                                    editedRecordIndex ==
                                                                        index
                                                                ? editedDiagnosaText
                                                                        .isNotEmpty
                                                                    ? editedDiagnosaText
                                                                    : currentRecord[
                                                                            'Diagnosa'] ??
                                                                        ''
                                                                : currentRecord[
                                                                        'Diagnosa'] ??
                                                                    '',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    textColor),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: Container(
                                        width: 330,
                                        decoration: BoxDecoration(
                                            color: textFieldColor),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 8, 16),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Text("Therapy",
                                                        style: TextStyle(
                                                            color: textColor)),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: isEditingTherapy &&
                                                            editedRecordIndex ==
                                                                index
                                                        ? TextField(
                                                            controller:
                                                                therapyController,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                editedTherapyText =
                                                                    value;
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              fillColor:
                                                                  textFieldColor,
                                                              filled: true,
                                                            ),
                                                            style: TextStyle(
                                                                color:
                                                                    textColor),
                                                          )
                                                        : Text(
                                                            isEditingTherapy &&
                                                                    editedRecordIndex ==
                                                                        index
                                                                ? editedTherapyText
                                                                        .isNotEmpty
                                                                    ? editedTherapyText
                                                                    : currentRecord[
                                                                            'Therapy'] ??
                                                                        ''
                                                                : currentRecord[
                                                                        'Therapy'] ??
                                                                    '',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    textColor),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
            ),
          ),
        );
      },
    );
  }
}
