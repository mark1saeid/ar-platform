class Whether {
  String region;
  CurrentConditions currentConditions;
  List<NextDays> nextDays;
  ContactAuthor contactAuthor;
  String dataSource;

  Whether(
      {this.region,
        this.currentConditions,
        this.nextDays,
        this.contactAuthor,
        this.dataSource});

  Whether.fromJson(Map<String, dynamic> json) {
    region = json['region'];
    currentConditions = json['currentConditions'] != null
        ? new CurrentConditions.fromJson(json['currentConditions'])
        :new CurrentConditions(temp: Temp(c: 34),comment: "") ;
    if (json['next_days'] != null) {
      nextDays = <NextDays>[];
      json['next_days'].forEach((v) {
        nextDays.add(new NextDays.fromJson(v));
      });
    }
    contactAuthor = json['contact_author'] != null
        ? new ContactAuthor.fromJson(json['contact_author'])
        : null;
    dataSource = json['data_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region'] = this.region;
    if (this.currentConditions != null) {
      data['currentConditions'] = this.currentConditions.toJson();
    }
    if (this.nextDays != null) {
      data['next_days'] = this.nextDays.map((v) => v.toJson()).toList();
    }
    if (this.contactAuthor != null) {
      data['contact_author'] = this.contactAuthor.toJson();
    }
    data['data_source'] = this.dataSource;
    return data;
  }
}

class CurrentConditions {
  String dayhour;
  Temp temp;
  String precip;
  String humidity;
  Wind wind;
  String iconURL;
  String comment;

  CurrentConditions(
      {this.dayhour,
        this.temp,
        this.precip,
        this.humidity,
        this.wind,
        this.iconURL,
        this.comment});

  CurrentConditions.fromJson(Map<String, dynamic> json) {
    dayhour = json['dayhour'];
    temp = json['temp'] != null ? new Temp.fromJson(json['temp']) : null;
    precip = json['precip'];
    humidity = json['humidity'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    iconURL = json['iconURL'];
    comment = json['comment']!= null ?json['comment']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayhour'] = this.dayhour;
    if (this.temp != null) {
      data['temp'] = this.temp.toJson();
    }
    data['precip'] = this.precip;
    data['humidity'] = this.humidity;
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    data['iconURL'] = this.iconURL;
    data['comment'] = this.comment;
    return data;
  }
}

class Temp {
  int c;
  int f;

  Temp({this.c, this.f});

  Temp.fromJson(Map<String, dynamic> json) {
    c = json['c'];
    f = json['f'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c'] = this.c;
    data['f'] = this.f;
    return data;
  }
}

class Wind {
  int km;
  int mile;

  Wind({this.km, this.mile});

  Wind.fromJson(Map<String, dynamic> json) {
    km = json['km'];
    mile = json['mile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['km'] = this.km;
    data['mile'] = this.mile;
    return data;
  }
}

class NextDays {
  String day;
  String comment;
  Temp maxTemp;
  Temp minTemp;
  String iconURL;

  NextDays({this.day, this.comment, this.maxTemp, this.minTemp, this.iconURL});

  NextDays.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    comment = json['comment'];
    maxTemp =
    json['max_temp'] != null ? new Temp.fromJson(json['max_temp']) : null;
    minTemp =
    json['min_temp'] != null ? new Temp.fromJson(json['min_temp']) : null;
    iconURL = json['iconURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['comment'] = this.comment;
    if (this.maxTemp != null) {
      data['max_temp'] = this.maxTemp.toJson();
    }
    if (this.minTemp != null) {
      data['min_temp'] = this.minTemp.toJson();
    }
    data['iconURL'] = this.iconURL;
    return data;
  }
}

class ContactAuthor {
  String email;
  String authNote;

  ContactAuthor({this.email, this.authNote});

  ContactAuthor.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    authNote = json['auth_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['auth_note'] = this.authNote;
    return data;
  }
}