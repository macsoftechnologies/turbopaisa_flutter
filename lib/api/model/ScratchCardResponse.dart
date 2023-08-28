class ScratchCardResponse {
  int? wallet;
  int? moneywon;
  int? scratchcardwon;
  List<ScratchCards>? cards;

  ScratchCardResponse(
      {this.wallet, this.moneywon, this.scratchcardwon, this.cards});

  ScratchCardResponse.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    moneywon = json['moneywon'];
    scratchcardwon = json['scratchcardwon'];
    if (json['cards'] != null) {
      cards = <ScratchCards>[];
      json['cards'].forEach((v) {
        cards!.add(new ScratchCards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet'] = this.wallet;
    data['moneywon'] = this.moneywon;
    data['scratchcardwon'] = this.scratchcardwon;
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScratchCards {
  String? scratchId;
  String? scratchTitle;
  String? scratchColor;
  String? scratchCode;
  String? orangeDesc;
  String? yellowDesc;
  String? blueDesc;
  String? offerTitle;
  String? state;
  String? city;
  String? pincode;
  String? scratchAmount;
  String? startDate;
  String? endDate;
  String? url;
  int? scratch_status;

  ScratchCards(
      {this.scratchId,
      this.scratchTitle,
      this.scratchColor,
      this.scratchCode,
      this.orangeDesc,
      this.yellowDesc,
      this.blueDesc,
      this.offerTitle,
      this.state,
      this.city,
      this.pincode,
      this.scratchAmount,
      this.startDate,
      this.endDate,
      this.url,
      this.scratch_status
      });

  ScratchCards.fromJson(Map<String, dynamic> json) {
    scratchId = json['scratch_id'];
    scratchTitle = json['scratch_title'];
    scratchColor = json['scratch_color'];
    scratchCode = json['scratch_code'];
    orangeDesc = json['orange_desc'];
    yellowDesc = json['yellow_desc'];
    blueDesc = json['blue_desc'];
    offerTitle = json['offer_title'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    scratchAmount = json['scratch_amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    url = json['url'];
    scratch_status = json['scratch_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scratch_id'] = this.scratchId;
    data['scratch_title'] = this.scratchTitle;
    data['scratch_color'] = this.scratchColor;
    data['scratch_code'] = this.scratchCode;
    data['orange_desc'] = this.orangeDesc;
    data['yellow_desc'] = this.yellowDesc;
    data['blue_desc'] = this.blueDesc;
    data['offer_title'] = this.offerTitle;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['scratch_amount'] = this.scratchAmount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['url'] = this.url;
    data['scratch_status'] = this.scratch_status;
    return data;
  }
}