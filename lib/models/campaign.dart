class Campaign {
  final String bankId;
  final String image;
  final String campaignTitle;
  final String description;
  final String timestap;

  Campaign(
      {required this.bankId,
      required this.image,
      required this.campaignTitle,
      required this.timestap,
      required this.description});

  Map<String, dynamic> toMap() {
    return {
      'bankId': bankId,
      'image': image,
      'campaignTitle': campaignTitle,
      'description': description,
      'timestap': timestap
    };
  }

  factory Campaign.fromMap(Map<String, dynamic> map) {
    return Campaign(
      bankId: map['bankId'],
      image: map['image'],
      campaignTitle: map['campaignTitle'],
      description: map['description'],
      timestap: map['timestap'],
    );
  }

  @override
  String toString() {
    return 'Campaign(bankId: $bankId, image: $image, campaignTitle: $campaignTitle, description: $description)';
  }
}
