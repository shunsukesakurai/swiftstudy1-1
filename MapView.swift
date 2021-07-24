//
//  MapView.swift
//  MyMap
//
//  Created by saku on 2021/07/07.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let searchKey:String
    let mapType: MKMapType
    
    // ↓makeUIViewは最初のView描画時に一度だけ実行される
    func makeUIView(context:Context)->MKMapView{
        MKMapView()//MKMapViewオブジェクトを作ってreturnもしてる（処理内容がreturnだけの場合、returnは省略できる）
    }
    // ↓はアプリの状態変化時に実行される
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print(searchKey)//入力された内容をデバッグエリアに表示する
        uiView.mapType = mapType
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchKey, completionHandler: {(placemarks,error) in
            if let unwrapPlacemarks=placemarks,
               let firstPlacemark = unwrapPlacemarks.first,
               let location = firstPlacemark.location{
                let targetCoordinate=location.coordinate
                print(targetCoordinate)//デバッグ用だけど、今はまだ動かないっぽい
                let pin = MKPointAnnotation()
                pin.coordinate=targetCoordinate
                pin.title=searchKey
                uiView.addAnnotation(pin)
                uiView.region=MKCoordinateRegion(
                    center:targetCoordinate,
                    latitudinalMeters:500.0,
                    longitudinalMeters:500.0)
                
            }

        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "東京タワー",mapType: .standard)
    }
}
