class OffersData {
  String? offerId;
  String? offerTitle;
  String? offerCode;
  String? offerDesc;
  String? offerAmount;
  String? startDate;
  String? endDate;
  String? url;
  List<Images>? images;

  OffersData(
      {this.offerId,
      this.offerTitle,
      this.offerCode,
      this.offerDesc,
      this.offerAmount,
      this.startDate,
      this.endDate,
      this.url,
      this.images});

  OffersData.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    offerTitle = json['offer_title'];
    offerCode = json['offer_code'];
    offerDesc = json['offer_desc'];
    offerAmount = json['offer_amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    url = json['url'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['offer_title'] = this.offerTitle;
    data['offer_code'] = this.offerCode;
    data['offer_desc'] = this.offerDesc;
    data['offer_amount'] = this.offerAmount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['url'] = this.url;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? offerId;
  String? image;

  Images({this.offerId, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['image'] = this.image;
    return data;
  }
}