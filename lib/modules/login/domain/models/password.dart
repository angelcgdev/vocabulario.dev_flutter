class Password {
  final String value;
  const Password(this.value);
  static const pure = Password('');
  
  String validator(){
    if(value.isEmpty){
      return 'empty';
    }
    if(value.length<6){
      return 'too short';
    }
    return '';
  }
}