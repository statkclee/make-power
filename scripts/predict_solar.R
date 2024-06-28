library(tidyverse)

# 저장된 모델 불러오기
simple_model <- readRDS("data/simple_solar_prediction_model.rds")

# 온도 데이터 읽기
temperature_data <- read.csv("data/temperature.csv")
temperature <- temperature_data$temperature

# 예측 수행
new_data <- data.frame(AMBIENT_TEMPERATURE = temperature)
predicted_yield <- predict(simple_model, newdata = new_data)
prediction_interval <- predict(simple_model, newdata = new_data, interval = "prediction")

# 결과 저장
prediction_result <- data.frame(
  temperature = temperature,
  predicted_yield = predicted_yield,
  lower_bound = prediction_interval[, "lwr"],
  upper_bound = prediction_interval[, "upr"]
)

write.csv(prediction_result, "data/prediction_result.csv", row.names = FALSE)
