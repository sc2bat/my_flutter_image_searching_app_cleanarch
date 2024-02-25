String dumpLoadingImage({required int width, required int height}) {
  return 'https://place-hold.it/${width}x$height/666/fff/000?text=none&fontsize=40';
}

String getTimeDifference(String dateTimeString) {
  DateTime parsedDateTime = DateTime.parse(dateTimeString);
  DateTime now = DateTime.now();
  Duration difference = now.difference(parsedDateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} 초 전';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} 분 전';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} 시간 전';
  } else if (difference.inDays < 30) {
    return '${difference.inDays} 일 전';
  } else if (difference.inDays < 365) {
    int months = now.month -
        parsedDateTime.month +
        (12 * (now.year - parsedDateTime.year));
    return '$months 개월 전';
  } else {
    int years = now.year - parsedDateTime.year;
    return '$years 년 전';
  }
}
