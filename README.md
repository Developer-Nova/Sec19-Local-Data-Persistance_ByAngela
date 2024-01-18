# 📑 Local Data Persistance - User Defaults, Core Data and Realm

**iOS에서 데이터를 저장하는 방법을 이해하기 위해 다양한 선택 사항을 살펴보고 UserDefaults, Core Data 및 Realm 을 사용하는 방법을 학습했습니다.**

## Index
- [Team](#-Team)
- [Project](#-Project)
- [Learn About](#-Learn-About)
- [Library](#-Library)

## 🔥 Team
|**Nova**|
|--------|
|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/17a2ba3b-a618-4ac8-93b9-0d0e02c19c78" width="110" height="110">|
|[Nova's GitHub](https://github.com/Developer-Nova)|


## 🔥 Project
### ✅ Todoey
모든 작업을 추적하는 할일 목록 앱 입니다.

|Add New Category|Delete Category|Check Mark|Search Category|
|----|----|----|----|
|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/fc50561e-82a8-4e8f-93f3-496a179ac024" width="210" height="440">|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/8f805d5b-4944-42ec-96ae-5abff6dcb753" width="210" height="440">|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/c3069631-6cc1-4e37-8b3c-377e90732fab" width="210" height="440">|<img src="https://github.com/Developer-Nova/Sec19-Local-Data-Persistance_ByAngela/assets/123448121/b8fe31e1-3a89-4e57-9c42-4df0404079bf" width="210" height="440">|

## 🔥 Learn About

### ✅ UserDefaults
앱 실행 시 지속적으로 키-값 쌍을 저장하는 사용자의 기본 데이터베이스에 대한 인터페이스 입니다.
~~~ swift
class UserDefaults : NSObject
~~~

#### UserDefaults 파일 경로
~~~ swift
let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String
~~~

> [UserDefaults Document](https://developer.apple.com/documentation/foundation/userdefaults/)

***

### ✅ CoreData
CloudKit을 사용하여 단일 장치에서 데이터를 유지 또는 캐시하거나 데이터를 여러 장치에 동기화 할 수 있는 프레임워크 입니다. 
~~~ swift
import CoreData
~~~

#### CoreData 파일 경로
~~~ swift
let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
~~~

> [Core Data Document](https://developer.apple.com/documentation/coredata/)

***

## 🔥 Library

### ✅ Realm
Realm 은 무료로 제공되는 데이터베이스 라이브러리 입니다.

- SQLite와 CoreData 보다 작업 속도가 빠릅니다.
- Cross Platform 을 지원해서 안드로이드 OS와 DB 파일을 공유할 수 있습니다.
- Realm Studio, Realm Browser 를 통해서 DB 상태를 편하게 확인할 수 있습니다.
- 직관적인 코드로 작업할 수 있습니다.
- Rx 를 지원하는 RxRealm 이 존재 합니다.

#### Realm 파일 경로
~~~ swift
let paths = Realm.Configuration.defaultConfiguration.fileURL
~~~

#### Realm 데이터베이스 접근

~~~ swift
let realm = try! Realm()
~~~

#### 데이터 저장 모델
~~~ swift
import RealmSwift

// Category 데이터 저장 객체
final class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}

// Item 데이터 저장 객체
final class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
~~~

#### Create

~~~ swift
let category = Category()

try! realm.write { 
    realm.add(category)
}
~~~

#### Read

~~~ swift
let allCategory = realm.objects(Category.self)
~~~

#### Update

~~~ swift
let update = categories[0]

try! realm.write {
    update.name = "Home"
}
~~~

#### Delete

~~~ swift
var categories: Results<Category>?

if let categoryForDeletion = categories?[indexPath.row] {
    do {
        try realm.write {
            realm.delete(categoryForDeletion)
        }
    } catch {
        print(error)
    }
}
~~~

> [Realm.io: Realm Home](https://realm.io/)
> [Realm-Swift Repo](https://github.com/realm/realm-swift)

***

### ✅ SwipeCellKit
SwipeCellKit 은 `UITableViewCell` 다음 `UICollectionViewCell`을 지원하는 스와이프 라이브러리 입니다.

- 왼쪽 및 오른쪽 스와이프 동작 
- 작업 버튼: 텍스트만, 이미지만, 텍스트 + 이미지
- 햅틱 피드백
- 사용자 정의 가능한 전환: 테두리, 드래그 및 표시
- 스와이프하는 동안 사용자 정의 가능한 작업 버튼 동작
- 임계값을 지나 드래그할 때 애니메이션 확장
- 맞춤설정 가능한 확장 애니메이션
- 다크 모드

#### 사용방법

- SwipeTableViewCellDelegate 프로토콜 채택 
~~~ swift
import SwipeCellKit

class ViewController: UITableViewDataSource, SwipeTableViewCellDelegate { }
~~~

- `UITableViewDataSource` 프로토콜의 `cellForRowAt` 메서드 구현
~~~ swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
    cell.delegate = self
    return cell
}
~~~

- `editActionsForRowAt` 메서드에서 스와이프 방향과 `SwipeAction` 을 통해 스타일과 타이틀 등을 설정
~~~ swift
func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    guard orientation == .right else { return nil }

    let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
        // handle action by updating model with deletion
    }

    // customize the action appearance
    deleteAction.image = UIImage(named: "delete")

    return [deleteAction]
}
~~~

- `editActionsOptionsForRowAt` 선택적으로 스와이프 동작의 동작을 맞춤설정하는 메서드를 구현
~~~ swift
func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
    var options = SwipeOptions()
    options.expansionStyle = .destructive
    options.transitionStyle = .border
    return options
}
~~~

> [SwipeCellKit Repo](https://github.com/SwipeCellKit/SwipeCellKit)
