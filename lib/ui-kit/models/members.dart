class MemberModel {
  final String name;
  final String direction;
  final String phone;
  final String status;
  final String startDate;
  final String endDate;
  final String member;
  final String childrens;
  final String roomID;
  final String note;
  final String chekinDate;
  final String special;
  final String email;

  MemberModel( 
      {required this.name,
      required this.email,
      required this.direction,
      required this.phone,
      required this.status,
      required this.startDate,
      required this.endDate,
      required this.member,
      required this.childrens,
      required this.roomID,
      required this.note,
      required this.chekinDate,
      required this.special});
}
