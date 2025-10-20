import 'dart:convert';

String GenerateQr({
  required String ticketId,
  required String eventTitle,
  required String date,
  required String start,
  required String end,
  required String location,
  required String buyerName,
  required String email,
  required num price,
  required num totalTicket,
}) {
  final payloadMap = {
    "ticketId": ticketId,
    "eventTitle": eventTitle,
    "date": date,
    "start": start,
    "end": end,
    "location": location,
    "buyerName": buyerName,
    "email": email,
    "price": price,
    "totalTicket": totalTicket,
    "issuedAt": DateTime.now().toUtc().toIso8601String(),
  };

  return jsonEncode(payloadMap);
}
