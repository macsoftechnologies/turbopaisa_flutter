class SpinWheelResponse {
  String? spinId;
  String? spinTitle;
  String? spinCode;
  String? spinDesc;
  String? spinAmount;
  String? offerTitle;
  String? state;
  String? city;
  String? pincode;
  String? startDate;
  String? endDate;
  String? spinImage;
  String? url;
  List<Spinlist>? spinlist;

  SpinWheelResponse(
      {this.spinId,
      this.spinTitle,
      this.spinCode,
      this.spinDesc,
      this.spinAmount,
      this.offerTitle,
      this.state,
      this.city,
      this.pincode,
      this.startDate,
      this.endDate,
      this.spinImage,
      this.url,
      this.spinlist});

  SpinWheelResponse.fromJson(Map<String, dynamic> json) {
    spinId = json['spin_id'];
    spinTitle = json['spin_title'];
    spinCode = json['spin_code'];
    spinDesc = json['spin_desc'];
    spinAmount = json['spin_amount'];
    offerTitle = json['offer_title'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    spinImage = json['spin_image'];
    url = json['url'];
    if (json['spinlist'] != null) {
      spinlist = <Spinlist>[];
      json['spinlist'].forEach((v) {
        spinlist!.add(new Spinlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spin_id'] = this.spinId;
    data['spin_title'] = this.spinTitle;
    data['spin_code'] = this.spinCode;
    data['spin_desc'] = this.spinDesc;
    data['spin_amount'] = this.spinAmount;
    data['offer_title'] = this.offerTitle;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['spin_image'] = this.spinImage;
    data['url'] = this.url;
    if (this.spinlist != null) {
      data['spinlist'] = this.spinlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Spinlist {
  String? amount;

  Spinlist({this.amount});

  Spinlist.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    return data;
  }
}