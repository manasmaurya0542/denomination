import 'package:number_to_words_english/number_to_words_english.dart';

String? numbersToWords(double number){
  return NumberToWordsEnglish.convert(number.toInt()).toUpperCase();
}
