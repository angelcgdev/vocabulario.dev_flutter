class Email {
  final String value;
  const Email(this.value);
  static const pure = Email('');
  String validator(){
    if(value.isEmpty){
      return 'empty';
    }
    if(value.length<5){
      return 'too short';
    }
    return '';
  }
}