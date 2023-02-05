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
    Spot(latitude: 35.6834843, longitude: 139.7644207),
    Spot(latitude: 35.6790079, longitude: 139.7675881),
    Spot(latitude: 35.6780057, longitude: 139.7631035)
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
  
  var body: some View {
    // 地図を表示する
    Map(coordinateRegion: $region,
        annotationItems: spotlist,
        annotationContent: { spot in MapPin(coordinate: spot.coordinate, tint: .pink)})
      .edgesIgnoringSafeArea(.bottom) // bottomのセーフティエリアを無視して表示
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
  let latitude: Double
  let longitude: Double
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
