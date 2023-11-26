class WeatherModel {
  final String city;
  final String date;
  final String weather;
  final humidity;
  final degree;
  final windSpeed;
  final feelsLike;
  final icon;

  WeatherModel(
    this.date,
    this.weather,
    this.degree,
    this.windSpeed,
    this.feelsLike,
    this.icon,
    this.humidity,
    this.city,
  );

  factory WeatherModel.fromJson(Map<String, dynamic> json, String city) {
    return WeatherModel(
      json["dt_txt"],
      json["weather"][0]["main"],
      json["main"]["temp"],
      json["wind"]["speed"],
      json["main"]["feels_like"],
      json["weather"][0]["icon"],
      json["main"]["humidity"],
      city,
    );
  }
}
