class Coordenada {
  final double lat;
  final double lng;

  Coordenada({
    required this.lat,
    required this.lng,
  });

  factory Coordenada.fromJson(Map<String, dynamic> json) {
    return Coordenada(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}