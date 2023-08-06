### Info

Đây là bản mới nhất của jira và confluence đã được cấu hình hoàn chỉnh các bạn cần mua key để được sử dụng

Mua key sử dụng  liên hệ qua 

Telegram: [@vouuvhb](https://t.me/vouuvhb)

Facebook: [fb.me/vouuvhb](https://fb.me/vouuvhb)

Email: contact@connect.manhtuong.net


Bảng giá

| Công Việc     | Giá        | Ghi Chú |
| ------------  | ----------- | ------- |
| Cài đặt       |    500k/lần  | Cài đặt phần mềm + crack không giới hạn user |
| Crack Plugin  | 200k/plugin     | Cài đặt và kích hoạt plugin không giới hạn user |


Để dùng được phần mềm thì bạn cần phải cài Docker và docker-compose trên máy trước khi bắt đầu quá trình cài đặt Jira vs Confluence

 
### Build image

#### Build image & run cho x86_64

```
git clone https://github.com/vncloudsco/confluence.git
cd confluence
docker-compose -f docker-compose-build.yaml build
docker-compose -f docker-compose-build.yaml up -d
``` 
#### Build image & run cho ARM

```
git clone https://github.com/vncloudsco/confluence.git
cd confluence
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

### Cầu hình domain 

Để cấu hình doamin thì vào file server.xml trong thư mục tương ứng để sửa đổi thông tin theo yêu cầu của bạn, bạn nên dùng nginx manager proxy là proxy để dễ dàng quản lý máy chủ, tùy vào bạn muốn dùng https hay http mà bỏ comment phần connet tương ứng, lưu ý phần Connector mặc định cần được comment lại hoặc loại bỏ để tránh xung độ

| Phần mềm     | File Config   |
| ------------ | ---------    |
| confluence   | confluence/server.xml   |
| Jira         | Jira/server.xml   |
| Jira Service Management | servicedesk/server.xml |


Phiên bản hỗ trợ

| Phần mềm     | Version   | x86_64 | ARM |
| ------------ | --------- | ------ | --- |
| confluence   | 7.19.5    | Yes    | Yes |
| jira         | 9.6.0     | Yes    | Yes |
| Jira Service Management | 5.5.0 | Yes | No |
| Crowd        | 5.1.0     | Yes    | No  | 




### sửa lỗi không lưu được bài trên confluence arm

Đầu tiên truy cập vào General Configuration  >  Collaborative editing trong cài đặt chuyển Collaborative editing của Editing mode về thành off. Quay lại trang chủ bạn có thể đăng bài bình thường tuy nhiên sẽ mất tính năng autosvae, các bạn phải thao tác lưu thủ công!