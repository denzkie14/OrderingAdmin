class Kiosk {
  int? kiosk_id;
  String? kiosk_desc;
  String? kiosk_type;
  int? createdBy;
  bool? isUsed;
  bool? isDeleted;

  Kiosk(
      {this.kiosk_id,
      this.kiosk_desc,
      this.kiosk_type,
      this.createdBy,
      this.isUsed,
      this.isDeleted});

  Kiosk.fromJson(Map<String, dynamic> json) {
    kiosk_id = json['kiosk_id'];
    kiosk_desc = json['kiosk_desc'];
    kiosk_type = json['kiosk_type'];
    createdBy = json['createdBy'];
    isUsed = json['isUsed'] ?? false;
    isDeleted = json['isDeleted'] ?? false;
  }

  Map<String, dynamic> toJson() => {
        'kiosk_id': kiosk_id,
        'kiosk_desc': kiosk_desc,
        'kiosk_type': kiosk_type,
        'createdBy': createdBy,
        'isUsed': isUsed,
        'isDeleted': isDeleted
      };
}
