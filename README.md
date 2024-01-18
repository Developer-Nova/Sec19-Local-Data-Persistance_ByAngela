# 📑 Local Data Persistance - User Defaults, Core Data and Realm

iOS에서 데이터를 저장하는 방법을 이해하기 위해 다양한 선택 사항을 살펴보고 UserDefaults, Core Data 및 Realm을 사용하는 방법을 학습했습니다.

## Index
- [Team](#-Team)
- [Project](#-Project)
- [Learn About](#-Learn%About)
- [Library](#-Library)

## ✅ Team
|**Nova**|
|--------|
|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/17a2ba3b-a618-4ac8-93b9-0d0e02c19c78" width="110" height="110">|
|[Nova's GitHub](https://github.com/Developer-Nova)|


## ✅ Project
### Todoey
모든 작업을 추적하는 할일 목록 앱 입니다.

|Add New Category|Delete Category|Check Mark|Search Category|
|----|----|----|----|
|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/fc50561e-82a8-4e8f-93f3-496a179ac024" width="210" height="440">|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/8f805d5b-4944-42ec-96ae-5abff6dcb753" width="210" height="440">|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/c3069631-6cc1-4e37-8b3c-377e90732fab" width="210" height="440">|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/b8fe31e1-3a89-4e57-9c42-4df0404079bf" width="210" height="440">|

## ✅ Learn About

### UserDefaults
앱 실행 시 지속적으로 키-값 쌍을 저장하는 사용자의 기본 데이터베이스에 대한 인터페이스입니다.
~~~ swift
class UserDefaults : NSObject
~~~

#### UserDefaults 파일 경로
~~~ swift
NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String
~~~

> [UserDefaults Document](https://developer.apple.com/documentation/foundation/userdefaults/)

***

### CoreData

~~~ swift
~~~

***

## ✅ Library

### Realm

#### Realm 파일 경로
~~~ swift
Realm.Configuration.defaultConfiguration.fileURL
~~~

### SwipeCellKit

