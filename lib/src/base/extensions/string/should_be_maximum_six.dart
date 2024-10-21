extension ShouldBeMaximumSix on String {
  String shouldBeMaximumChar([int char = 12]) {
    if (length > char) {
      final List<String> maxiChar = split('');

      String selectedStr = '';
      for (int i = 0; i <= char; i++) {
        if (i < 6) {
          selectedStr += maxiChar[i];
        } else {
          if (i == 6) {
            selectedStr += '\n';
          }

          if (i == 6 && maxiChar[i] == ' ') {
            continue;
          }

          selectedStr += maxiChar[i];
        }
      }

      return selectedStr;
    } else {
      final List<String> allStr = split('');
      String secondStr = '';
      for (int i = 0; i < allStr.length; i++) {
        if (allStr.length < 7) {
          secondStr += allStr[i];
        } else {
          if (i == 6) {
            secondStr += '\n';
          }
          secondStr += allStr[i];
        }
      }
      return secondStr;
    }
  }
}
