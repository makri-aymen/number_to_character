library number_to_text_converter;
import 'dart:developer';

import 'SegmentModel.dart';
import 'number_mappings.dart';


late NumberSplitter _numberSplitter;
NumberMappings _numberMappings = NumberMappings("en");
late String langu;
class NumberToCharacterConverter {

  //NumberToCharacterConverter.init(String lang) : this._numberSplitter = InternationalNumberingSystemNumberSplitter();
  NumberToCharacterConverter(String lang){
    _numberSplitter = InternationalNumberingSystemNumberSplitter();
    _numberMappings = NumberMappings(lang);
    langu=lang;
  }

  String convertInt(int?  number) {
    if (number == null) return '';

    return getTextForNumber(number);
  }


  String convertDouble(double? number) {
    if (number == null) return '' ;

    int firstNumber = int.parse(number.toString().split('.')[0]);

    int secondNumber = int.parse(number.toString().split('.')[1]);
    String numberInCharecters;

    numberInCharecters = getTextForNumber(firstNumber);
    numberInCharecters += (secondNumber==0? "":" ${_numberMappings.mappings[999999999]} ${getTextForNumber(secondNumber)}" );

    return numberInCharecters;
  }


  String getTextForNumber(int number) {
    var segments = _numberSplitter.splitNumber(number);
    var text = '';

    for (int i = 0; i < segments.length; i++) {
      var part = segments[i];
      var partString = getTextForNumberLessThan1000(part.number);
      var shouldAddSpace = text.isNotEmpty && partString.isNotEmpty;

      if (shouldAddSpace) text += ' ';
      text += partString + part.magnitude;
    }

    return text;
  }



  String getTextForNumberLessThan1000(int number) {
    if (number > 999) return '';

    var lastTwoDigits = (number % 100).toInt();
    var lastTwoDigitsText = getTextForNumberLessThan100(lastTwoDigits);
    var digitAtHundredsPlace = number ~/ 100;
    var hundredsPlaceText = getMappingForNumber(digitAtHundredsPlace);
    if (hundredsPlaceText.isNotEmpty){
      String aa=' ${_numberMappings.mappings[100]}' ; //hundred
      hundredsPlaceText += aa;
    }
    if (hundredsPlaceText.isNotEmpty && lastTwoDigitsText.isNotEmpty){
      String aa=' ${_numberMappings.mappings[0]} ' ;  //and
      hundredsPlaceText += aa;
    }

    return hundredsPlaceText + lastTwoDigitsText;
  }






  String getTextForNumberLessThan100(int number) {
    if (number > 99) return '';
    //print( '/////////////////////////////${getMappingForNumber(number).isNotEmpty}/////////////////');
    if (getMappingForNumber(number).isNotEmpty)
      return getMappingForNumber(number);
    // if (number < 10)
    //   return getMappingForNumber(number);

    var onesPlace = (number % 10).toInt();
    var onesPlaceText = getMappingForNumber(onesPlace);

    var tensPlace = ((number - onesPlace) % 100).toInt();
    var tensPlaceText = getMappingForNumber(tensPlace);
    if (onesPlaceText.isNotEmpty) tensPlaceText += ' ';

    if(langu =='ar'){
      return onesPlaceText +" "+_numberMappings.mappings[0].toString()+" "+ tensPlaceText ;
    }

    return tensPlaceText + onesPlaceText ;
  }





  String getMappingForNumber(int number) {
    if (number == 0 || !_numberMappings.mappings.containsKey(number)) return '';
    return _numberMappings.mappings[number];
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




// interface of splitter
abstract class NumberSplitter {
  List<SegmentModel> splitNumber(int number);
}

//there is another splits like indian numbers or old arabic numbers
class InternationalNumberingSystemNumberSplitter extends NumberSplitter {
  @override
  List<SegmentModel> splitNumber(int number) {
    var separatedNumbersList = number.toString().split("");
    List<SegmentModel> segments = [];
    var numberString = '';
    for ( int i = separatedNumbersList.length - 1 ; i >= 0 ; i-- ) {
      numberString = separatedNumbersList[i] + numberString;
      if (numberString.length == 3 || i == 0) {
        var segment = _getSegmentForNumber( numberString ,  segments.length );
        segments.insert( 0 , segment );
        numberString = '';
      }
    }
    return segments.toList();
  }

  SegmentModel _getSegmentForNumber(String numberString, int noOfExistingSegments) {
    var number = int.parse(numberString);
    var magnitude = _getOrderOfMagnitudeOfSegment(number, noOfExistingSegments);
    //print("-----------------------------------------------------"+magnitude.toString());
    return SegmentModel(number, magnitude);
  }

  String _getOrderOfMagnitudeOfSegment(int segment, int? indexOfSegment) {
    var magnitude = '';

    if( indexOfSegment != null) {
      if (segment != 0 && indexOfSegment % 6 == 1)
        magnitude = ' ' + _numberMappings.mappings[1000]; //thousand
      if (segment != 0 && indexOfSegment % 6 == 2)
        magnitude = ' ' + _numberMappings.mappings[10000]; //million
      if (segment != 0 && indexOfSegment % 6 == 3)
        magnitude = ' ' + _numberMappings.mappings[100000]; //billion
      if (segment != 0 && indexOfSegment % 6 == 4)
        magnitude = ' ' + _numberMappings.mappings[1000000]; //trillion
      if (segment != 0 && indexOfSegment % 6 == 5)
        magnitude = ' ' + _numberMappings.mappings[10000000]; //quadrillion

      if (indexOfSegment > 0 && indexOfSegment % 6 == 0)
        magnitude = ' ' +
            _numberMappings.mappings.containsKey(100000000); //quintrillion
    }
    return magnitude;
  }
}
