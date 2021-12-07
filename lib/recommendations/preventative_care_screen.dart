import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/recommendations/recommendations_context.dart';
import 'package:me_maintanence/recommendations/subscreen/info_screen.dart';
import 'package:me_maintanence/recommendations/subscreen/reminder_screen.dart';

class PreventativeCareScreen extends StatefulWidget {
  final RecommendationsContext rctx;

  const PreventativeCareScreen({Key? key, required this.rctx})
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
              Tab(icon: Icon(Icons.location_on_outlined), text: "Nearby"), // TODO figure out how to remove this
            ],
          ),
          title: Text(
            widget.rctx.careItem.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: [
            PreventativeCareInfoScreen(
              careItem: widget.rctx.careItem,
            ),
            ReminderScreen(
              rctx: widget.rctx,
            ),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
