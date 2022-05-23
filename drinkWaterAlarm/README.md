# 물 마시기 알람 앱

- Local Notification 을 사용하여 알림 구현
- Trigger 의 형태가 제한적 ( Calander, Time Interval, Location ) 
- 물 마시기 알람 앱의 경우 Calander Trigger 를 사용해 구현함.

> 구현 과정 중 발생한 문제점 : </br> AppDelegate 에서 알림 허용 요청을 구현하였으나, 정상작동하지 않음.

> 해결 방법 : </br> Viewcontroller 의 viewdidload 에서 알림 허용 권한 요청 진행 후 알림이 정상 작동함.
 


<img src="https://user-images.githubusercontent.com/55011765/169848741-2fe16a38-a0f3-4063-be25-3a8f76c20353.gif" width="200" height="400"/>
