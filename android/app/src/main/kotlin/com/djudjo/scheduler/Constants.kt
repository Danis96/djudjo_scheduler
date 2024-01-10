package com.djudjo.scheduler

class Constants {
    companion object {

        var HASH_KEY = ""
        var PLATFORM_PREFIX = ""

        init {
            when (BuildConfig.FLAVOR) {
                "dev" -> {
                    HASH_KEY = "04e309788f5e811ef3767af6ce885fcb"
                    PLATFORM_PREFIX = ""
                }
                "qa" -> {
                    HASH_KEY = ""
                }
                "prod" -> {
                    HASH_KEY = "d91ddb6e94c9289071c528693ff76841"
                    PLATFORM_PREFIX = ""
                }
            }
        }
    }
}