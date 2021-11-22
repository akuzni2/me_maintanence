import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/recommendations/preventative_care_info_sub_screen.dart';
import 'package:me_maintanence/recommendations/recommendation.dart';
import 'package:me_maintanence/widgets/transparent_app_bar.dart';

class PreventativeCareScreen extends StatefulWidget {
  final PreventativeCareItem careItem;

  const PreventativeCareScreen({Key? key, required this.careItem})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PreventativeCareScreenState();
}

class _PreventativeCareScreenState extends State<PreventativeCareScreen> {
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    // return Scaffold(
    //     appBar: TransparentAppBar(),
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black45),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info_outline), text: "Info"),
              Tab(icon: Icon(Icons.timer_outlined), text: "Reminder"),
              Tab(icon: Icon(Icons.location_on_outlined), text: "Nearby"),
            ],
          ),
          title: Text(
            widget.careItem.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: [
            PreventativeCareInfoScreen(
              careItem: widget.careItem,
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
