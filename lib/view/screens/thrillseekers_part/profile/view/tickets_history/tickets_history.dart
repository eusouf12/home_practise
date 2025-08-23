import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../widget/custom_ticket_history/custom_ticket_history.dart';

class TicketsHistory extends StatefulWidget {
  const TicketsHistory({super.key});

  @override
  State<TicketsHistory> createState() => _TicketsHistoryState();
}

class _TicketsHistoryState extends State<TicketsHistory> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: 'Tickets History'),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children:List.generate(2,(index){
              return Column(
                children: [
                  CustomTicketHistory(
                    price:"\$26",
                    totalPrice:"\$26" ,
                  ),
                  SizedBox(height: 16,),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
