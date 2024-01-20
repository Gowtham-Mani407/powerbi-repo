package com.example.statemanagement

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val channelname = "com.statemanagement";
    private lateinit var channel : MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger , channelname)
        //Recive data from flutter
        channel.setMethodCallHandler { call, result ->
            if(call.method == "show_batterylevel"){

              val arguments = call.arguments as Map<String, String>

                var  name = arguments["name"]

               Toast.makeText(this, "Yuipp :${name}" , Toast.LENGTH_LONG).show()
               var BL =  getbatterylevel(context)
               result.success(BL)
            }else{
                result.notImplemented()
            }
        }
    }

    private fun getbatterylevel(context: Context): Int {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            // For older devices (API level < 21), use a BroadcastReceiver
            val intentFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            val batteryStatus: Intent? = context.registerReceiver(null, intentFilter)
            val level = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
            val scale = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1

            return if (level != -1 && scale != -1) {
                (level.toFloat() / scale.toFloat() * 100).toInt()
            } else {
                -1
            }
        }
    }
}
