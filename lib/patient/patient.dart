/// resourceType : "Patient"
/// id : "1161192"
/// meta : {"versionId":"1","lastUpdated":"2020-05-07T09:42:53.589+00:00","source":"#JWr0M08CqHLYVRPC"}
/// text : {"status":"generated","div":"<div xmlns=\"http://www.w3.org/1999/xhtml\"><div class=\"hapiHeaderText\">Mrs. Maxima831 <b>SCHMELER639 </b></div><table class=\"hapiPropertyTable\"><tbody><tr><td>Identifier</td><td>999-38-7853</td></tr><tr><td>Address</td><td><span>Swansea </span><span>Massachusetts </span><span>Bristol County </span></td></tr><tr><td>Date of birth</td><td><span>13 November 1965</span></td></tr></tbody></table></div>"}
/// identifier : [{"system":"http://hl7.org/fhir/sid/us-ssn","value":"999-38-7853"},{"system":"urn:oid:2.16.840.1.113883.4.3.25","value":"S99959627"},{"system":"http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber","value":"X44273543X"}]
/// name : [{"use":"official","family":"Schmeler639","given":["Maxima831"],"prefix":["Mrs."]},{"use":"maiden","family":"Wilderman619"}]
/// gender : "female"
/// birthDate : "1965-11-13"
/// address : [{"extension":[{"url":"latitude","valueDecimal":41.736170123512565},{"url":"longitude","valueDecimal":-71.24747720927182}],"city":"Swansea","state":"Massachusetts","country":"Bristol County"}]
/// maritalStatus : {"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-MaritalStatus","code":"M","display":"Married"}],"text":"M"}
/// multipleBirthBoolean : false

class Patient {
  Patient({
    String? resourceType,
    String? id,
    Meta? meta,
    Text? text,
    List<Identifier>? identifier,
    List<Name>? name,
    String? gender,
    String? birthDate,
    List<Address>? address,
    MaritalStatus? maritalStatus,
    bool? multipleBirthBoolean,
  }) {
    _resourceType = resourceType;
    _id = id;
    _meta = meta;
    _text = text;
    _identifier = identifier;
    _name = name;
    _gender = gender;
    _birthDate = birthDate;
    _address = address;
    _maritalStatus = maritalStatus;
    _multipleBirthBoolean = multipleBirthBoolean;
  }

  Patient.fromJson(dynamic json) {
    _resourceType = json['resourceType'];
    _id = json['id'];
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _text = json['text'] != null ? Text.fromJson(json['text']) : null;
    if (json['identifier'] != null) {
      _identifier = [];
      json['identifier'].forEach((v) {
        _identifier?.add(Identifier.fromJson(v));
      });
    }
    if (json['name'] != null) {
      _name = [];
      json['name'].forEach((v) {
        _name?.add(Name.fromJson(v));
      });
    }
    _gender = json['gender'];
    _birthDate = json['birthDate'];
    if (json['address'] != null) {
      _address = [];
      json['address'].forEach((v) {
        _address?.add(Address.fromJson(v));
      });
    }
    _maritalStatus = json['maritalStatus'] != null
        ? MaritalStatus.fromJson(json['maritalStatus'])
        : null;
    _multipleBirthBoolean = json['multipleBirthBoolean'];
  }

  String? _resourceType;
  String? _id;
  Meta? _meta;
  Text? _text;
  List<Identifier>? _identifier;
  List<Name>? _name;
  String? _gender;
  String? _birthDate;
  List<Address>? _address;
  MaritalStatus? _maritalStatus;
  bool? _multipleBirthBoolean;

  String? get resourceType => _resourceType;

  String? get id => _id;

  Meta? get meta => _meta;

  Text? get text => _text;

  List<Identifier>? get identifier => _identifier;

  List<Name>? get name => _name;

  String? get gender => _gender;

  String? get birthDate => _birthDate;

  List<Address>? get address => _address;

  MaritalStatus? get maritalStatus => _maritalStatus;

  bool? get multipleBirthBoolean => _multipleBirthBoolean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resourceType'] = _resourceType;
    map['id'] = _id;
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    if (_text != null) {
      map['text'] = _text?.toJson();
    }
    if (_identifier != null) {
      map['identifier'] = _identifier?.map((v) => v.toJson()).toList();
    }
    if (_name != null) {
      map['name'] = _name?.map((v) => v.toJson()).toList();
    }
    map['gender'] = _gender;
    map['birthDate'] = _birthDate;
    if (_address != null) {
      map['address'] = _address?.map((v) => v.toJson()).toList();
    }
    if (_maritalStatus != null) {
      map['maritalStatus'] = _maritalStatus?.toJson();
    }
    map['multipleBirthBoolean'] = _multipleBirthBoolean;
    return map;
  }

  int getAge() {
    var ageDate = DateTime.parse(birthDate!);

    var age = DateTime.now().year - ageDate.year;

    return age;
  }
}

/// coding : [{"system":"http://terminology.hl7.org/CodeSystem/v3-MaritalStatus","code":"M","display":"Married"}]
/// text : "M"

class MaritalStatus {
  MaritalStatus({
    List<Coding>? coding,
    String? text,
  }) {
    _coding = coding;
    _text = text;
  }

  MaritalStatus.fromJson(dynamic json) {
    if (json['coding'] != null) {
      _coding = [];
      json['coding'].forEach((v) {
        _coding?.add(Coding.fromJson(v));
      });
    }
    _text = json['text'];
  }

  List<Coding>? _coding;
  String? _text;

  List<Coding>? get coding => _coding;

  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_coding != null) {
      map['coding'] = _coding?.map((v) => v.toJson()).toList();
    }
    map['text'] = _text;
    return map;
  }
}

/// system : "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
/// code : "M"
/// display : "Married"

class Coding {
  Coding({
    String? system,
    String? code,
    String? display,
  }) {
    _system = system;
    _code = code;
    _display = display;
  }

  Coding.fromJson(dynamic json) {
    _system = json['system'];
    _code = json['code'];
    _display = json['display'];
  }

  String? _system;
  String? _code;
  String? _display;

  String? get system => _system;

  String? get code => _code;

  String? get display => _display;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['system'] = _system;
    map['code'] = _code;
    map['display'] = _display;
    return map;
  }
}

/// extension : [{"url":"latitude","valueDecimal":41.736170123512565},{"url":"longitude","valueDecimal":-71.24747720927182}]
/// city : "Swansea"
/// state : "Massachusetts"
/// country : "Bristol County"

class Address {
  Address({
    List<Extension>? extension,
    String? city,
    String? state,
    String? country,
  }) {
    _extension = extension;
    _city = city;
    _state = state;
    _country = country;
  }

  Address.fromJson(dynamic json) {
    if (json['extension'] != null) {
      _extension = [];
      json['extension'].forEach((v) {
        _extension?.add(Extension.fromJson(v));
      });
    }
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
  }

  List<Extension>? _extension;
  String? _city;
  String? _state;
  String? _country;

  List<Extension>? get extension => _extension;

  String? get city => _city;

  String? get state => _state;

  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_extension != null) {
      map['extension'] = _extension?.map((v) => v.toJson()).toList();
    }
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    return map;
  }
}

/// url : "latitude"
/// valueDecimal : 41.736170123512565

class Extension {
  Extension({
    String? url,
    double? valueDecimal,
  }) {
    _url = url;
    _valueDecimal = valueDecimal;
  }

  Extension.fromJson(dynamic json) {
    _url = json['url'];
    _valueDecimal = json['valueDecimal'];
  }

  String? _url;
  double? _valueDecimal;

  String? get url => _url;

  double? get valueDecimal => _valueDecimal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['valueDecimal'] = _valueDecimal;
    return map;
  }
}

/// use : "official"
/// family : "Schmeler639"
/// given : ["Maxima831"]
/// prefix : ["Mrs."]

class Name {
  Name({
    String? use,
    String? family,
    List<String>? given,
    List<String>? prefix,
  }) {
    _use = use;
    _family = family;
    _given = given;
    _prefix = prefix;
  }

  Name.fromJson(dynamic json) {
    _use = json['use'];
    _family = json['family'];
    _given = json['given'] != null ? json['given'].cast<String>() : [];
    _prefix = json['prefix'] != null ? json['prefix'].cast<String>() : [];
  }

  String? _use;
  String? _family;
  List<String>? _given;
  List<String>? _prefix;

  String? get use => _use;

  String? get family => _family;

  List<String>? get given => _given;

  List<String>? get prefix => _prefix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['use'] = _use;
    map['family'] = _family;
    map['given'] = _given;
    map['prefix'] = _prefix;
    return map;
  }
}

/// system : "http://hl7.org/fhir/sid/us-ssn"
/// value : "999-38-7853"

class Identifier {
  Identifier({
    String? system,
    String? value,
  }) {
    _system = system;
    _value = value;
  }

  Identifier.fromJson(dynamic json) {
    _system = json['system'];
    _value = json['value'];
  }

  String? _system;
  String? _value;

  String? get system => _system;

  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['system'] = _system;
    map['value'] = _value;
    return map;
  }
}

/// status : "generated"
/// div : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><div class=\"hapiHeaderText\">Mrs. Maxima831 <b>SCHMELER639 </b></div><table class=\"hapiPropertyTable\"><tbody><tr><td>Identifier</td><td>999-38-7853</td></tr><tr><td>Address</td><td><span>Swansea </span><span>Massachusetts </span><span>Bristol County </span></td></tr><tr><td>Date of birth</td><td><span>13 November 1965</span></td></tr></tbody></table></div>"

class Text {
  Text({
    String? status,
    String? div,
  }) {
    _status = status;
    _div = div;
  }

  Text.fromJson(dynamic json) {
    _status = json['status'];
    _div = json['div'];
  }

  String? _status;
  String? _div;

  String? get status => _status;

  String? get div => _div;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['div'] = _div;
    return map;
  }
}

/// versionId : "1"
/// lastUpdated : "2020-05-07T09:42:53.589+00:00"
/// source : "#JWr0M08CqHLYVRPC"

class Meta {
  Meta({
    String? versionId,
    String? lastUpdated,
    String? source,
  }) {
    _versionId = versionId;
    _lastUpdated = lastUpdated;
    _source = source;
  }

  Meta.fromJson(dynamic json) {
    _versionId = json['versionId'];
    _lastUpdated = json['lastUpdated'];
    _source = json['source'];
  }

  String? _versionId;
  String? _lastUpdated;
  String? _source;

  String? get versionId => _versionId;

  String? get lastUpdated => _lastUpdated;

  String? get source => _source;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['versionId'] = _versionId;
    map['lastUpdated'] = _lastUpdated;
    map['source'] = _source;
    return map;
  }
}
