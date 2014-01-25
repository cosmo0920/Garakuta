package parseForecastJson

import dispatch._, Defaults._
import org.json4s._
import org.json4s.native.JsonMethods._

class parseForecastJson {
  def show(req: Future[String]): Unit = {
    val json = parse(req())
    val time = publishTime(json)
    val forecast = forecastInfo(json)
    val description = descriptionInfo(json)
    val temp = tempInfo(json)
    println(time)
    println(temp)
    println(forecast)
    println(description)
  }

  def publishTime(json: JValue): String = {
    val JString(time) = json\ "publicTime"
    val pubTime = "更新時刻: " + time
    pubTime
  }

  def locationInfo(json: JValue): String = {
    val JString(location) = json\ "location" \"city"
    location
  }

  def maxTemp(json: JValue): String = {
    json\ "forecasts"\ "temperature"\ "max"\ "celsius" match {
      case JString(maxTemp) => maxTemp
      case _                => "No Info."
    }
  }

  def minTemp(json: JValue): String = {
    json\ "forecasts"\ "temperature"\ "min"\ "celsius" match {
      case JString(minTemp) => minTemp
      case _                => "No Info."
    }
  }

  def tempInfo(json: JValue): String = {
    val info = "最高気温は" + maxTemp(json) + "最低気温は" + minTemp(json)
    info
  }

  def forecastInfo(json: JValue): String = {
    val location = locationInfo(json)
    val JArray(List(JString(today), JString(tomorrow))) = json\ "forecasts"\ "dateLabel"
    val JArray(List(JString(todayf), JString(tomorrowf))) = json\ "forecasts"\ "telop"
    val forecast = "簡易予報: " + location + "の" + today + "、" + tomorrow + "の天気は" + todayf + "、" + tomorrowf + "です。"
    forecast
  }

  def descriptionInfo(json: JValue): String = {
    val JString(descr) = json\ "description"\ "text"
    val description = "詳細: " + descr
    description
  }
}
