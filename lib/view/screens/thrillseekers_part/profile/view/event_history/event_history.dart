import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../widget/custom_event_history_card/custom_event_history_card.dart';

class EventHistory extends StatefulWidget {
  const EventHistory({super.key});

  @override
  State<EventHistory> createState() => _EventHistoryState();
}

class _EventHistoryState extends State<EventHistory> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: 'Event History'),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Column(
                children:List.generate(2,(index){
                  return Column(
                    children: [
                      CustomEventHistoryCard(
                           inPerson: true,
                        iscompleted: true,
                      ),
                      SizedBox(height: 16,),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}