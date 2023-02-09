//
//  ContentView.swift
//  iOSpractice
//
//  Created by 下村蒔里萌 on 2023/02/05.
//

import SwiftUI
import MapKit

struct ContentView: View {
  // 座標の配列
  let spotlist = [
    Spot(name: "丸善", latitude: 35.6834843, longitude: 139.7644207),
    Spot(name: "八重洲ブックセンター", latitude: 35.6790079, longitude: 139.7675881),
    Spot(name: "出光美術館", latitude: 35.6780057, longitude: 139.7631035),
    Spot(name: "シエスタハコダテ", latitude: 41.7898026, longitude:  140.7519897),
    Spot(name: "公立はこだて未来大学", latitude: 41.8421184, longitude: 140.7669209)
  ]
  
  // 座標と領域を指定する
  @State var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(
      latitude: 35.6805702, // 緯度
      longitude: 139.7676359 // 軽度
    ),
    latitudinalMeters: 1000.0, // 南北距離
    longitudinalMeters: 1000.0 // 東西距離
  )
  
  // managerの更新を観測
  @ObservedObject var manager = locationManager()
  // ユーザートラッキングモード
  @State var trackingMode = MapUserTrackingMode.follow // 現在地をトラッキングするモード
  
  var body: some View {
    /*
     // 地図を表示する
     Map(coordinateRegion: $region,
     annotationItems: spotlist,
     annotationContent: { spot in
     MapAnnotation(coordinate: spot.coordinate,
     anchorPoint: CGPoint(x: 0.5, y: 0.5),
     content: {
     Image(systemName: "house.fill").foregroundColor(.pink)
     Text(spot.name).italic() // 表示するイメージやテキスト
     })}
     ).edgesIgnoringSafeArea(.bottom) // bottomのセーフティエリアを無視して表示
     */
    
    // 現在地を追従する地図を表示する
    Map(coordinateRegion: $manager.region,
        showsUserLocation: true,
        userTrackingMode: $trackingMode,
        annotationItems: spotlist,
        annotationContent: { spot in MapAnnotation(coordinate: spot.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5),
                                                   content: {
          Image(systemName: "house.fill").foregroundColor(.pink)
          Text(spot.name).italic()
        })})
    .edgesIgnoringSafeArea(.bottom)
    
    /*
    Button(action:{}){
      Text("ボタン")
        .font(.largeTitle)
        .frame(width: 280, height: 60, alignment: .center)
        .foregroundColor(Color.white)
        .background(Color.pink)
        .cornerRadius(15, antialiased: true)
    }
    */
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

// スポットの構造体
struct Spot: Identifiable {
  let id = UUID()
  let name: String
  let latitude: Double
  let longitude: Double
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}

// 現在地を取得するためのクラス
class locationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  // ロケーションマネージャを作る
  let manager = CLLocationManager()
  // 領域の更新をパブリッシュする
  @Published var region = MKCoordinateRegion()
  
  override init() {
    super.init() // 先にスーパークラスのイニシャライザ
    manager.delegate = self // デリゲートの設定
    manager.requestWhenInUseAuthorization() // プライバシー設定の確認
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.distanceFilter = 2 // 更新距離(m)
    manager.startUpdatingLocation() // 追従を開始
  }
  
  //領域の更新
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // locationの最後の要素に対して実行
    locations.last.map{ // 現在地を取得
      let center = CLLocationCoordinate2D(
        latitude: $0.coordinate.latitude,
        longitude: $0.coordinate.longitude)
      //領域の更新
      region = MKCoordinateRegion(
        center: center,
        latitudinalMeters: 100.0,
        longitudinalMeters: 100.0
      )
    }
  }
}

/* 練習
var num:Int{
 let result = 2 * 5
 return result
 }
// print(num)
 
var radius = 10.0
var num2:Double{
  get{
    let length = 2 * radius * Double.pi
    return length
  }
  set(length){
    radius = length / (2 * Double.pi)
  }
}
 
var body:some View{ // 値を代入しないリードオンリーの変数
 return Text("Hello, World!")
  .padding()
}
*/
