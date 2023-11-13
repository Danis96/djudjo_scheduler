//
//  DrivingManager.swift
//  Runner
//
//  Created by Emir Hamidovic on 11/09/2020.
//

import Foundation

enum DrivingManagerDrivingStatus {
    case started
    case stopped
    case tripUploadFinished(error: Error?)
    case allTripsUploadFinished(error: Error?)
}

extension Notification.Name {
    // Driving manager notifications
    static let recording = Notification.Name("recording")
    static let driving = Notification.Name("driving")
    static let gps = Notification.Name("gps")
    static let phoneCallStatus = Notification.Name("phoneCallStatus")
    static let proximity = Notification.Name("proximity")
    static let tripUpload = Notification.Name("tripUpload")
    static let beacons = Notification.Name("beacons")
    static let bluetooth = Notification.Name("bluetooth")
    static let bluetoothStartRefreshing = Notification.Name("bluetoothStartRefreshing")
    static let bluetoothEndRefreshing = Notification.Name("bluetoothEndRefreshing")
    static let bluetoothStateChanged = Notification.Name("bluetoothStateChanged")
    static let bluetoothSensorDeviceConnectedd = Notification.Name("bluetoothSensorDeviceConnectedd")
    static let bluetoothSensorDeviceDisconnected = Notification.Name("bluetoothSensorDeviceDisconnected")
    static let tripsUploadCount = Notification.Name("tripsUploadCount")
    // App delegate notifications
    static let pushNotificationPermissionChanged = NSNotification.Name("pushNotificationPermissionChanged")
}


final class DrivingManager: NSObject {
    
    // MARK: - Properties -
    
    static let shared = DrivingManager()
    lazy private var _mobilityAPI = MobilityAPI(delegate: self)
    private static var didManuallyStopTripWhileAutorecording = false
    
    func setApiParameterss(driverId: String, driverToken: String, vehicleId: String?, serverHost: String) {
        _mobilityAPI.setApiParameters(driverId, sharedSecret: Constants.sharedSecret, driverToken: driverToken, vehicleId: vehicleId)
        _mobilityAPI.setTripUploadURLPrefix(Constants.serverHost)
    }

    var distance: Double {
        return DrivingManager.shared._mobilityAPI.getCurrentTripDistance()
    }
    
    var driverToken: String? {
        return _mobilityAPI.getDriverToken()
    }
    
    var queuedDrivesCount: Int {
        return Int(DrivingManager.shared._mobilityAPI.numberOfUnsyncedTrips())
    }
    
    var autorecordingEnabled: Bool {
        get {
            return _mobilityAPI.isAutomaticRecordingEnabled()
        }
        set {
            _mobilityAPI.setAutoRecordingEnabled(newValue)
        }
    }
    
    var isRecording: Bool {
        return _mobilityAPI.isRecording()
    }
    
    var shouldContinueRecording: Bool {
        return self.isRecording
    }
    
    var autoStopRecordingEnabled: Bool {
        get {
            return _mobilityAPI.getAutoStopEnabled()
        }
        set {
            _mobilityAPI.setAutoStopEnabled(newValue)
        }
    }
    
    var highPowerMode: Bool {
        get {
            return _mobilityAPI.isPowerSavingMode()
        }
        set {
            _mobilityAPI.setPowerSensingEnabled(newValue)
        }
    }
    
    static var hasLocationPermission: Bool { DrivingManager.shared._mobilityAPI.hasLocationPermission()}
    static var hasNotificationPermission: Bool { DrivingManager.shared._mobilityAPI.hasNotificationPermission()}
    static var hasMotionPermission: Bool { DrivingManager.shared._mobilityAPI.hasMotionActivityPermission()}
    
    static var hasBluetoothPermission: Bool { DrivingManager.shared._mobilityAPI.hasBluetoothPermission()}
    
    static var isBluetoothAvailable: Bool { DrivingManager.shared._mobilityAPI.isBluetoothAvailableAndOn()}
    
    static var isBluetoothDeviceConnected: Bool { DrivingManager.shared._mobilityAPI.isBluetoothDeviceConnected() }
    
    static func requestLocationPermission() {
        let api = DrivingManager.shared._mobilityAPI
//        api.requestWhileLocationPermission()
        
        if api.hasAskedForLocationPermission() {
            api.openAppSettings()
        } else {
            api.requestWhileLocationPermission()
        }
    }
    
    static func requestAlwaysLocationPermission() {
        let api = DrivingManager.shared._mobilityAPI
        api.requestLocationPermission()
        
//        if api.hasAskedForLocationPermission() && UserDefaults.standard.bool(forKey: "hasSetLocation") {
//            api.openAppSettings()
//        } else {
//            api.requestLocationPermission()
//        }
    }
    
    static func requestMotionPermission() {
        let api = DrivingManager.shared._mobilityAPI
        //api.requestLocationPermission()
        
        if api.hasAskedForLocationPermission() && UserDefaults.standard.bool(forKey: "hasSetLocation") {
            api.openAppSettings()
        } else {
            api.requestLocationPermission()
            UserDefaults.standard.set(true, forKey: "hasSetLocation")
        }
    }
    
    func hasLocationPermission() -> Bool {
        let api = DrivingManager.shared._mobilityAPI
        let state = api.hasLocationPermission()
        return state;
    }
    
    func hasMotionPermission() -> Bool {
        let api = DrivingManager.shared._mobilityAPI
        let state = api.hasMotionActivityPermission()
        return state;
    }
    func hasNotificationPermission() -> Bool {
        let api = DrivingManager.shared._mobilityAPI
        let state = api.hasNotificationPermission()
        return state;
    }
    
    static func requestNotificationPermission() {
        let api = DrivingManager.shared._mobilityAPI
        //api.requestNotificationPermission()
        
        if UserDefaults.standard.bool(forKey: "hasSetNotification"){
            api.openAppSettings()
        } else {
             api.requestNotificationPermission()
        UserDefaults.standard.set(true, forKey: "hasSetNotification")
        }
    }
    
    static func requestBluetoothPermission() {
        let api = DrivingManager.shared._mobilityAPI
        api.requestBluetoothPermission()
        
//        if api.getBluetoothState() != .notAsked {
//            let state = api.getBluetoothState()
//            if state == .powerOff {
//                openGneralSettings()
//            } else if state == .unauthorized {
//                openAppSettings()
//            }
//        } else {
//            api.requestBluetoothPermission()
//        }
    }
    
    func bluetoothStateOn() -> Bool {
        let api = DrivingManager.shared._mobilityAPI
        let state = api.getBluetoothState()
        switch state {
        case .powerOff:
            return false
        case .unauthorized:
            return false
        case .powerOn:
            return true
        case .notAsked:
            return false
        @unknown default:
            return false
        }
    }
    
    func hasAskedForBTPermission() -> Bool {
        let api = DrivingManager.shared._mobilityAPI
        let state = api.getBluetoothState()
        return state != .notAsked
    }
    
    static func openAppSettings() {
        let api = DrivingManager.shared._mobilityAPI
        api.openAppSettings()
    }
    
    static func openGneralSettings() {
        let api = DrivingManager.shared._mobilityAPI
        api.openSettings()
    }
    
    func clearAllUserData() {
        _mobilityAPI.clearAllUserData()
    }
    // MARK: - Lifecycle -
    
    private override init() {
        super.init()
        _ = _mobilityAPI
    }
    
    // MARK: - Helpers -
    
    func showSendLogModal() {
        
    }
    
    func forceLoadMobilityAPI() {
        let _ = _mobilityAPI
    }
    
    func startActivityTracking() {
        _mobilityAPI.startAutomaticRecording()
    }
    
    func stopActivityTracking() {
        _mobilityAPI.stopAutomaticRecording()
    }
    
    func startRecording() {
        _mobilityAPI.startRecording()
    }
    
    func stopRecording() {
        // If autorecording is enabled, automatic trip upload should be disabled
        // because manually stopping the trip will then skip the naming screen
        if autorecordingEnabled {
            DrivingManager.didManuallyStopTripWhileAutorecording = true
        }
        
        DrivingManager.shared._mobilityAPI.stopRecording()
    }
    
    func clearAllDrives() {
        DrivingManager.shared._mobilityAPI.deleteAllUnsyncedTrips()
    }
    
    func uploadQueuedTrips() {
        DrivingManager.shared._mobilityAPI.uploadAllUnsyncedTrips()
    }
    
    func uploadTrip(named: String = "") {
        DrivingManager.shared._mobilityAPI.setCurrentTripName(named)
        DrivingManager.shared._mobilityAPI.stopRecording()
        DrivingManager.shared._mobilityAPI.uploadAllUnsyncedTrips()
    }
       
    
    func setRecordingNotification(enabled: Bool) {
        _mobilityAPI.setShowRecordingNotification(enabled)
    }
    
    func setAutorecording(enabled: Bool) {
        _setAppPreferencesForAutorecording(enabled: enabled)
    }
    
    func setDefaultValuesForSDK() {
        _mobilityAPI.setRawSensorDataCollection(false)
        _setTranslationsForMobilitySDK()
        _setAppPreferencesForAutorecording(enabled: true)
    }
    
    private func _setAppPreferencesForAutorecording(enabled: Bool) {
        _mobilityAPI.setAutoRecordingEnabled(enabled)
        _mobilityAPI.setAutoStopEnabled(enabled)
        _mobilityAPI.setAutoUploadEnabled(enabled)
        _mobilityAPI.setActivityTrackingEnabled(enabled)
        _mobilityAPI.setPowerSensingEnabled(false)
        _mobilityAPI.setMetaDataSensingEnabled(true)
        _mobilityAPI.setBluetoothTrackingEnabled(true)
        _mobilityAPI.setBatteryWarningLevel(15)
        _mobilityAPI.setUploadUsingWifiOnly(false)
        _mobilityAPI.setBeaconDetectionEnabled(true)
        _mobilityAPI.setBeaconProximityConnect(true)
        _mobilityAPI.setTagOnBeaconDetection(true)
    }
    
    private func _postDrivingNotificationWith(status: DrivingManagerDrivingStatus) {
        
        if case DrivingManagerDrivingStatus.stopped = status {
            // Nothing
        } else {
            if DrivingManager.didManuallyStopTripWhileAutorecording {
                DrivingManager.didManuallyStopTripWhileAutorecording = false
            }
        }
        
        NotificationCenter.default.post(name: .driving, object: nil, userInfo: ["status": status])
    }
    
    
    // MARK: - Bluetooth -
    
    var isBluetoothEnabled: Bool {
        return _mobilityAPI.isBluetoothAvailableAndOn()
    }
    
    var sensingSensorsCollection: Bool {
        set {
            _mobilityAPI.setSensorRecordingInSensingEnabled(newValue)
        }
        get {
            _mobilityAPI.isSensorRecordingInSensingEnabled()
        }
    }
    
    var rawSensorsCollectionEnabled: Bool {
        set {
            _mobilityAPI.setRawSensorDataCollection(newValue)
        }
        get {
            _mobilityAPI.getRawSensorDataCollection()
        }
    }
    
    func startScanForConnectedDevices() {
        _mobilityAPI.startScanForConnectedDevices()
    }
    
    var isBluetoothDeviceConnected: Bool {
        return _mobilityAPI.isBluetoothDeviceConnected()
    }
    
    var connectedBluetoothDevices: [BluetoothDeviceCustom] {
        return _mobilityAPI.getConnectedBluetoothDevices()
    }
    
    var bluetoothState: BluetoothState {
        return _mobilityAPI.getBluetoothState()
    }
    
    var isBluetoothStateOn: Bool {
        let btState: BluetoothState = _mobilityAPI.getBluetoothState()
        return btState == BluetoothState.powerOn
    }
    
    func setDefaultTripName(tripName: String) {
        _mobilityAPI.setDefaultTripName(tripName)
    }
    
    func connectToBluetoothNetwork(networkUUID: String) {
        _mobilityAPI.connectToDevice(withUUID: networkUUID)
    }
    
    func disconnectFromBluetooth() {
        _mobilityAPI.disconnectFromBluetooth()
    }
    
    func connectedCarNetworkName() -> String? {
        return _mobilityAPI.userCarBluetoothName()
    }
    
    func requestBluetoothPermission() {
        _mobilityAPI.requestBluetoothPermission()
    }
    
    // MARK: - Setup -
    
    func setup() {
        _setTranslationsForMobilitySDK()
        _resetAutorecordingValues()
    }
    
    private func _resetAutorecordingValues() {
        // If app is terminated after trip recording stopped manually and before trip naming
        // TRIP_AUTO_UPLOAD_ENABLED can stay in wrong state, so all autorecording flags should
        // be set again after init
        _setAppPreferencesForAutorecording(enabled: true)
    }
    
    private func _setTranslationsForMobilitySDK() {
        // Set localization for SDK events
        Localization.add("Recording started.", forKey: AUTO_RECORDING_STARTED_NOTIFICATION_TEXT)
        Localization.add("Recording stopped.", forKey: AUTO_RECORDING_STOPPED_NOTIFICATION_TEXT)
        Localization.add("Driving started. You shoud start recording.", forKey: DRIVING_STARTED_NOTIFICATION_TEXT)
        Localization.add("Driving stopped. You should stop recording.", forKey: DRIVING_STOPPED_NOTIFICATION_TEXT)
        Localization.add("Terminated", forKey: APPLICATION_TERMINATED_NOTIFICATION_TITLE)
        Localization.add("App is terminated", forKey: APPLICATION_TERMINATED_NOTIFICATION_TEXT)
        Localization.add("Battery warning", forKey: LOW_BATTERY_NOTIFICATION_TITLE)
        Localization.add("You reach battery level. Sensing and recording are off", forKey: LOW_BATTERY_NOTIFICATION_TEXT)
    }
    
    func setLowBatteryLevel(level: Int) {
        DrivingManager.shared._mobilityAPI.setBatteryWarningLevel(Int32(level))
    }
    
    func setWifiUploadOnly(wifiUploadOnly: Bool) {
        _mobilityAPI.setUploadUsingWifiOnly(wifiUploadOnly)
    }
    
    func getWifiUploadOnly() -> Bool {
        return _mobilityAPI.getUploadUsingWifiOnly()
    }
    
    func setBeaconScanning(enabled: Bool) {
        _mobilityAPI.setBeaconScanningEnabled(enabled)
    }
}

extension DrivingManager: MobilitySDKDelegate {
    func reautentificationNeeded(_ error: Error) {
        
    }

    func gpsPointRecorded(_ point: CLLocation) {
        NotificationCenter.default.post(name: .gps, object: nil, userInfo: ["point": point])
    }


    func calling(with status: PhoneCallStatus, time: String) {
        
    }
    
    func proximityChanged(with status: PhoneProximityStatus) {
        
    }
    
    func didEnterPairedBeaconRegion() {
        
    }
    
    func didExitPairedBeaconRegion() {
        
    }
    
    func didDetect(_ beacons: [DetectedBeacon]) {
        
    }
    
    func recordingStarted() {
        
    }
    
    func recordingStopped() {
        
    }
    
    func allDrivesUploadFinished() {
        NotificationCenter.default.post(name: .tripsUploadCount, object: nil)
    }
    
    func allDrivesUploadFailed(_ error: Error?) {
       NotificationCenter.default.post(name: .tripsUploadCount, object: nil)
    }
    
    
    func bluetoothSensorOn() {
        
    }
    
    func bluetoothSensorOff() {
        
    }
    
    func bluetoothConnectedScanStarted() {
        NotificationCenter.default.post(name: .bluetoothStartRefreshing, object: nil)
    }
    
    func bluetoothConnectedScanFinished() {
        NotificationCenter.default.post(name: .bluetoothEndRefreshing, object: nil)
    }
    
    func bluetoothSensorDeviceConnected() {
        NotificationCenter.default.post(name: .bluetoothSensorDeviceConnectedd, object: nil)
    }
    
    func bluetoothSensorDeviceDisconnected() {
        NotificationCenter.default.post(name: .bluetoothSensorDeviceDisconnected, object: nil)
    }
    
    func bluetoothStateChanged() {
        NotificationCenter.default.post(name: .bluetoothStateChanged, object: nil)
    }
    
    func drivingStarted() {
        _postDrivingNotificationWith(status: DrivingManagerDrivingStatus.started)
    }
    
    func drivingStopped() {
        _postDrivingNotificationWith(status: DrivingManagerDrivingStatus.stopped)
    }
    
    func calling(withStatus status: String, time: String) {
        
    }
    
    func proximityChanged(withStatus status: String) {
        
    }

    
    func writeLog(message: String) {
        _mobilityAPI.write(toLog: message)
    }
    
    
}
