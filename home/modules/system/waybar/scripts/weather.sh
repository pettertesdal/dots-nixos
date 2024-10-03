#!/etc/profiles/per-user/tesdap/bin/bash

# Fetch weather data from the API
json_response=$(curl -s "https://api.met.no/weatherapi/locationforecast/2.0/complete?lat=60.39299&lon=5.32415&altitude=100")

# Extract current temperature and weather conditions
current_temp=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.instant.details.air_temperature')
today_weather_icon=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.next_12_hours.summary.symbol_code')
next_day_status=$(echo "$json_response" | jq -r '.properties.timeseries[1].data.next_12_hours.summary.symbol_code')

# Map weather icon to emoji or symbols (you can replace these with your preferred icons)
case $today_weather_icon in
    "cloudy") icon="☁️" ;;
    "lightrain") icon="🌧️" ;;
    "rain") icon="🌧️" ;;
    "clearsky_day") icon="☀️" ;;
    "partlycloudy_day") icon="⛅" ;;
    *) icon="❓" ;;  # Default unknown weather symbol
esac

# Output for Waybar
echo "{\"text\":\"$icon\", \"tooltip\":\"Temp: ${current_temp}°C, Today: ${today_weather_icon}, Tomorrow: ${next_day_status}\"}"

