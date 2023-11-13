package com.djudjo.scheduler

import android.app.Application
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.ProcessLifecycleOwner

class AndroidApplication : Application(), LifecycleObserver {
    override fun onCreate() {
        super.onCreate()
        ProcessLifecycleOwner.get().lifecycle.addObserver(this)
    }

    companion object {
        private const val STARTING_ACTIVITY = "com.djudjo.scheduler.MainActivity"
    }
}