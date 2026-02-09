package com.example.strawberryhrm

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.os.Build
import android.widget.RemoteViews
import androidx.annotation.RequiresApi
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import androidx.core.content.ContextCompat

class HomeScreenCheckInOutWidgetProvider : HomeWidgetProvider() {
    @RequiresApi(Build.VERSION_CODES.S)
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.check_in_out_widget).apply {

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)

                try {
                    val isCheckedIn = widgetData.getBoolean("isCheckedIn", false)
                    val colorResId = if (isCheckedIn) R.color.red else R.color.blue
                    setInt(R.id.check_in_out_id, "setBackgroundColor", ContextCompat.getColor(context, colorResId))

                    setTextViewText(R.id.btn_check_in_out, if (isCheckedIn) "Check-out" else "Check-in")
                    setOnClickPendingIntent(R.id.check_in_out_id, pendingIntent)
                } catch (e: Exception) {
                    // Handle exception
                }
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}