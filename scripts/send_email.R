library(blastula)
library(glue)

# 예측 결과 읽기
prediction_result <- read.csv("data/prediction_result.csv")

# 이메일 내용 작성
email_body <- compose_email(
  body = md(glue::glue("
    # 태양광 발전량 예측 보고서

    예상 기온: {round(prediction_result$temperature, 2)}°C

    예측된 일일 생산량: {round(prediction_result$predicted_yield, 2)}

    95% 예측 구간: {round(prediction_result$lower_bound, 2)} - {round(prediction_result$upper_bound, 2)}

  "))
)

# Gmail 자격 증명 불러오기
creds <- creds_file("document/gmail_creds")

# 이메일 전송
email_body |> 
  smtp_send(
    from = "kwangchun.lee.7@gmail.com",
    to = "victor@r2bit.com",
    subject = "[세종대] 태양광 발전량 예측 보고서",
    credentials = creds
  )

cat("예측 결과가 이메일로 전송되었습니다.\n")
