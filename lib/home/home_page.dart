import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/patient/patient.dart' as pt;
import 'package:me_maintanence/patient/patient_service.dart';
import 'package:me_maintanence/recommendations/preventative_care_item.dart';
import 'package:me_maintanence/recommendations/recommendation.dart';
import 'package:me_maintanence/recommendations/recommendation_service.dart';
import 'package:me_maintanence/recommendations/recommendations_context.dart';
import 'package:me_maintanence/reminders/reminder.dart';

class HomePage extends StatefulWidget {
  final pt.Patient patient;
  final PatientService patientService = MyPatientService();

  HomePage({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PatientService patientService = MyPatientService();
  final RecommendationService recommendationService = MyRecommendationService();
  late List<PreventativeCareItem> recommendedItems;
  late List<RecommendationsContext> recCtxList;
  late Map<int, ReminderItem> reminders;

  bool loading = true;

  Future _loadDetails() async {
    setState(() {
      loading = true;
    });
    recommendedItems = await recommendationService.getItems(widget.patient);
    if (recommendedItems.isNotEmpty) {
      setState(() {
        for (PreventativeCareItem item in recommendedItems) {
          RecommendationsContext rctx = RecommendationsContext();
          rctx.careItem = item;
          rctx.patient = widget.patient;
          recCtxList.add(rctx);
        }

        loading = false;
        print("set loading to false");
      });
    }
  }

  @override
  void initState() {
    print("called init state");
    super.initState();
    loading = true;
    _loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    print("Got patient ${widget.patient}");

    var patientName = patientService.getPatientName(widget.patient);
    print("loading is: ${this.loading}");
    if (loading) {
      print("screen is loading");
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      // once loading is complete !!!
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              "${patientName.given!.first}",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            elevation: 0.0,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Recommended Preventative Care",
                    style: TextStyle(
                        color: Colors.black, fontSize: 20 * textScale)),
              ),
              Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.all(25),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              childAspectRatio: 4,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (BuildContext ctx, index) {
                        print("Building index: $index");
                        //TODO maybe store these as in list so we can pass these as ref using index?
                        RecommendationsContext rctx = recCtxList[index];

                        return PreventativeCareListTile(rctx);
                      },
                      itemCount: recommendedItems.length)),
            ],
          ));
    }
  }
}
