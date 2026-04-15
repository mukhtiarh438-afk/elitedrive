class ShiftDayModel {
  final String day;   // MON, TUE etc
  final int date;
  final bool isSelected;

  ShiftDayModel({
    required this.day,
    required this.date,
    this.isSelected = false,
  });
}
