class TagDataModel{
  dynamic signature;
  dynamic initials;
  dynamic image;
  bool checkBox;
  String signerName;
  String signerText;
  String signerTitle;
  String customText;
  String customTextArea;
  String reasonSelected;
  String calendar;
  List<String> reasonList;
  String userUUID;


  TagDataModel({
      this.signature,
      this.initials,
      this.image,
      this.checkBox,
      this.signerName,
      this.signerText,
      this.signerTitle,
      this.customText,
      this.customTextArea,
      this.reasonSelected,
      this.calendar,
      this.reasonList,
      this.userUUID});


}