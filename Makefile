.PHONY: all clean create_dirs daily

all: send_email

output/weather_data.csv output/temperature.csv: scripts/get_temperature.R
	Rscript scripts/get_temperature.R

output/prediction_result.csv: scripts/predict_solar.R output/weather_data.csv output/temperature.csv
	Rscript scripts/predict_solar.R

send_email: scripts/send_email.R output/prediction_result.csv
	Rscript scripts/send_email.R

clean:
	rm -f output/weather_data.csv output/temperature.csv output/prediction_result.csv

# 일일 작업을 위한 새로운 타겟
daily: clean all	