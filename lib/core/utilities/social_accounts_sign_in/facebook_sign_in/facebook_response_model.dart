/// name : "Mohammed Khalil"
/// email : "klil48449@gmail.com"
/// picture : {"data":{"height":200,"is_silhouette":false,"url":"https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=122099165642934801&width=200&ext=1754311102&hash=AT-UuUNz5Z6kpUOFbMOZz6w0","width":200}}
class FacebookResponseModel {
  FacebookResponseModel({this.name, this.email, this.picture});

  FacebookResponseModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    picture =
        json['picture'] != null ? Picture.fromJson(json['picture']) : null;
  }

  String? name;
  String? email;
  Picture? picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    if (picture != null) {
      map['picture'] = picture?.toJson();
    }
    return map;
  }
}

/// data : {"height":200,"is_silhouette":false,"url":"https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=122099165642934801&width=200&ext=1754311102&hash=AT-UuUNz5Z6kpUOFbMOZz6w0","width":200}

class Picture {
  Picture({this.data});

  Picture.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// height : 200
/// is_silhouette : false
/// url : "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=122099165642934801&width=200&ext=1754311102&hash=AT-UuUNz5Z6kpUOFbMOZz6w0"
/// width : 200

class Data {
  Data({this.height, this.isSilhouette, this.url, this.width});

  Data.fromJson(dynamic json) {
    height = json['height'];
    isSilhouette = json['is_silhouette'];
    url = json['url'];
    width = json['width'];
  }

  num? height;
  bool? isSilhouette;
  String? url;
  num? width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['height'] = height;
    map['is_silhouette'] = isSilhouette;
    map['url'] = url;
    map['width'] = width;
    return map;
  }
}
