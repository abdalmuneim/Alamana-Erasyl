class FunHelper {
  static String removeFirstWord(String input) {
    List<String> words = input.split(' ');
    if (words.length > 1) {
      words.removeAt(0); // Remove the first word
    }
    return words.join(' ');
  }
}
