# 공용 Kafka Produce & Consume 실습

기본적인 Produce, Consume 과정 이해 및 Kafka 관리도구인 akhq와 UI for Apache Kafka를 체험해보는 것을 목표로 함.

<br>

## 목차
1. [기초 Produce, Consume 실습하기](#1-기초-produce-consume-실습하기)
2. [이전 발행 모든 메시지 읽기](#2-producer가-발행한-처음-메시지부터-데이터-가져오기)
3. [특정 offset 부터 메시지 읽기](#3-특정-offset-으로부터-데이터-가져오기)
4. [Consumer Group 테스트하기](#4-consumer-group-테스트하기)
5. [Multi json 데이터 한번에 발행하기](#5-multi-json-data-테스트하기)
6. [Up & Down 게임](#6-up--down-game)

<br>

---

## 1. 기초 Produce, Consume 실습하기


1. 실습 디렉토리 이동
```
cd 01_basic_pub_sub
```



2. producer 프로그램 실행
```
sh 01_produce.sh
```

해당 프로그램은 공용 Kafka 서버 내에 있는 kafka-class 토픽을 대상으로 데이터 발행을 수행한다.



3. github codespace 화면 분할

<p align="center">
    <img src="./pic/01_split_window.png"/>
</p>


Consumer 프로그램 실행을 위해서 window 화면을 분할한다.

<br>

4. consumer 프로그램 실행

<p align="center">
    <img src="./pic/03_execute_program.png"/>
</p>


```
sh 02_consume.sh
```

<br>

분할한 화면에서 consumer 프로그램을 실행한다. 이후 producer에서 메시지를 입력하여, consumer 프로그램에서 출력되는지 확인한다.

---

### 1-1 live-tailing 확인(AKHQ)


<br>

공용 Kafka 서버에는 AKHQ와 UI for Apache Kafka가 설치되어있다.
IP는 수업 시간에 공지하였으며, AKHQ는 **8081** 포트 UI for Apache Kafka는 **8080** 포트로 접속한다.

<br>


1. AKHQ live tail 확인하기

<p align="center">
    <img src="./pic/04_open_live_tail.png"/>
</p>


<br>

AKHQ 페이지 접속한 다음 live tail 아이콘을 클릭하여 해당 페이지로 이동한다.

<br>

2. Topic 지정하기


<p align="center">
    <img src="./pic/05_select_topic.png"/>
</p>

<br>

Live tail을 수행할 Topic인 kafka-class를 선택한다.

<br>

3. 검색 클릭

<p align="center">
    <img src="./pic/06_tail_topic_log.png"/>
</p>


검색 버튼을 클릭하여 live tail 기능을 수행한다. 이후 producer 프로그램에서 데이터를 발행하여 해당 Topic에 데이터가 쌓이는 것을 확인한다.

<br>

---

<br>

### 1-2 kafka-class offset 정보 확인(UI for Apache Kafka)


UI for apache kafka는 Kafka 관리도구 중 하나로써 Kafka Cluster 관리에 필요한 다양한 기능을 제공한다. 그 중 Topic 상세 정보를 한 번 살펴보자.

<br>

1. Topic 상세 정보창 이동

<p align="center">
    <img src="./pic/07_access_topic_description.png"/>
</p>


Topic > Kafka-class Topic을 클릭하여, 상세 정보창으로 이동한다.

<br>

2. Topic 상세 기능 확인

<p align="center">
    <img src="./pic/08_check_basic_functions.png"/>
</p>

UI for apache kafka에서 제공하는 여러 기능을 테스트해본다.

<br>

### 1-3 1번 실습 종료

<br>

1번 실습이 끝나면 codespace 화면 분할 종료 후, 다음 실습을 위해 상위 디렉토리로 이동한다.

<br>

1. 화면 분할 종료

<p align="center">
    <img src="./pic/02_terminate_window.png"/>
</p>


<br>

2. 상위 디렉토리 이동

```
cd ..
```

<br>


---

<br>

## 2. Producer가 발행한 처음 메시지부터 데이터 가져오기

<br>

강사가 임의로 kafka-consumer-test Topic에 5개의 메시지(0~4)를 미리 발행하고 이후 **특정 시점에 모든 메시지를 가져오는 것** 확인 목표

<br>


1. 강사가 사전에 메시지 미리 발행

<br>

2. consumer 프로그램 실행

```
sh 02_consume_beginning_offset.sh
```

<br>

해당 프로그램은 kafka-consumer-test 토픽에 저장된 메시지를 읽어온다. 프로그램 기동 시 **--from-beginning** 옵션을 통해 해당 토픽에 저장된 모든 이전 메시지 정보를 읽어온다.

<br>

---

## 3. 특정 offset 으로부터 데이터 가져오기


<br>

강사가 임의로 5개의 메시지(0~4)를 미리 발행하고 이후 **특정 시점에 특정 offset으로부터 메시지를 가져오는 것** 확인 목표

<br>

1. consumer 프로그램 실행

```
sh 03_consume_specific_offset.sh 3 
```

<br>

프로그램 수행 시에 인자로 0~4 사이의 offset 번호를 입력하면, 해당 offset으로부터 메시지를 수신 받을 수 있다.

※ 위 예제는 3번 offset부터 메시지를 수신받는 테스트 프로그램 실행

<br>

---

## 4. Consumer Group 테스트하기

<br>

파티션이 2개인 **consumer-group-test** Topic을 공용 Kafka Cluster에 미리 생성되어있는 환경에서 consumer 그룹 관련 기본 개념을 실습하는 것을 목표

<br>


### 4-1 단일 Consumer 테스트


1. 실습 디렉토리 이동

```
cd 04_test_consumer_group
```

<br>

2. Producer 프로그램 실행

```
sh 01_produce.sh 0
```

여기서 전달되는 인자는 partition 번호를 의미하며, consumer-group-test 토픽은 2개 파티션이 생성되어있음. 따라서 위 프로그램은 0번 파티션에 대해 메시지를 발행하는 것을 의도함.

<br>

※ Producer를 실행하기 위해 kafkacat 프로그램을 사용했는데, 이는 특정 파티션을 지정하기 위한 용도로 사용했음. 기본 제공 프로그램에서는 특정 파티션에 대해 메시지를 발행하는 기능이 없음 

<br>

3. codespace 화면 분할



lag 확인
consumer group이 akhq에 표시된 거 확인하기

스크립트 보강해서, partition 0, 1로 발행하는 produce 넣고 consumer-group에서 각각 다른 메시지 수신하는 것도 보여주면 좋을듯


## 5. Multi-json data 테스트하기

akhq live-taling 키기
더미데이터 확인
메시지 발행


## 6. Up & Down Game 