### confluence-jira
[![Docker Image CI](https://github.com/vncloudsco/confluence-jira/actions/workflows/docker-image.yml/badge.svg?branch=7.16.2-8.22.2)](https://github.com/vncloudsco/confluence-jira/actions/workflows/docker-image.yml)

### Lưu Ý

Đây là bản mới nhất của jira và confluence đã được cấu hình hoàn chỉnh các bạn nên dùng các build image để dùng cho ổn định và có được phần mềm là mới nhất, một số image mình đã test thành công nhưng sẽ không upload cho nên hãy dùng build!

Đối với các bạn có nhu cầu sử dụng Jira Service Management, crowd để làm việc thì phải dùng docker build hiện tại mình chưa up được image lên docker hub nên sẽ không dùng được cách chạy thẳng

Để dùng được phần mềm thì bạn cần phải cài Docker và docker-compose trên máy trước khi bắt đầu quá trình cài đặt Jira vs Confluence

### chạy phần mềm trên x86_64

```
git clone https://github.com/vncloudsco/confluence-jira.git
cd confluence-jira
docker-compose up -d
``` 
### chạy phần mềm trên ARM

```
git clone https://github.com/vncloudsco/confluence-jira.git
cd confluence-jira
docker-compose -f docker-compose-arm.yaml up -d
``` 
### Build image

#### Build image & run cho x86_64

```
git clone https://github.com/vncloudsco/confluence-jira.git
cd confluence-jira
docker-compose -f docker-compose-build.yaml build
docker-compose -f docker-compose-build.yaml up -d
``` 
#### Build image & run cho ARM

```
git clone https://github.com/vncloudsco/confluence-jira.git
cd confluence-jira
docker-compose -f docker-compose-build-arm.yaml build
docker-compose -f docker-compose-build-arm.yaml up -d 
``` 


sau khi chạy thì vào các port tương ứng để cấu hình phần mềm trên máy chủ

| Phần mềm     | Port        | dbhost       | db port | db Type  |   database info in file | Version |
| ------------ | ----------- | ------------ | ------- | -------  | ----------------------- | --------|
| jira         | 8080        | jiradb       |  5432   | postgres | database-jira.env       |    13   |
| confluence   | 8090        | confluencedb |  5432   | postgres | database-confluence.env |    14   |
| Jira Service Management | 8088 | servicedeskdb | 5432 | postgres | database-servicedesk.env | 13   |
| crowd        | 8095        | crowdkdb     | 5432    |  postgres | database-crowd.env| 13 |


thông tin kết nối db xem trong file  ```database-confluence.env``` và ```database-jira.env``` và điền vào các ô tương ứng khi cài đặt

- lưu ý: 
    - hệ thống sẽ dùng postgres
    - thông tin db trong file env tương ứng


để crack thì chạy lệnh sau 

- lưu ý 
    - nhớ thay 127.0.0.1 thành IP/domain của bạn,
    - confluence thì không cần quan tâm server ID cứ lệnh đó mà chạy
    - jira thì nhớ thay server ID 

jira gen key

```

docker exec jira-srv java -jar /var/agent/atlassian-agent.jar \
    -p jira \
    -m admin@gmail.com \
    -n admin@gmail.com \
    -o http://127.0.0.1:8080 \
    -s BOQU-95EE-NRW6-AQDG

```

confluence gen key

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
    -p conf \
    -m admin@gmail.com \
    -n admin@gmail.com \
    -o http://127.0.0.1:8090 \
    -s 202
```

Jira Service Management gen key

```
docker exec servicedesk-srv java -jar /var/agent/atlassian-agent.jar \
    -p jsm \
    -m admin@gmail.com \
    -n admin@gmail.com \
    -o http://127.0.0.1:8088 \
    -s B2HH-EQYK-LLV9-EPN8
```
crowd gen Key
```
docker exec crowd-srv java -jar /var/agent/atlassian-agent.jar \
    -p crowd \
    -m admin@gmail.com \
    -n admin@gmail.com \
    -o http://127.0.0.1:8095 \
    -s B2I1-UBWR-5ZN6-XHY5
```

### Cầu hình domain 

Để cấu hình doamin thì vào file server.xml trong thư mục tương ứng để sửa đổi thông tin theo yêu cầu của bạn, bạn nên dùng nginx manager proxy là proxy để dễ dàng quản lý máy chủ, tùy vào bạn muốn dùng https hay http mà bỏ comment phần connet tương ứng, lưu ý phần Connector mặc định cần được comment lại hoặc loại bỏ để tránh xung độ

| Phần mềm     | File Config   |
| ------------ | ---------    |
| confluence   | confluence/server.xml   |
| Jira         | Jira/server.xml   |
| Jira Service Management | servicedesk/server.xml |


Phiên bản hỗ trợ

| Phần mềm     | Version   | x86_64 | ARM | Image Dockerhub |
| ------------ | --------- | ------ | --- | --------------- |
| confluence   | 7.19.5    | Yes    | Yes | Yes             |
| jira         | 9.6.0     | Yes    | Yes | Yes             |
| Jira Service Management | 5.5.0 | Yes | No | No           |
| Crowd        | 5.1.0     | Yes    | No  | No              |


### Cấu hình bẻ khóa các plugin trên marketplace

- sau khi tải về marketplace các bạn truy cập vào  Manage apps của Jira và Confluence và chọn addon cần bẻ khóa
- Trong giao diện mới hiện ra có phần App key các bạn lấy App key này để làm bước tiếp 
- để bẻ khóa addon của jira

```

docker exec jira-srv java -jar /var/agent/atlassian-agent.jar \
    -p < thay App key của bạn vào đây > \
    -m admin@gmail.com \
    -n admin@gmail.com \
    -o http://127.0.0.1:8080 \
    -s BOQU-95EE-NRW6-AQDG

```

- để bẻ khóa addon của confluence

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
    -p < thay App key của bạn vào đây > \
    -m admin@gmail.com \
    -n admin@gmail.com \
    -o http://127.0.0.1:8090 \
    -s 202
```


- để bẻ khóa addon của Jira Service Management

```
docker exec servicedesk-srv java -jar /var/agent/atlassian-agent.jar \
    -p < thay App key của bạn vào đây > \
    -m admin@gmail.com \
    -n admin@gmail.com \
    -o http://127.0.0.1:8090 \
    -s 202
```

- để bẻ khóa addon của crowd

```
docker exec servicedesk-srv java -jar /var/agent/atlassian-agent.jar \
    -p < thay App key của bạn vào đây > \
    -m admin@gmail.com \
    -n admin@gmail.com \
    -o http://127.0.0.1:8090 \
    -s 202
```


### sửa lỗi không lưu được bài trên confluence arm

Đầu tiên truy cập vào General Configuration  >  Collaborative editing trong cài đặt chuyển Collaborative editing của Editing mode về thành off. Quay lại trang chủ bạn có thể đăng bài bình thường tuy nhiên sẽ mất tính năng autosvae, các bạn phải thao tác lưu thủ công