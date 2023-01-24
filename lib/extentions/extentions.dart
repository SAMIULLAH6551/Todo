import 'package:intl/intl.dart';

extension DATEFORMAT on DateTime{

  String customDate(){
    return DateFormat('dd/MM/yyyy').format(this);
  }
}


extension NameFormat on String{
  String firstLetterCapital(){
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}


extension TimeFormat on DateTime{
  String customTime(){
    return DateFormat.Hm().format(this);
  }
}
