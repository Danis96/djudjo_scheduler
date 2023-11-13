package com.djudjo.scheduler

import android.Manifest
import android.bluetooth.BluetoothDevice
import android.content.*
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import eu.amodo.mobility.android.MobilityCallbackEvents
import eu.amodo.mobility.android.api.MobilityApi
import eu.amodo.mobility.android.util.LocalizationManager
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.bluetooth.BluetoothManager
import io.flutter.plugins.GeneratedPluginRegistrant
import java.lang.Exception
import java.util.*


class MainActivity : FlutterActivity() {

    private val PERMISSION_MOTION: Int = 29
    private val PERMISSION_STORAGE: Int = 28
    private val PERMISSION_CAMERA: Int = 27
    private val MY_PERMISSIONS_REQUEST_ACCESS_LOCATION: Int = 26
    private val REQUEST_PERMISSION_SETTING: Int = 25
    private var methodChannelResult: MethodChannel.Result? = null
    private val CHANNEL = "com.amodo.mobility"
    private val permissionsList: ArrayList<Int> = arrayListOf(PERMISSION_MOTION, PERMISSION_STORAGE, PERMISSION_CAMERA, MY_PERMISSIONS_REQUEST_ACCESS_LOCATION)
    lateinit var bluetoothStartedbroadcastReceiver: BroadcastReceiver
    lateinit var bluetoothConnectDisconnectStateReceiver: BroadcastReceiver
    lateinit var methodChannel:MethodChannel

    override fun onStart() {
        super.onStart()
        startObservingForBlutoothEvent()
        startObservingForBluetoothConnectDisconnectEvent()
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        methodChannel.setMethodCallHandler { call, result ->
                    methodChannelResult = result

                    val value: Boolean = call.argument<Boolean>("value") ?: false

                    val uuid = call.argument<String>("uuid") ?: ""

                    val driverId: Int = call.argument<Int>("driverId") ?: 0
                    val driverToken: String = call.argument<String>("driverToken") ?: ""
                    val vehicleIdString: String = call.argument<String>("vehicleId") ?: "-1"
                    val vehicleId: Int = vehicleIdString.toInt()

                    Log.e("MainActivity", "method: ${call.method}")
                    when (call.method) {
                        "AndroidSDKVersion" -> {
                            Log.d("MainActivity",
                                    "method: AndroidSDKVersion, arguments dID:$driverId dTok:$driverToken vId:$vehicleId")
                            result.success(Build.VERSION.SDK_INT)
                        }
                        "instantiateSDK" -> {
                            Log.d("MainActivity",
                                    "method: instantiateSDK, arguments dID:$driverId dTok:$driverToken vId:$vehicleId")
                            Log.d("MainActivity",
                                    "unsynced trips: ${MobilityApi.getNumberOfUnsyncedTrips(applicationContext)}")
                            MobilityApi.setUserData(applicationContext, driverToken,
                                    driverId, vehicleId, "spec", Constants.HASH_KEY)
                        }
                        "logoutNative" -> {
                            Log.d("MainActivity", "method: logoutNative, arguments: ${call.arguments}")
                            MobilityApi.clearAllUserData(application.applicationContext)
                        }
                        "startAutomaticRecording" -> {
                            Log.d("MainActivity",
                                    "method: startAutomaticRecording")
                            MobilityApi.startAutomaticRecording(applicationContext)
                        }
                        "startRecordingType" -> {
                            Log.d("MainActivity", "method: startRecordingType, argument: ${call.argument<Boolean>("value")}")
                            handleStoragePermission()
                            if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED
                                    && ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
                                if (value && !MobilityApi.isRecording(applicationContext)) {
                                    MobilityApi.startRecording(applicationContext)
                                    result.success(true)
                                } else {
                                    MobilityApi.stopRecording(applicationContext)
                                    result.success(false)
                                }
                            } else {
                                result.success(false)
                            }
                        }
                        "automaticStartRecordingType" -> {
                            Log.d("MainActivity", "method: automaticStartRecordingType, argument: ${call.argument<Boolean>("value")}")
                            MobilityApi.setAutoStartEnabled(applicationContext, value)
                        }
                        "automaticStopRecordingType" -> {
                            Log.d("MainActivity", "method: automaticStopRecordingType, argument: ${call.argument<Boolean>("value")}")
                            MobilityApi.setAutoStopEnabled(applicationContext, value)
                        }
                        "highPowerModeType" -> {
                            Log.d("MainActivity", "method: highPowerModeType, argument: ${call.argument<Boolean>("value")}")
                            MobilityApi.setHighPowerSensing(applicationContext, value)
                        }
                        "onlyWifiUploadType" -> {
                            Log.d("MainActivity", "method: onlyWifiUploadType, argument: ${call.argument<Boolean>("value")}")
                            MobilityApi.setUploadTripWifiOnly(applicationContext, value)
                        }
                        "rawSensorsCollectionType" -> {
                            Log.d("MainActivity", "method: rawSensorsCollectionType, argument: ${call.argument<Boolean>("value")}")
                            MobilityApi.setRawSensorDataCollectionEnabled(applicationContext, value)
                        }
                        "sensingSensorsCollectionType" -> {
                            Log.d("MainActivity", "method: sensingSensorsCollectionType, argument: ${call.argument<Boolean>("value")}")
                            MobilityApi.setMetaDataSensingEnabled(applicationContext, value)
                        }
                        "uploadDrives" -> {
                            Log.d("MainActivity", "method: uploadDrives, argument: ${call.arguments}")
                            MobilityApi.uploadAllUnsyncedTrips(applicationContext)
                        }
                        "clearAllDrives" -> {
                            Log.d("MainActivity", "method: clearAllDrives, argument: ${call.arguments}")
                            MobilityApi.deleteAllUnsyncedTrips(applicationContext)
                        }
                        "scanBeacons" -> {
                            Log.d("MainActivity", "method: scanBeacons, argument: ${call.arguments}")
                            MobilityApi.setBeaconDetection(applicationContext, true)
                        }
                        "setNotificationsFrench" -> {
                            MobilityApi.getLocalizationManager(applicationContext)
                                    .setString(applicationContext, LocalizationManager.AUTOMATIC_RECORDING_NOTIFICATION_TEXT,
                                            getString(R.string.AUTOMATIC_RECORDING_NOTIFICATION_TEXT_FRENCH))
                                    .setString(applicationContext, LocalizationManager.DRIVING_STARTED_NOTIFICATION_TICKER_TEXT,
                                            getString(R.string.DRIVING_STARTED_NOTIFICATION_TICKER_TEXT_FRENCH))
                                    .setString(applicationContext, LocalizationManager.RECORDING_STATE_DESCRIPTION,
                                            getString(R.string.RECORDING_STATE_DESCRIPTION_FRENCH))
                                    .setString(applicationContext, LocalizationManager.ACITVITY_TRACKING_STATE_DESCRIPTION,
                                            getString(R.string.ACITVITY_TRACKING_STATE_DESCRIPTION_FRENCH))
                            MobilityApi.updateNotification(applicationContext)
                        }
                        "setNotificationsEnglish" -> {
                            MobilityApi.getLocalizationManager(applicationContext)
                                    .setString(applicationContext, LocalizationManager.AUTOMATIC_RECORDING_NOTIFICATION_TEXT,
                                            getString(R.string.AUTOMATIC_RECORDING_NOTIFICATION_TEXT))
                                    .setString(applicationContext, LocalizationManager.DRIVING_STARTED_NOTIFICATION_TICKER_TEXT,
                                            getString(R.string.DRIVING_STARTED_NOTIFICATION_TICKER_TEXT))
                                    .setString(applicationContext, LocalizationManager.RECORDING_STATE_DESCRIPTION,
                                            getString(R.string.RECORDING_STATE_DESCRIPTION))
                                    .setString(applicationContext, LocalizationManager.ACITVITY_TRACKING_STATE_DESCRIPTION,
                                            getString(R.string.ACITVITY_TRACKING_STATE_DESCRIPTION))
                            MobilityApi.updateNotification(applicationContext)
                        }
                        "isPowerSavingMode" -> {
                            result.success(MobilityApi.isPowerSavingMode(applicationContext))
                        }
                        "hasAggressivePowerManagement" -> {
                            result.success(MobilityApi.hasAggressivePowerManagement(applicationContext))
                        }
                        "openPowerSavingSettings" -> {
                            MobilityApi.openPowerSavingSettings(this@MainActivity)
                        }
                        //permission types
                        "locationWhileInUseType" -> {
                            Log.d("MainActivity", "method: locationWhileInUseType, argument: ${call.argument<Boolean>("value")}")
                            handleLocationPermission()
                        }
                        "locationAlwaysType" -> {
                            Log.d("MainActivity", "method: locationAlwaysType, argument: ${call.argument<Boolean>("value")}")
                            handleLocationPermission()
                        }
                        "motionType" -> {
                            Log.d("MainActivity", "method: motionType, argument: ${call.argument<Boolean>("value")}")
                            handleMotionPermission()
                        }
                        "activity" -> {
                            Log.d("MainActivity", "method: activity, argument: ${call.argument<Boolean>("value")}")
                            handleMotionPermission()
                        }
                        "notificationType" -> {
                            Log.d("MainActivity", "method: notificationType, argument: ${call.argument<Boolean>("value")}")
                        }
                        "isTripRecording" -> {
                            Log.d("MainActivity", "method: isTripRecording || args: ${MobilityApi.isRecording(applicationContext)}")
                            result.success(MobilityApi.isRecording(applicationContext))
                        }
                        "sensorsLocation" -> {
                            Log.d("MainActivity", "method: sensorsLocation, argument: ${call.argument<Boolean>("value")}")
                            handleLocationPermission()
                        }
                        "camera" -> {
                            Log.d("MainActivity", "method: camera, argument: ${call.argument<Boolean>("value")}")
                            handleCameraPermission()
                        }
                        "storage" -> {
                            Log.d("MainActivity", "method: storage, argument: ${call.argument<Boolean>("value")}")
                            handleStoragePermission()
                        }

                        "foregroundLocation" -> {
                            Log.d("MainActivity", "method: foregroundLocation, argument: ${call.argument<Boolean>("value")}")
                            handleForegroundLocationPermission()
                        }
                        "backgroundLocation" -> {
                            Log.d("MainActivity", "method: backgroundLocation, argument: ${call.argument<Boolean>("value")}")
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                                handleBackgroundLocationPermission()
                            }
                        }

                        //bluetooth types
                        "checkForBluetoothAvailablity" -> {
                            result.success(MobilityApi.isBluetoothSettingEnabled())
                        }
                        "startScanning" -> {
                            try {
                                MobilityApi.startScanForConnectedDevices(applicationContext)
                            } catch (e: Exception) { }

                        }
                        "stopScanning" -> {
                            if (methodChannelResult != null)
                                methodChannelResult!!.success(true)
                        }
                        "getConnectedBluetoothDevices" -> {
                            var returnValue: List<HashMap<String, Any>> = emptyList()
                            val devices: List<BluetoothDevice> = MobilityApi.getConnectedBluetoothDevices(applicationContext)

                            val hashMap: HashMap<String, Any> = HashMap<String, Any>()
                            for (device in devices) {
                                hashMap["name"] = device.name
                                hashMap["uuid"] = device.address
                                returnValue = append(returnValue, hashMap)
                            }
                            Log.e("getConnectedBluetoothDevices", "returnValue final: ${returnValue.size}")

                            if (methodChannelResult != null)
                                methodChannelResult!!.success(returnValue)
                        }
                        "pairBluetoothDevice" -> {
                            val bluetoothManager: BluetoothManager = getSystemService(BLUETOOTH_SERVICE) as BluetoothManager
                            val mBluetoothDevice: BluetoothDevice = bluetoothManager.adapter.getRemoteDevice(uuid)
                            MobilityApi.pairBluetoothDevice(applicationContext, mBluetoothDevice)
                            if (methodChannelResult != null)
                                methodChannelResult!!.success(uuid)
                        }
                        "checkForPairedBluetoothDevices" -> {
                            //that is not yet available on Android
                        }
                        "unPairBluetoothDevice" -> {
                            MobilityApi.disconnectFromBluetooth(applicationContext)
                            if (methodChannelResult != null)
                                methodChannelResult!!.success("")
                        }
                        "hasAllRequiredBluetoothPermissions" -> {
                            result.success(MobilityApi.hasAllRequiredBluetoothPermissions(applicationContext))
                        }
                        "goToBluetoothSettingsAndroid" -> {
                            val intent = Intent(Intent.ACTION_MAIN, null)
                            intent.addCategory(Intent.CATEGORY_LAUNCHER)
                            val cn = ComponentName("com.android.settings",
                                    "com.android.settings.bluetooth.BluetoothSettings")
                            intent.component = cn
                            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                            startActivity(intent)
                        }
                        "isBluetoothDevicePairedAndConnected" -> {
                            val devices: List<BluetoothDevice> = MobilityApi.getConnectedBluetoothDevices(applicationContext)
                                    ?: emptyList()
                            var deviceFound = false

                            for (device in devices) {
                                if (device.name == uuid) {
                                    deviceFound = true
                                }
                            }
                            if (methodChannelResult != null)
                                methodChannelResult!!.success(deviceFound)
                        }
                        else -> {
                            Log.e("MainActivity", "method not implemented")
                        }
                    }
                }

    }

    private fun handleCameraPermission() {
        val shouldShow: Boolean = shouldShowRequestPermissionRationale(Manifest.permission.CAMERA)
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
                == PackageManager.PERMISSION_DENIED) {
            if (!shouldShow) {
                ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CAMERA), PERMISSION_CAMERA)
            } else {
                if (methodChannelResult != null)
                    methodChannelResult!!.success(true)
            }
        }
    }

    private fun handleStoragePermission() {
        val shouldShow: Boolean = shouldShowRequestPermissionRationale(Manifest.permission.WRITE_EXTERNAL_STORAGE)
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                == PackageManager.PERMISSION_DENIED) {
            if (!shouldShow) {
                ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE), PERMISSION_STORAGE)
            } else {
                if (methodChannelResult != null)
                    methodChannelResult!!.success(true)
            }
        }
    }

    private fun handleMotionPermission() {
        var shouldShow = true
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q){
            shouldShow = shouldShowRequestPermissionRationale(Manifest.permission.ACTIVITY_RECOGNITION)
        }else{
            if (methodChannelResult != null)
                methodChannelResult!!.success(true)
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q &&
                ContextCompat.checkSelfPermission(this, Manifest.permission.ACTIVITY_RECOGNITION) == PackageManager.PERMISSION_DENIED) {
            if (!shouldShow) {
                ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACTIVITY_RECOGNITION), PERMISSION_MOTION)
            } else {
                if (methodChannelResult != null)
                    methodChannelResult!!.success(true)
            }
        }
    }

    private fun handleLocationPermission() {
        val shouldShow: Boolean = shouldShowRequestPermissionRationale(Manifest.permission.ACCESS_FINE_LOCATION)

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_DENIED
                || ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_DENIED
                || (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q && ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_BACKGROUND_LOCATION) == PackageManager.PERMISSION_DENIED)) {
            if (!shouldShow) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
                    ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION,
                            Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_BACKGROUND_LOCATION), MY_PERMISSIONS_REQUEST_ACCESS_LOCATION)
                else
                    ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION,
                            Manifest.permission.ACCESS_COARSE_LOCATION), MY_PERMISSIONS_REQUEST_ACCESS_LOCATION)
            } else {
                if (methodChannelResult != null)
                    methodChannelResult!!.success(true)
            }
        }
    }

    private fun handleForegroundLocationPermission(){
        if(ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_DENIED
                || ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_DENIED){
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION,
                    Manifest.permission.ACCESS_COARSE_LOCATION), MY_PERMISSIONS_REQUEST_ACCESS_LOCATION)
        }
    }

    @RequiresApi(Build.VERSION_CODES.Q)
    private fun handleBackgroundLocationPermission(){
        if(ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_BACKGROUND_LOCATION) == PackageManager.PERMISSION_DENIED){
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_BACKGROUND_LOCATION)
                    , MY_PERMISSIONS_REQUEST_ACCESS_LOCATION)
        }
    }


//    private fun goToSettings() {
//        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
//        val uri: Uri = Uri.fromParts("package", packageName, null)
//        intent.data = uri
//        startActivityForResult(intent, REQUEST_PERMISSION_SETTING)
//    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String?>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        // If request is cancelled, the result arrays are empty.
        if (permissionsList.contains(requestCode)) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // permission was granted
                if (methodChannelResult != null)
                    methodChannelResult!!.success(true)
            } else {
                // permission denied
                if (methodChannelResult != null)
                    methodChannelResult!!.success(false)
            }
        }
        return
    }

    fun append(arr: List<HashMap<String, Any>>, element: HashMap<String, Any>): List<HashMap<String, Any>> {
        val list: MutableList<HashMap<String, Any>> = arr.toMutableList()
        list.add(element)
        return list.toList()
    }

    private fun createBlutoothStartedBroadcastReceiver() = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == MobilityCallbackEvents.BLUETOOTH_CONNECTED_SCAN_STARTED) {
                if (methodChannelResult != null) {
                        try {
                            methodChannelResult!!.success(true)
                        } catch (e: Exception) {
                            Log.e("MainActivity", "returning value for bluetooth exception: ${e.message}")
                        }
                    Log.e("MainActivity", "BLUETOOTH_CONNECTED_SCAN_STARTED")
                }
            }else if (intent?.action == MobilityCallbackEvents.BLUETOOTH_CONNECTED_SCAN_FINISHED) {
                if (methodChannelResult != null){
                    try {
                        methodChannel.invokeMethod("bluetoothScanFinished",null)
                        methodChannelResult!!.success(true)
                    } catch (e: Exception) {
                        Log.e("MainActivity", "returning value for bluetooth exception: ${e.message}")
                    }
                }
                Log.e("MainActivity", "BLUETOOTH_CONNECTED_SCAN_FINISHED")

            }
        }
    }

    private fun startObservingForBlutoothEvent() {
        bluetoothStartedbroadcastReceiver = createBlutoothStartedBroadcastReceiver()
        val intentFilter = IntentFilter()
        intentFilter.addAction(MobilityCallbackEvents.BLUETOOTH_CONNECTED_SCAN_STARTED)
        intentFilter.addAction(MobilityCallbackEvents.BLUETOOTH_CONNECTED_SCAN_FINISHED)
        intentFilter.addAction(MobilityCallbackEvents.BLUETOOTH_SENSOR_DEVICE_DISCONNECTED)
        intentFilter.addAction(MobilityCallbackEvents.BLUETOOTH_SENSOR_DEVICE_CONNECTED)
        MobilityApi.getBroadcastManager(applicationContext).registerReceiver(bluetoothStartedbroadcastReceiver, intentFilter)
    }

    private fun createBlutoothConnectDisconnectBroadcastReceiver() = object : BroadcastReceiver() {
        override fun onReceive(p0: Context?, p1: Intent?) {
            Log.e("MainActivity", "bluetooth acl intent?.action: ${p1?.action}")
            if (p1?.action.equals(BluetoothDevice.ACTION_ACL_CONNECTED)) {
//                val device = p1?.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE) as BluetoothDevice
                Log.e("MainActivity", "ACTION_ACL_CONNECTED")
                methodChannel.invokeMethod("bluetoothDeviceConnected",null)
            } else if (p1?.action.equals(BluetoothDevice.ACTION_ACL_DISCONNECTED)) {
//                val device = p1?.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE) as BluetoothDevice
                Log.e("MainActivity", "ACTION_ACL_DISCONNECTED")
                methodChannel.invokeMethod("bluetoothDeviceDisconnected",null)
            }
        }
    }

    private fun startObservingForBluetoothConnectDisconnectEvent(){
        bluetoothConnectDisconnectStateReceiver = createBlutoothConnectDisconnectBroadcastReceiver()
        val intentFilter = IntentFilter()
        intentFilter.addAction(BluetoothDevice.ACTION_ACL_CONNECTED)
        intentFilter.addAction(BluetoothDevice.ACTION_ACL_DISCONNECTED)
        registerReceiver(bluetoothConnectDisconnectStateReceiver, intentFilter)
    }

    override fun onStop() {
        super.onStop()
        Log.e("MainActivity", "onStop")
        if (this@MainActivity::bluetoothStartedbroadcastReceiver.isInitialized)
            MobilityApi.getBroadcastManager(applicationContext).unregisterReceiver(bluetoothStartedbroadcastReceiver)
        if (this@MainActivity::bluetoothConnectDisconnectStateReceiver.isInitialized)
            unregisterReceiver(bluetoothConnectDisconnectStateReceiver)
    }
}
