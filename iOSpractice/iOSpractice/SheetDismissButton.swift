//
//  SheetDismissButton.swift
//  iOSpractice
//
//  Created by 下村蒔里萌 on 2023/02/11.
//

import SwiftUI

struct SheetDismissButton: View {
  @Binding var isPresented: Bool
  var body: some View {
    NavigationView {
      VStack {
        Image(systemName: "ladybug")
      }
    }
  }
}

struct SheetDismissButton_Previews: PreviewProvider {
  static var previews: some View {
    @State var isShow: Bool = false
    
    var body: some View {
      SheetDismissButton()
    }
  }
}
