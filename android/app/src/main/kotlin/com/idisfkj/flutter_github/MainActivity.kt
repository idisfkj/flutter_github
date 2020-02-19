package com.idisfkj.flutter_github

import android.content.Intent
import android.text.TextUtils
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private var mAuthorizationCode: String? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        setupMethodChannel()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        getExtra(intent)
    }

    private fun getExtra(intent: Intent?) {
        // from author login
        mAuthorizationCode = intent?.data?.getQueryParameter(Constants.AUTHORIZATION_CODE)
    }

    private fun setupMethodChannel() {
        MethodChannel(flutterEngine?.dartExecutor, Constants.METHOD_CHANNEL_NAME).setMethodCallHandler { call, result ->
            if (call.method == Constants.CALL_LOGIN_CODE && !TextUtils.isEmpty(mAuthorizationCode)) {
                result.success(mAuthorizationCode)
                mAuthorizationCode = null
            }
        }
    }
}
