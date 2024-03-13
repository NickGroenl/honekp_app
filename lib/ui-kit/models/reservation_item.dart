import 'package:newhonekapp/app/models/bookings/members.dart';

class ReservationModel {
  final String title;
  final String date;
  final String ipcamera;
  final String price;
  final String nights;
  final String email;
  final List<MemberModell> members;
  final int author;
  final bool archivate;
  final int id;
  final int index;
  final String checkinstate;
  ReservationModel(
      {
      required this.id,
      required this.index,
      required this.email,
      required this.nights,
      required this.title,
      required this.date,
      required this.ipcamera,
      required this.price,
      required this.members,
      required this.author,
      required this.archivate,
      required this.checkinstate});
}