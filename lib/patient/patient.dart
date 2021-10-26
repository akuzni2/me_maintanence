/// resourceType : "Patient"
/// id : "618773"
/// meta : {"versionId":"2","lastUpdated":"2020-02-08T19:46:57.711+00:00","source":"#LCEWjZgz6U20QxrP"}
/// text : {"status":"generated","div":"<div xmlns=\"http://www.w3.org/1999/xhtml\"> <div class=\"hapiHeaderText\">Nombre1 Nombre2 <b>APELLIDOS </b> </div> <table class=\"hapiPropertyTable\"> <tbody> <tr> <td>Identifier</td> <td>123456184</td> </tr> <tr> <td>Date of birth</td> <td> <span>13 August 1975</span> </td> </tr> </tbody> </table> </div>"}
/// identifier : [{"system":"CIP","value":"ARMA0660725000"},{"system":"SNS","value":"12085455050"},{"system":"DNI","value":"46845992A"}]
/// name : [{"family":"Apellidos","given":["Nombre1","Nombre2"]}]
/// gender : "male"
/// birthDate : "1975-08-13"

class Patient {
  Patient({
      String resourceType, 
      String id, 
      Meta meta, 
      Text text, 
      List<Identifier> identifier, 
      List<Name> name, 
      String gender, 
      String birthDate,}){
    _resourceType = resourceType;
    _id = id;
    _meta = meta;
    _text = text;
    _identifier = identifier;
    _name = name;
    _gender = gender;
    _birthDate = birthDate;
}

  Patient.fromJson(dynamic json) {
    _resourceType = json['resourceType'];
    _id = json['id'];
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _text = json['text'] != null ? Text.fromJson(json['text']) : null;
    if (json['identifier'] != null) {
      _identifier = [];
      json['identifier'].forEach((v) {
        _identifier.add(Identifier.fromJson(v));
      });
    }
    if (json['name'] != null) {
      _name = [];
      json['name'].forEach((v) {
        _name.add(Name.fromJson(v));
      });
    }
    _gender = json['gender'];
    _birthDate = json['birthDate'];
  }
  String _resourceType;
  String _id;
  Meta _meta;
  Text _text;
  List<Identifier> _identifier;
  List<Name> _name;
  String _gender;
  String _birthDate;

  String get resourceType => _resourceType;
  String get id => _id;
  Meta get meta => _meta;
  Text get text => _text;
  List<Identifier> get identifier => _identifier;
  List<Name> get name => _name;
  String get gender => _gender;
  String get birthDate => _birthDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resourceType'] = _resourceType;
    map['id'] = _id;
    if (_meta != null) {
      map['meta'] = _meta.toJson();
    }
    if (_text != null) {
      map['text'] = _text.toJson();
    }
    if (_identifier != null) {
      map['identifier'] = _identifier.map((v) => v.toJson()).toList();
    }
    if (_name != null) {
      map['name'] = _name.map((v) => v.toJson()).toList();
    }
    map['gender'] = _gender;
    map['birthDate'] = _birthDate;
    return map;
  }

}

/// family : "Apellidos"
/// given : ["Nombre1","Nombre2"]

class Name {
  Name({
      String family, 
      List<String> given,}){
    _family = family;
    _given = given;
}

  Name.fromJson(dynamic json) {
    _family = json['family'];
    _given = json['given'] != null ? json['given'].cast<String>() : [];
  }
  String _family;
  List<String> _given;

  String get family => _family;
  List<String> get given => _given;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['family'] = _family;
    map['given'] = _given;
    return map;
  }

}

/// system : "CIP"
/// value : "ARMA0660725000"

class Identifier {
  Identifier({
      String system, 
      String value,}){
    _system = system;
    _value = value;
}

  Identifier.fromJson(dynamic json) {
    _system = json['system'];
    _value = json['value'];
  }
  String _system;
  String _value;

  String get system => _system;
  String get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['system'] = _system;
    map['value'] = _value;
    return map;
  }

}

/// status : "generated"
/// div : "<div xmlns=\"http://www.w3.org/1999/xhtml\"> <div class=\"hapiHeaderText\">Nombre1 Nombre2 <b>APELLIDOS </b> </div> <table class=\"hapiPropertyTable\"> <tbody> <tr> <td>Identifier</td> <td>123456184</td> </tr> <tr> <td>Date of birth</td> <td> <span>13 August 1975</span> </td> </tr> </tbody> </table> </div>"

class Text {
  Text({
      String status, 
      String div,}){
    _status = status;
    _div = div;
}

  Text.fromJson(dynamic json) {
    _status = json['status'];
    _div = json['div'];
  }
  String _status;
  String _div;

  String get status => _status;
  String get div => _div;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['div'] = _div;
    return map;
  }

}

/// versionId : "2"
/// lastUpdated : "2020-02-08T19:46:57.711+00:00"
/// source : "#LCEWjZgz6U20QxrP"

class Meta {
  Meta({
      String versionId, 
      String lastUpdated, 
      String source,}){
    _versionId = versionId;
    _lastUpdated = lastUpdated;
    _source = source;
}

  Meta.fromJson(dynamic json) {
    _versionId = json['versionId'];
    _lastUpdated = json['lastUpdated'];
    _source = json['source'];
  }
  String _versionId;
  String _lastUpdated;
  String _source;

  String get versionId => _versionId;
  String get lastUpdated => _lastUpdated;
  String get source => _source;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['versionId'] = _versionId;
    map['lastUpdated'] = _lastUpdated;
    map['source'] = _source;
    return map;
  }

}