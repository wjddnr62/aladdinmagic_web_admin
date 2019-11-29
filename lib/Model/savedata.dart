class SaveData {
  static final SaveData _saveData = SaveData._internal();

  factory SaveData() {
    return _saveData;
  }

  SaveData._internal();

  String _id;
  String _manager;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get manager => _manager;

  set manager(String value) {
    _manager = value;
  }


}