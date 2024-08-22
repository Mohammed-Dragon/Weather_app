class Weather {
  final String cityName;
  final double temp;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.mainCondition,
    required this.temp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
