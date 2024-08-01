package com.example.coin_one


import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class NativeAdFactory(private val context: Context) : NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.native_ad_layout, null) as NativeAdView

        with(nativeAdView) {
            val headlineView: TextView = findViewById(R.id.ad_headline)
            val bodyView: TextView = findViewById(R.id.ad_body)
            val callToActionView: Button = findViewById(R.id.ad_call_to_action)
            val iconView: ImageView = findViewById(R.id.ad_icon)
            val starRatingView: RatingBar = findViewById(R.id.ad_stars)

            headlineView.text = nativeAd.headline
            nativeAdView.headlineView = headlineView

            bodyView.text = nativeAd.body
            nativeAdView.bodyView = bodyView

            callToActionView.text = nativeAd.callToAction
            nativeAdView.callToActionView = callToActionView

            nativeAd.icon?.let {
                iconView.setImageDrawable(it.drawable)
                iconView.visibility = View.VISIBLE
                nativeAdView.iconView = iconView
            } ?: run { iconView.visibility = View.GONE }

            nativeAd.starRating?.let {
                starRatingView.rating = it.toFloat()
                starRatingView.visibility = View.VISIBLE
                nativeAdView.starRatingView = starRatingView
            } ?: run { starRatingView.visibility = View.GONE }

            nativeAdView.setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}
