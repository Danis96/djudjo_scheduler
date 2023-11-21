extension StringAdditions on String {
  String returnSplittedTime() {
    return split('(')[1].split(')')[0];
  }
}
