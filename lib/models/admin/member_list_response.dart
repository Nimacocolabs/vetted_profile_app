class CommitteeMemberResponse {
  bool? success;
  int? status;
  String? message;
  List<Jury>? jury;

  CommitteeMemberResponse({this.success, this.status, this.message, this.jury});

  CommitteeMemberResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['jury'] != null) {
      jury = <Jury>[];
      json['jury'].forEach((v) {
        jury!.add(new Jury.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.jury != null) {
      data['jury'] = this.jury!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jury {
  int? id;
  String? name;
  String? imageUrl;

  Jury({this.id, this.name, this.imageUrl});

  Jury.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    return data;
  }
}