class TContact {
  int? _id;
  String? _number;
  String? _name;

  TContact(this._number, this._name);
  TContact.withId(this._id, this._number, this._name);

  //getters
  int get id => _id!;
  String get number => _number!;
  String get name => _name!;

  @override
  String toString() {
    return 'Contact: {id: $_id, name: $_name, number: $_number}';
  }

  //setters
  // ignore: unnecessary_this
  set number(String newNumber) => this._number = newNumber;
  set name(String newName) => _name = newName;

  //convert a Contact object to a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = _id;
    map['number'] = _number;
    map['name'] = _name;

    return map;
  }

  //Extract a Contact Object from a Map object
  TContact.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _number = map['number'];
    _name = map['name'];
  }
}
