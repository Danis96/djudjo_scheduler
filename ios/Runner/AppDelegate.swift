import AVFoundation
import UIKit
import Flutter
import GoogleMaps
import CoreMotion
import CoreLocation
import CoreBluetooth
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    @StorageWrapper(key: "hasBeenLaunchedBeforeFlag", defaultValue: false)
    var hasBeenLaunchedBeforeFlag: Bool
    var locManager: CLLocationManager!
    var centralManager: CBCentralManager?
    var peripheral: CBPeripheral?
    var result: FlutterResult!
    var methodName: String = ""
    var initChannel = FlutterMethodChannel()
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if isFirstLaunch() {
            UserDefaults.standard.removeObject(forKey: "hasSetLocation")
        }
        
        FirebaseApp.configure()
        
        _ = DrivingManager.shared
        
        locManager = CLLocationManager()
        locManager.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(_motionActivityPermissionChanged(_:)), name: NSNotification.Name(rawValue: MOTION_ACTIVITY_PERMISSION_CHANGED),

        object: nil)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(_bluetoothStateChanged(_:)),
        name: .bluetoothStateChanged,
        object: nil)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(_bluetoothStartRefreshing(_:)),
        name: .bluetoothStartRefreshing,
        object: nil)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(_bluetoothEndRefreshing(_:)),
        name: .bluetoothEndRefreshing,
        object: nil)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(_bluetoothDeviceConnected(_:)),
        name: .bluetoothSensorDeviceConnectedd,
        object: nil)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(_bluetoothDeviceDisconnected(_:)),
        name: .bluetoothSensorDeviceDisconnected,
        object: nil)

        GMSServices.provideAPIKey(Constants.GMSServiceAPIKey)
        locManager = CLLocationManager()
        locManager.delegate = self
        
        GeneratedPluginRegistrant.register(with: self)
        //FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
        let controller = self.window.rootViewController as! FlutterViewController
        callMethod(controller: controller)
        initChannel = FlutterMethodChannel.init(name: "com.amodo.mobility", binaryMessenger: controller.binaryMessenger)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }
    
    @objc private func _motionActivityPermissionChanged(_ notification: Notification) {
        if result != nil {
            result(DrivingManager.hasMotionPermission)
        }
    }
    
    @objc private func _bluetoothStateChanged(_ notification: Notification) {
        initChannel.invokeMethod("bluetoothStateChanged", arguments: nil)
    }
    
    @objc private func _bluetoothStartRefreshing(_ notification: Notification) {
        if DrivingManager.isBluetoothAvailable {
            if result != nil {
                result(true)
            }
        }
        
    }
    
    @objc private func _bluetoothEndRefreshing(_ notification: Notification) {
        if DrivingManager.isBluetoothAvailable {
            if result != nil {
                result(true)
            }
        }
    }
    
    @objc private func _bluetoothDeviceConnected(_ notification: Notification) {
        initChannel.invokeMethod("bluetoothDeviceConnected", arguments: nil)
    }
    
    @objc private func _bluetoothDeviceDisconnected(_ notification: Notification) {
        initChannel.invokeMethod("bluetoothDeviceDisconnected", arguments: nil)
    }
}

//private func registerPlugins(registry: FlutterPluginRegistry) {
//    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
//        FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
//    }
//}

extension AppDelegate {
    
    private func callMethod(controller: FlutterViewController) {
    
        initChannel = FlutterMethodChannel.init(name: "com.amodo.mobility", binaryMessenger: controller.binaryMessenger)
        
        initChannel.setMethodCallHandler { (call, result) in
            self.result = result
            let dict = call.arguments as? [String: Any] ?? [:]
            let value = dict["value"] as? Bool ?? false
            self.methodName = call.method
            
            switch call.method {
            case "instantiateSDK":
                DrivingManager.shared.setDefaultValuesForSDK()
                let driverId = dict["driverId"] as? Int ?? 0
                let driverToken = dict["driverToken"] as? String ?? ""
                let vehicleId = dict["vehicleId"] as? String ?? ""
                DrivingManager.shared.setApiParameterss(driverId: String(driverId), driverToken: driverToken, vehicleId: vehicleId, serverHost: Constants.serverHost)
                
            case "logoutNative":
                UserDefaults.standard.removeObject(forKey: "hasSetLocation")
                DrivingManager.shared.clearAllUserData()
                
            case "sensorsLocation":
                DrivingManager.requestLocationPermission()
                
            case "hasLocationPermission":
                let locationState = DrivingManager.shared.hasLocationPermission()
                result(locationState)
                
            case "hasNotificationPermission":
                let notificationState = DrivingManager.shared.hasNotificationPermission()
                result(notificationState)
                
            case "hasActivityPermission":
                let motionState = DrivingManager.shared.hasMotionPermission()
                result(motionState)
                
            case "isTripRecording":
                let recordingState = DrivingManager.shared.isRecording
                result(recordingState)
                
            case "activity":
                self.checkMotionStatus()
                UserDefaults.standard.set(true, forKey: "hasSetMotion")
                
            case "checkActivity":
                result(DrivingManager.hasMotionPermission ?? false)
                
            case "notification":
                DrivingManager.requestNotificationPermission()
                
            case "camera":
                self.checkCameraAuthorizationStatus()
                
            case "bluetooth":
                DrivingManager.shared.requestBluetoothPermission()
                
            case "locationWhileInUseType":
                DrivingManager.requestLocationPermission()
            case "locationAlwaysType":
                DrivingManager.requestAlwaysLocationPermission()
                UserDefaults.standard.set(true, forKey: "hasSetLocation")
                
            case "motionType":
                DrivingManager.requestMotionPermission()
                
            case "notificationType":
                DrivingManager.requestNotificationPermission()
                
            case "startRecordingType":
                if CLLocationManager.authorizationStatus() == .authorizedAlways {
                    if value && !DrivingManager.shared.isRecording {
                        DrivingManager.shared.startRecording()
                        result(true)
                    } else {
                        DrivingManager.shared.stopRecording()
                        result(false)
                    }
                } else {
                    result(false)
                }
                
            case "startAutomaticRecording":
                DrivingManager.shared.startActivityTracking()
                
            case "automaticStartRecordingType":
                DrivingManager.shared.autorecordingEnabled = value
                
            case "automaticStopRecordingType":
                DrivingManager.shared.autoStopRecordingEnabled = value
                
            case "highPowerModeType":
                DrivingManager.shared.highPowerMode = value
                
            case "onlyWifiUploadType":
                DrivingManager.shared.setWifiUploadOnly(wifiUploadOnly: value)
                
            case "rawSensorsCollectionType":
                DrivingManager.shared.rawSensorsCollectionEnabled = value
                
            case "sensingSensorsCollectionType":
                DrivingManager.shared.sensingSensorsCollection = value
                
            case "uploadDrives":
                DrivingManager.shared.uploadQueuedTrips()
                
            case "clearAllDrives":
                DrivingManager.shared.clearAllDrives()
                
            case "scanBeacons":
                let alert = UIAlertController(title: "Start beacon scanning", message: "After you press OK the app will scan for beacons for 30 seconds", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    DrivingManager.shared.setBeaconScanning(enabled: true)
                })
                controller.present(alert, animated: true, completion: nil)
                
            case "checkForBluetoothAvailablity":
                result(DrivingManager.isBluetoothAvailable)
                
            case "checkBluetoothIsONButNoPermission":
                let btState = DrivingManager.shared.bluetoothStateOn()
                result(btState)
                
            case "isBluetoothStateOn":
                let btOn: Bool = DrivingManager.shared.isBluetoothStateOn
                result(btOn)
                
            case "hasAskedForBTPermission":
                let state = DrivingManager.shared.hasAskedForBTPermission()
                result(state)
                
            case "startScanning":
                DrivingManager.shared.startScanForConnectedDevices()
                
            case "stopScanning":
                NotificationCenter.default.post(name: .bluetoothEndRefreshing, object: nil)
                
            case "getConnectedBluetoothDevices":
                var returnValue: Array<Dictionary<String, AnyObject>> = []
                let devices: [BluetoothDeviceCustom] = DrivingManager.shared.connectedBluetoothDevices
                var dict = [String: AnyObject]()
                for device in devices {
                    dict["name"] = device.name as AnyObject?
                    dict["uuid"] = device.uuid as AnyObject?
                    returnValue.append(dict)
                }
                result(returnValue)
                
            case "pairBluetoothDevice":
                let uuid = dict["uuid"] as? String ?? ""
                DrivingManager.shared.connectToBluetoothNetwork(networkUUID: uuid)
                result(DrivingManager.shared.connectedCarNetworkName() ?? "")
                
            case "checkForPairedBluetoothDevices":
                result(DrivingManager.shared.connectedCarNetworkName() ?? "")
                
            case "unPairBluetoothDevice":
                DrivingManager.shared.disconnectFromBluetooth()
                //DrivingManager.shared.connectToBluetoothNetwork(networkUUID: "")
                result(DrivingManager.shared.connectedCarNetworkName() ?? "")
                
            case "isBluetoothDevicePairedAndConnected":
                result(DrivingManager.isBluetoothDeviceConnected)
                
            case "setShowNotifications":
                let show = dict["showNotifications"] as? Bool ?? false
                DrivingManager.shared.setRecordingNotification(enabled: show)
                
            default:
                break
            }
        }
        
    }
    
    private func isFirstLaunch() -> Bool {
        let isFirstLaunch = !hasBeenLaunchedBeforeFlag
        if isFirstLaunch {
            hasBeenLaunchedBeforeFlag = true
        }
        return isFirstLaunch
    }
    
}

// MARK: Bluetooth Status
extension AppDelegate: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if #available(iOS 13.0, *) {
            switch central.authorization {
            case .allowedAlways:
                if result != nil {
                    result(true)
                }
            default:
                if result != nil {
                    result(false)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
}

// MARK: Location Status
extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            if result != nil {
                if UserDefaults.standard.bool(forKey: "hasSetLocation") {
                    result(true)
                } else {
                    DrivingManager.requestAlwaysLocationPermission()
                    UserDefaults.standard.set(true, forKey: "hasSetLocation")
                }
            }
        case .denied:
            if result != nil {
                UserDefaults.standard.set(false, forKey: "hasSetLocation")
                result(false)
            }
        default:
            if result != nil {
                UserDefaults.standard.set(false, forKey: "hasSetLocation")
                result(false)
            }
        }
    }
}

// MARK: Notification Status
extension AppDelegate {
    
    private func checkNotificationsAuthorizationStatus() {
        let userNotificationCenter = UNUserNotificationCenter.current()
        
        userNotificationCenter.getNotificationSettings { [weak self] (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                userNotificationCenter.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, _) in
                    if self?.result != nil {
                        self?.result(granted)
                    }
                }
            default:
                if self?.result != nil {
                    self?.result(true)
                }
                
            }
        }
    }
    
}

// MARK: Camera Status
extension AppDelegate {
    
    private func checkCameraAuthorizationStatus() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: .video) { [weak self] (granted) in
                    if self?.result != nil {
                        self?.result(granted)
                    }
                }
            }
        } else {
            if self.result != nil {
                self.result(true)
            }
        }
    }
}

// MARK: Motion Status
extension AppDelegate {
    
    private func checkMotionStatus() {
        if CMMotionActivityManager.isActivityAvailable() {
            if #available(iOS 11.0, *) {
                if CMMotionActivityManager.authorizationStatus() == .notDetermined {
                    let manager = CMMotionActivityManager()
                    let today = Date()
                    manager.queryActivityStarting(from: today, to: today, to: OperationQueue.main, withHandler: { (activities: [CMMotionActivity]?, error: Error?) -> () in
                        if error != nil {
                            let errorCode = (error! as NSError).code
                            if errorCode == Int(CMErrorMotionActivityNotAuthorized.rawValue) || errorCode == Int(CMErrorMotionActivityNotAvailable.rawValue) {
                                if self.result != nil {
                                    self.result(false)
                                }
                            }
                        } else {
                            if self.result != nil {
                                self.result(true)
                            }
                        }
                        manager.stopActivityUpdates()
                    })
                } else {
                    if self.result != nil {
                        self.result(true)
                    }
                }
            }
        }
    }
    
}

