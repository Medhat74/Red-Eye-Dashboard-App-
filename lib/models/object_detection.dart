class ObjectDetection {
  List<Items>? objects;

  ObjectDetection({this.objects});

  ObjectDetection.fromJson(Map<String, dynamic> json) {
    if (json['Items'] != null) {
      objects = <Items>[];
      json['Items'].forEach((v) {
        objects!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.objects != null) {
      data['Items'] = this.objects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? date;
  String? location;
  String? longitude;
  String? latitude;
  String? typeOfWeapon;
  String? timeStamp;
  String? time;

  Items(
      {this.date,
        this.location,
        this.longitude,
        this.latitude,
        this.typeOfWeapon,
        this.timeStamp,
        this.time});

  Items.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    location = json['location'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    typeOfWeapon = json['typeOfWeapon'];
    timeStamp = json['timeStamp'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['location'] = this.location;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['typeOfWeapon'] = this.typeOfWeapon;
    data['timeStamp'] = this.timeStamp;
    data['Time'] = this.time;
    return data;
  }
}