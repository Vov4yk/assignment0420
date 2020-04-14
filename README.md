# Test assignment
#### 04/2020

### Requirements
https://gist.github.com/soxjke/2f5e3b1d1b0ca560dbe18df6144195f4

### Installation
Run `Tons.xcworkspace`
No additional instalation needed. It's treated as production release. Therefore there is Pods included in that repository.

### Features
- Product's list:
  - Shows product's collection(image, name and price)
  - API fetch 
  - Paging
  - Selectable. Adds new product into cart. If product already is in the cart increases it's quantity. User is notified by cart's badge that cart is change
  - Image lazy load
  - Image placeholder
  - Abaptable UI
- Cart:
  - Shows cart's items
  - API fetch
  - API update
  - Changes a product's quantity.
  - Removes product from the cart if quantity is zero
  - Resets cart's badge
  - Use `identifierForVendor` as cart id. Cart `DO NOT` survive application reinstall. It's simplification coz iOS simulator won't work with `DeviceCheck API`
 
- API
  - Cancalable POST requests
  - Pagination
  - Flexible request configuration
  - Flexible host configuration
 
- Testability
  - Basic preparation for Unit Tests. Model can moved into module. Public protocols presented.
  
### Tech

* [CocoaPods] - Dependency manager
* [Alamofire] - Common networking library. Manage requests and it's canceling 
* [AlamofireImage] - Image lazy loading
* [MVC] - Basic Apple's MVC arcitecture has been choosen. It's quite simple and quick solution for that kind of project. NotificationCenter is used as main source of Model->Controller communication. It's old(before SwiftUI) [Apple's recomendations](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html). It's implementation should demonstrate basic iOS developing skils.
* [storyboards UI] - The fastest way to implement UI. should demonstrate deep knowlage in impleneting UI with storyboadrs.

### Todos
 - Unit Tests.
   - Cover model's public protocols ~4h
   - Cover model's internal methods ~4h
   - Cover ViewControllers
   - Run to 100% coverage
 - UI
   - Optimistic UI features
   - Empty states
   - Prodgress indication
   - Pull to Refresh
   - Error handling
 
### Spent
  - developmention ~13h
  - docomentation ~2h
