String weekDayToString(int dateNum) {
  if (dateNum == 1) {
    return "월요일";
  }
  if (dateNum == 2) {
    return "화요일";
  }
  if (dateNum == 3) {
    return "수요일";
  }
  if (dateNum == 4) {
    return "목요일";
  }
  if (dateNum == 5) {
    return "금요일";
  }
  if (dateNum == 6) {
    return "토요일";
  }

  return "일요일";
}