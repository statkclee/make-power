# 지바대학교 사전 워크샵 학습 교재

이 자료는 지바대학교에서 진행되는 워크샵을 위한 사전 학습 교재입니다. 각 장은 워크샵의 다양한 주제를 다루고 있으며, 필요한 사전 지식을 제공합니다.

## 목차

1. [날씨 데이터 분석](./document/01_weather.qmd)
2. [머신 러닝](./document/02_ml.qmd)
3. [이메일 자동화](./document/03_email.qmd)

### 1. 날씨 데이터 API

### 2. 기계학습 - 태양발전량 예측

### 3. 이메일 자동화

이 장에서는 R을 사용하여 이메일을 자동으로 보내는 방법을 학습합니다. `blastula` 패키지를 사용하여 이메일을 작성하고 보내는 방법을 설명합니다.

---

# targets 자동화 사전 학습

`targets` 패키지는 R에서 데이터 분석 파이프라인을 자동화하고 관리하기 위한 도구입니다. 이 섹션에서는 `targets` 패키지의 기본 사용법을 학습합니다.

## 설치

`targets` 패키지를 설치합니다:

```r
install.packages("targets")
```

## 기본 사용법

1. `_targets.R` 파일을 작성합니다. 이 파일에는 분석 파이프라인의 단계가 정의됩니다.

```r
library(targets)

tar_option_set(
  packages = c("dplyr", "ggplot2")
)

list(
  tar_target(data, read.csv("data.csv")),
  tar_target(summary, summarize(data, mean = mean(value))),
  tar_target(plot, ggplot(data, aes(x, y)) + geom_point())
)
```

2. 터미널에서 다음 명령을 실행하여 파이프라인을 실행합니다:

```bash
tar_make()
```

이 명령은 `_targets.R` 파일에 정의된 모든 단계를 순차적으로 실행합니다.

3. 파이프라인의 결과를 확인하려면 다음 명령을 실행합니다:

```r
tar_read(plot)
```

위의 예제에서는 `targets` 패키지를 사용하여 데이터 읽기, 요약 및 시각화 단계를 자동화합니다.

이로써 `make_power` 프로젝트의 README와 지바대학교 워크샵 학습 자료 및 `targets` 패키지에 대한 사전 학습 내용을 포함한 문서가 완성되었습니다.
