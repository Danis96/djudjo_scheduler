package com.djudjo.scheduler

class Constants {
    companion object {

        var HASH_KEY = ""
        var PLATFORM_PREFIX = ""

        init {
            when (BuildConfig.FLAVOR) {
                "dev" -> {
                    HASH_KEY = ""
                    PLATFORM_PREFIX = ""
                }
                "qa" -> {
                    HASH_KEY = ""
                }
                "prod" -> {
                    HASH_KEY = ""
                    PLATFORM_PREFIX = ""
                }
            }
        }
    }
}