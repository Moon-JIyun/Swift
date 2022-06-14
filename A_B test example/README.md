# A/B Test

- Firebase 를 활용한 A/B Test
- remoteConfig 를 이용해 실시간 공지사항, 이벤트 등 팝업을 구현 할 수 있음
- Analytics 를 통해 이벤트 로그를 수집하여 분석 가능.

```
func showEventAlert() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] status, _ in
            if status == .success {
                remoteConfig.activate(completion: nil)
            }else {
                print("Config not fetched")
            }
            let message = remoteConfig["message"].stringValue ?? ""
            
            let confirmAction = UIAlertAction(title: "확인하기", style: .default) { _ in
                // Google Analytics
                Analytics.logEvent("promotion_alert", parameters: nil)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let alertController = UIAlertController(title: "깜짝 이벤트", message: message, preferredStyle: .alert)
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self?.present(alertController, animated: true, completion: nil)
        }
        
```
    
