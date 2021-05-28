//
//  ShopViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/29.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import MapKit
import PINRemoteImage
import RxSwift

class ShopViewController:
    UIViewController,
    CLLocationManagerDelegate,
    MKMapViewDelegate,
    UITableViewDataSource,
    UITableViewDelegate {
    
    private var map: MKMapView!
    
    private var tableView: UITableView!
    
    private var locationManager: CLLocationManager!
    
    private var viewModel: ShopViewModel!
    
    private var menuItem: MenuItem!
    
    private var shopList: [Shop]!
    
    init(menuItem: MenuItem!) {
        super.init(nibName: nil, bundle: nil)
        viewModel = ShopViewModel()
        self.menuItem = menuItem
        self.shopList = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "どちらの店舗で受け取りますか"
        
        let salg = view.safeAreaLayoutGuide
        
        var itemView: UIView! = nil
        if menuItem != nil {
            itemView = UIView()
            itemView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(itemView)
            itemView.widthAnchor.constraint(equalTo: salg.widthAnchor).isActive = true
            //itemView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            itemView.topAnchor.constraint(equalTo: salg.topAnchor).isActive = true
            itemView.leadingAnchor.constraint(equalTo: salg.leadingAnchor).isActive = true
            itemView.trailingAnchor.constraint(equalTo: salg.trailingAnchor).isActive = true
            
            let itemImage = UIImageView()
            itemImage.translatesAutoresizingMaskIntoConstraints = false
            itemImage.pin_setImage(from: URL(string: menuItem.imageUrl))
            itemView.addSubview(itemImage)
            itemImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
            itemImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
            itemImage.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 5).isActive = true
            itemImage.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 10).isActive = true
            itemImage.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -5).isActive = true
            
            let itemName = UILabel()
            itemName.translatesAutoresizingMaskIntoConstraints = false
            itemName.text = menuItem.name
            itemView.addSubview(itemName)
            itemName.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 10).isActive = true
            itemName.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10).isActive = true
            itemName.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -10).isActive = true
            
            let itemPrice = UILabel()
            itemPrice.translatesAutoresizingMaskIntoConstraints = false
            let itemPriceMas = NSMutableAttributedString()
            itemPriceMas.append(NSAttributedString(
                                    string: "¥",
                                    attributes: [
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
                                    ]))
            itemPriceMas.append(NSAttributedString(
                                    string: Formatter.formatForPrice(number: menuItem.price),
                                    attributes: [
                                        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
                                    ]))
            itemPrice.attributedText = itemPriceMas
            view.addSubview(itemPrice)
            itemPrice.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 5).isActive = true
            itemPrice.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10).isActive = true
            itemPrice.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -10).isActive = true
            
        }
        
        map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        map.userTrackingMode = MKUserTrackingMode.followWithHeading
        view.addSubview(map)
        map.heightAnchor.constraint(equalToConstant: 200).isActive = true
        map.topAnchor.constraint(equalTo: itemView != nil ? itemView.bottomAnchor : salg.topAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: salg.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: salg.trailingAnchor).isActive = true
        
        tableView = UITableView()
        tableView.backgroundColor = .cyan
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(ShopTableViewCell.self, forCellReuseIdentifier: "ShopTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: 0).isActive = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("このユーザーはこのアプリケーションに関してまだ選択を行っていません。")
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied:
            print("ロケーションサービスの設定が「無効」になっています。")
            break
        case .restricted:
            print("このアプリケーションは位置情報サービスを使用できません。")
            break
        case .authorizedAlways:
            print("常時、位置情報の取得が許可されています。")
            break
        case .authorizedWhenInUse:
            print("起動時のみ、位置情報の取得が許可されています。")
            break
        }
    }
    
    func deployCurPosAndShopAno(location: CLLocation) {
        let span = MKCoordinateSpan(
            latitudeDelta: 0.02,
            longitudeDelta: 0.02)
        let region = MKCoordinateRegion(
            center: location.coordinate,
            span: span)
        self.map.setRegion(region, animated: true)
        viewModel.getShop(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude,
            query: "マクドナルド")
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { shopList in
                    self.shopList = shopList
                    self.tableView.reloadData()
                    self.map.removeAnnotations(self.map.annotations)
                    for shop in shopList {
                        let shopPin = ShopPointAnnotation()
                        shopPin.coordinate = CLLocationCoordinate2DMake(
                            CLLocationDegrees(shop.lat),
                            CLLocationDegrees(shop.lon))
                        shopPin.name = shop.name
                        self.map.addAnnotation(shopPin)
                    }
                    print("===ShopViewController next===")
                },
                onError: { error in
                    print("===ShopViewController error===")
                    print(error)
                },
                onCompleted: {
                    print("===ShopViewController completed===")
                },
                onDisposed: {
                    print("===ShopViewController disposed===")
                })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let location = locations[0]
            print("緯度:\(location.coordinate.latitude) 経度:\(location.coordinate.longitude)")
            deployCurPosAndShopAno(location: location)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print(annotation)
        
        if annotation is MKUserLocation {
            return nil
        } else if annotation is ShopPointAnnotation {
            let shopPointAnnotation = annotation as! ShopPointAnnotation
            let reuseID = "pin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
            var shopDetailCalloutAccessoryView: ShopDetailCalloutAccessoryView? = nil
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
                shopDetailCalloutAccessoryView = ShopDetailCalloutAccessoryView()
                pinView?.detailCalloutAccessoryView = shopDetailCalloutAccessoryView
                pinView?.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure)
            } else {
                pinView?.annotation = annotation
                shopDetailCalloutAccessoryView = pinView?.detailCalloutAccessoryView as? ShopDetailCalloutAccessoryView
            }
            pinView?.canShowCallout = true
            shopDetailCalloutAccessoryView?.name.text = shopPointAnnotation.name
            return pinView
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control == view.rightCalloutAccessoryView) {
            // 吹き出しを閉じる。
            mapView.deselectAnnotation(view.annotation, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell", for: indexPath) as! ShopTableViewCell
        let shop = shopList[indexPath.row]
        cell.stateLabel.text = "営業中"
        let stateStr = NSMutableAttributedString()
        stateStr.append(NSAttributedString(
                            string: "営業中",
                            attributes: [
                                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
                            ]))
        cell.stateLabel.attributedText = stateStr
        let distStr = NSMutableAttributedString()
        distStr.append(NSAttributedString(
                        string: String(shop.dist) + "m",
                        attributes: [
                            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
                        ]))
        cell.distLabel.attributedText = distStr
        let nameStr = NSMutableAttributedString()
        nameStr.append(NSAttributedString(
                        string: shop.name,
                        attributes: [
                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)
                        ]))
        cell.nameLabel.attributedText = nameStr
        let addressStr = NSMutableAttributedString()
        addressStr.append(NSAttributedString(
                        string: shop.address,
                        attributes: [
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
                        ]))
        cell.addressLabel.attributedText = addressStr
        let stationStr = NSMutableAttributedString()
        stationStr.append(NSAttributedString(
                        string: shop.station,
                        attributes: [
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
                        ]))
        cell.stationLabel.attributedText = stationStr
        let railwayStr = NSMutableAttributedString()
        railwayStr.append(NSAttributedString(
                        string: shop.railway,
                        attributes: [
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
                        ]))
        cell.railwayLabel.attributedText = railwayStr
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuOrderRootViewController = VCUtils.createMenuOrderRootViewController(
            title: shopList[indexPath.row].name,
            preOrderMenuItem: menuItem)
        self.navigationController?.pushViewController(menuOrderRootViewController, animated: true)
    }
    
}
