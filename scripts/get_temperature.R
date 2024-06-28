library(httr2)
library(xml2)
library(dplyr)
library(tidyr)
library(lubridate)

service_key <- Sys.getenv("DATA_GO_DECODE_KEY")
base_date <- format(Sys.Date(), "%Y%m%d")
base_time <- "0500"
nx <- 62
ny <- 126

resp <- request("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst") |> 
  req_url_query(
    serviceKey = service_key,
    pageNo = "1",
    numOfRows = "1000",
    dataType = "XML",
    base_date = base_date,
    base_time = base_time,
    nx = nx,
    ny = ny
  ) |> 
  req_perform()

xml_data <- resp |> resp_body_xml()
items <- xml_find_all(xml_data, "//item")

forecast_data <- map_df(items, ~{
  data.frame(
    baseDate = xml_text(xml_find_first(.x, ".//baseDate")),
    baseTime = xml_text(xml_find_first(.x, ".//baseTime")),
    category = xml_text(xml_find_first(.x, ".//category")),
    fcstDate = xml_text(xml_find_first(.x, ".//fcstDate")),
    fcstTime = xml_text(xml_find_first(.x, ".//fcstTime")),
    fcstValue = xml_text(xml_find_first(.x, ".//fcstValue"))
  )
})

forecast_tbl <- forecast_data %>%
  pivot_wider(names_from = category, values_from = fcstValue)

write.csv(forecast_tbl, "data/weather_data.csv", row.names = FALSE)

temperature <- forecast_tbl |> 
  mutate(fcstDate = ymd(fcstDate)) |> 
  filter(fcstDate == min(fcstDate)) |> 
  mutate(TMP = as.numeric(TMP)) |>
  summarise(average_temp = mean(TMP)) |> 
  pull(average_temp)

write.csv(data.frame(temperature = temperature), "data/temperature.csv", row.names = FALSE)

