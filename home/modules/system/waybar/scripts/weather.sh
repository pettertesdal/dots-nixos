#!/etc/profiles/per-user/tesdap/bin/bash

# Function to map weather symbol codes to icons
weather_icon() {
    case $1 in
        "clearsky_day") echo "󰖙 " ;;   # Sunny
        "clearsky_night") echo " " ;; # Clear Night
        "clearsky_polartwilight") echo " " ;; # Clear Night
        "cloudy") echo "󰖐 " ;;          # Cloudy
        "fair_day") echo "󰖐 " ;;          # Cloudy
        "fair_night") echo "󰖐 " ;;          # Cloudy
        "fair_polartwilight") echo "󰖐 " ;;          # Cloudy
        "fog") echo " " ;;             # Fog
        "heavyrain") echo  "" ;;             # Fog
        "heavyrainshowers_day") echo "" ;;             # Fog
        "heavyrainshowers_night") echo "" ;;             # Fog
        "heavyrainandthunder") echo "󰙾 " ;;             # Fog
        "heavyrainshowersandthunder_day") echo "" ;;             # Fog
        "heavyrainshowersandthunder_night") echo "" ;;             # Fog
        "heavyrainshowersandthunder_polartwilight") echo "" ;;             # Fog
        "heavysleet") echo "󱋋 " ;;             # Fog
        "heavysleetshowers_day") echo "󱋋 " ;;             # Fog
        "heavysleetshowers_night") echo "󱋋 " ;;             # Fog
        "heavysleetshowers_polartwilight") echo "󱋋 " ;;             # Fog
        "heavysleetandthunder") echo "󱋋 " ;;             # Fog
        "heavysleetshowersandthunder_day") echo "󱋋 " ;;             # Fog
        "heavysleetshowersandthunder_night") echo "󱋋 " ;;             # Fog
        "heavysleetshowersandthunder_polartwilight") echo "󱋋 " ;;             # Fog
        "heavysnow") echo "󰜗 " ;;             # Fog
        "heavysnowshowers_day") echo "󰜗 " ;;             # Fog
        "heavysnowshowers_night") echo "󰜗 " ;;             # Fog
        "heavysnowshowers_polartwilight") echo "󰜗 " ;;             # Fog
        "heavysnowandthunder") echo "󰜗 " ;;             # Fog
        "heavysnowshowersandthunder_day") echo "󰜗 " ;;             # Fog
        "heavysnowshowersandthunder_night") echo "󰜗 " ;;             # Fog
        "heavysnowshowersandthunder_polartwilight") echo "󰜗 " ;;             # Fog
        "lightrain") echo " " ;;            # Rain
        "lightrainandthunder") echo " " ;;            # Rain
        "lightrainshowers_day") echo " " ;;            # Rain
        "lightrainshowers_night") echo " " ;;            # Rain
        "lightrainshowers_polartwilight") echo " " ;;            # Rain
        "lightrainshowersandthunder_day") echo " " ;;            # Rain
        "lightrainshowersandthunder_night") echo " " ;;            # Rain
        "lightrainshowersandthunder_polartwilight") echo " " ;;            # Rain
        "lightsleet") echo "󰜗 " ;;             # Fog
        "lightsleetshowers_day") echo "󰜗 " ;;             # Fog
        "lightsleetshowers_night") echo "󰜗 " ;;             # Fog
        "lightsleetshowers_polartwilight") echo "󰜗 " ;;             # Fog
        "lightsleetandthunder") echo "󰜗 " ;;             # Fog
        "lightsleetshowersandthunder_day") echo "󰜗 " ;;             # Fog
        "lightsleetshowersandthunder_night") echo "󰜗 " ;;             # Fog
        "lightsleetshowersandthunder_polartwilight") echo "󰜗 " ;;             # Fog
        "lightsnow") echo "󰜗 " ;;             # Fog
        "lightsnowshowers_day") echo "󰜗 " ;;             # Fog
        "lightsnowshowers_night") echo "󰜗 " ;;             # Fog
        "lightsnowshowers_polartwilight") echo "󰜗 " ;;             # Fog
        "lightsnowandthunder") echo "󰜗 " ;;             # Fog
        "lightsnowshowersandthunder_day") echo "󰜗 " ;;             # Fog
        "lightsnowshowersandthunder_night") echo "󰜗 " ;;             # Fog
        "lightsnowshowersandthunder_polartwilight") echo "󰜗 " ;;             # Fog
        "partlycloudy_day") echo " " ;; # Partly Cloudy Day
        "partlycloudy_night") echo " " ;; # Partly Cloudy Night
        "partlycloudy_polartwilight") echo " " ;; # Partly Cloudy Night
        "rain") echo " " ;;            # Rain
        "rainshowers_day") echo " " ;;            # Rain
        "rainshowers_night") echo " " ;;            # Rain
        "rainshowers_polartwilight") echo " " ;;            # Rain
        "rainandthunder") echo " " ;;            # Rain
        "rainshowersandthunder_day") echo " " ;;            # Rain
        "rainshowersandthunder_night") echo " " ;;            # Rain
        "rainshowersandthunder_polartwilight") echo " " ;;            # Rain
        "sleet") echo "󱋋 " ;;            # Snow
        "sleetandthunder") echo "󱋋 " ;;            # Snow
        "sleetshowers_day") echo "󱋋 " ;;            # Snow
        "sleetshowers_night") echo "󱋋 " ;;            # Snow
        "sleetshowersandthunder_day") echo "󱋋 " ;;            # Snow
        "sleetshowersandthunder_night") echo "󱋋 " ;;            # Snow
        "sleetshowersandthunder_polartwilight") echo "󱋋 " ;;            # Snow
        "snow") echo " " ;;            # Snow
        "snowandthunder") echo " " ;;            # Snow
        "snowshowers_day") echo " " ;;            # Snow
        "snowshowers_night") echo " " ;;            # Snow
        "snowshowers_polartwilight") echo " " ;;            # Snow
        "snowshowersandthunder_day") echo " " ;;            # Snow
        "snowshowersandthunder_night") echo " " ;;            # Snow
        "snowshowersandthunder_polartwilight") echo " " ;;            # Snow

        *) echo "?" ;;                      # Default
    esac
}

# Fetch weather data from the API
json_response=$(curl -s "https://api.met.no/weatherapi/locationforecast/2.0/complete?lat=60.3929&lon=5.3241&altitude=50")
json_responseSun=$(curl -s "https://api.met.no/weatherapi/sunrise/3.0/sun?lat=60.3929&lon=5.3241&offset=+01:00")

# Extract necessary data
current_temp=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.instant.details.air_temperature')
today_weather=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.next_6_hours.summary.symbol_code')
today_min_temp=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.next_12_hours.details.air_temperature_min')
today_max_temp=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.next_12_hours.details.air_temperature_max')
today_precipitation_chance=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.next_12_hours.details.probability_of_precipitation')
wind_speed=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.instant.details.wind_speed')
humidity=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.instant.details.relative_humidity')
uv=$(echo "$json_response" | jq -r '.properties.timeseries[0].data.instant.details.ultraviolet_index_clear_sky')
sunrise=$(echo "$json_responseSun" | jq -r '.properties.sunrise.time' | cut -d'T' -f2 | cut -d'+' -f1)
sunset=$(echo "$json_responseSun" | jq -r '.properties.sunset.time' | cut -d'T' -f2 | cut -d'+' -f1)

# forecast
tomorrow_weather=$(echo "$json_response" | jq -r '.properties.timeseries[24].data.next_6_hours.summary.symbol_code')
tomorrow_min_temp=$(echo "$json_response" | jq -r '.properties.timeseries[24].data.next_6_hours.details.air_temperature_min')
tomorrow_max_temp=$(echo "$json_response" | jq -r '.properties.timeseries[24].data.next_6_hours.details.air_temperature_max')
tomorrow_precipitation_chance=$(echo "$json_response" | jq -r '.properties.timeseries[24].data.next_6_hours.details.probability_of_precipitation')
dayafter_weather=$(echo "$json_response" | jq -r '.properties.timeseries[48].data.next_6_hours.summary.symbol_code')
dayafter_min_temp=$(echo "$json_response" | jq -r '.properties.timeseries[48].data.next_6_hours.details.air_temperature_min')
dayafter_max_temp=$(echo "$json_response" | jq -r '.properties.timeseries[48].data.next_6_hours.details.air_temperature_max')
dayafter_precipitation_chance=$(echo "$json_response" | jq -r '.properties.timeseries[48].data.next_6_hours.details.probability_of_precipitation')
third_weather=$(echo "$json_response" | jq -r '.properties.timeseries[60].data.next_12_hours.summary.symbol_code')
third_min_temp=$(echo "$json_response" | jq -r '.properties.timeseries[60].data.next_6_hours.details.air_temperature_min')
third_max_temp=$(echo "$json_response" | jq -r '.properties.timeseries[60].data.next_6_hours.details.air_temperature_max')
third_precipitation_chance=$(echo "$json_response" | jq -r '.properties.timeseries[60].data.next_6_hours.details.probability_of_precipitation')
fourth_weather=$(echo "$json_response" | jq -r '.properties.timeseries[64].data.next_12_hours.summary.symbol_code')
fourth_min_temp=$(echo "$json_response" | jq -r '.properties.timeseries[64].data.next_6_hours.details.air_temperature_min')
fourth_max_temp=$(echo "$json_response" | jq -r '.properties.timeseries[64].data.next_6_hours.details.air_temperature_max')
fourth_precipitation_chance=$(echo "$json_response" | jq -r '.properties.timeseries[64].data.next_6_hours.details.probability_of_precipitation')

# Days
tomorrow=$(date -d "tomorrow" +"%a %d")
dayafter=$(date -d "+2 days" +"%a %d")
third=$(date -d "+3 days" +"%a %d")
fourth=$(date -d "+4 days" +"%a %d")

# Get the weather icon
icon=$(weather_icon "$today_weather")
tomorrow_icon=$(weather_icon "$tomorrow_weather")
dayafter_icon=$(weather_icon "$dayafter_weather")
third_icon=$(weather_icon "$third_weather")
fourth_icon=$(weather_icon "$fourth_weather")

# Additional data (mocked for sunrise and sunset)
sunrise_sunset="󰖚 Sunrise: ${sunrise} / Sunset: ${sunset}"
uv_text="󱁞 UV-index = ${uv}"

# Temperature feels like (assuming it's the same as current for simplicity)
temp_feel_text=" : ${current_temp}°C )"

# Temperature Min/Max
temp_min_max=" Min/Max: ${today_min_temp}°C / ${today_max_temp}°C"

# Wind and Humidity
wind_text=" : ${wind_speed} m/s"
humidity_text=" : ${humidity}%"


# Map weather conditions to icons for hourly forecast
hpred_weather_icon=()
for condition in "${hpred_weather[@]:1}"; do
    hpred_weather_icon+=("$(weather_icon "$condition")")
done

# Map weather conditions to icons for daily forecast
dpred_weather_icon=()
for condition in "${dpred_weather[@]}"; do
    dpred_weather_icon+=("$(weather_icon "$condition")")
done

tooltip_text="\
${icon}:  ${today_weather}\n\
${temp_feel_text}\n\
${temp_min_max}\n\
${sunrise_sunset}\n\
${uv_text}\n\
${wind_text} / ${humidity_text}\n\n\
Forecast:\n\
${tomorrow}: ${tomorrow_icon} Min: ${tomorrow_max_temp}°C, Max: ${tomorrow_max_temp}°C,  : ${tomorrow_precipitation_chance}%\n\
${dayafter}: ${dayafter_icon} Min: ${dayafter_min_temp}°C, Max: ${dayafter_max_temp}°C,  : ${dayafter_precipitation_chance}%\n\
${third}: ${third_icon} Min: ${third_min_temp}°C, Max: ${third_max_temp}°C,  : ${third_precipitation_chance}%\n\
${fourth}: ${fourth_icon} Min: ${fourth_min_temp}°C, Max: ${fourth_max_temp}°C,  : ${fourth_precipitation_chance}%\
"

# Escape newlines for proper JSON formatting
escaped_tooltip=$(echo "$tooltip_text" | sed ':a;N;$!ba;s/\n/\\n/g')

# Manually construct JSON output for Waybar
echo "{\"text\": \"${icon} ${current_temp}°C\", \"tooltip\": \"${escaped_tooltip}\", \"alt\": \"$today_weather\"}"

