#!/etc/profiles/per-user/tesdap/bin/bash

# # Function to dynamically find the corresponding SVG icon
weather_icon() {
    local icon_path="~/.dots/home/modules/system/waybar/scripts/icons/weathericons"
    local icon_file="$icon_path/$1.svg"
    
    # Check if the file exists
    if [[ -f "$icon_file" ]]; then
        echo "$icon_file"
    else
        echo "$icon_path/default.svg"  # Fallback to a default icon if no match
    fi
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
dayafter_icon_=$(weather_icon "$dayafter_weather")
third_icon=$(weather_icon "$third_weather")
fourth_icon=$(weather_icon "$fourth_weather")

# Additional data (mocked for sunrise and sunset)
sunrise_sunset="☀️  Sunrise: ${sunrise} / Sunset: ${sunset}"
uv_text="󱁞 UV-index = ${uv}"

# Temperature feels like (assuming it's the same as current for simplicity)
temp_feel_text="Current Temp: ${current_temp}°C )"

# Temperature Min/Max
temp_min_max="Min/Max Temp: ${today_min_temp}°C / ${today_max_temp}°C"

# Wind and Humidity
wind_text="Wind: ${wind_speed} m/s"
humidity_text="Humidity: ${humidity}%"


# Map weather conditions to icons for hourly forecast
hpred_weather_icon=()
for condition in "${hpred_weather[@]:1}"; do
    hpred_weather_icon+=("$(weather_icon "$condition")")
done

# Daily Forecast Data (mocked to replicate the Python format)
dpred_header=(${tomorrow} ${} "Third Day")
dpred_templ=("5" "7" "6")
dpred_temph=("High" "12" "14" "10")
dpred_weather=("cloudy" "rain" "snow")
dpred_precip=("30%" "50%" "60%")

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
${tomorrow}: ${tomorrow_icon} Min: ${tomorrow_max_temp}°C, Precip: ${tomorrow_max_temp}°C, Precip ${tomorrow_precipitation_chance}\n\
${dayafter}: ${dayafter_icon} Min: ${dayafter_min_temp}°C, Max: ${dayafter_max_temp}°C, Precip: ${dayafter_precipitation_chance}\n\
${third}: ${third_icon} Min: ${third_min_temp}°C, Max: ${third_max_temp}°C, Precip: ${third_precipitation_chance}\n\
${fourth}: ${fourth_icon} Min: ${fourth_min_temp}°C, Max: ${fourth_max_temp}°C, Precip: ${fourth_precipitation_chance}\
"

# Escape newlines for proper JSON formatting
escaped_tooltip=$(echo "$tooltip_text" | sed ':a;N;$!ba;s/\n/\\n/g')

# Manually construct JSON output for Waybar
echo "{\"text\": \"${icon}  ${current_temp}°C\", \"tooltip\": \"${escaped_tooltip}\", \"alt\": \"$today_weather\"}"

