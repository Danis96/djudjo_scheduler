package com.djudjo.scheduler

import android.content.*
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.*


class MainActivity : FlutterActivity() {


    private var methodChannelResult: MethodChannel.Result? = null
    private val CHANNEL = "com.amodo.mobility"
    lateinit var methodChannel:MethodChannel

    override fun onStart() {
        super.onStart()
        startObservingForBlutoothEvent()
        startObservingForBluetoothConnectDisconnectEvent()
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
    }


    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String?>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

    }

    fun append(arr: List<HashMap<String, Any>>, element: HashMap<String, Any>): List<HashMap<String, Any>> {
        val list: MutableList<HashMap<String, Any>> = arr.toMutableList()
        list.add(element)
        return list.toList()
    }

    private fun createBlutoothStartedBroadcastReceiver() = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {

        }
    }

    private fun startObservingForBlutoothEvent() {
    }

    private fun createBlutoothConnectDisconnectBroadcastReceiver() = object : BroadcastReceiver() {
        override fun onReceive(p0: Context?, p1: Intent?) {
        }
    }

    private fun startObservingForBluetoothConnectDisconnectEvent(){
    }

    override fun onStop() {
        super.onStop()
    }
}
