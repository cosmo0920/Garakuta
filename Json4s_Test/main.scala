import dispatch._, Defaults._
import org.json4s._
import org.json4s.native.JsonMethods._

object Main {
  def main(args: Array[String]) {
    val cityId = "130010" //tokyo
    val apiUrl = "http://weather.livedoor.com/forecast/webservice/json/v1?city="
    val req = Http(url(apiUrl + cityId) OK as.String)
    forecast(req)
  }

  def forecast(req: Future[String]) = {
    val json = parse(req())
    val JString(time) = json\ "publicTime"
    val pubTime = "更新時刻: " + time
    val JString(minTemp) = json\ "forecasts"\ "temperature"\ "min"\"celsius"
    val JString(maxTemp) = json\ "forecasts"\ "temperature"\ "max"\"celsius"
    val minmaxtemp = "最高気温: " + maxTemp + "℃ 最低気温: " + minTemp + "℃ です。"
    val JString(location) = json\ "location" \"city"
    val JArray(List(JString(today), JString(tomorrow))) = json\ "forecasts"\ "dateLabel"
    val JArray(List(JString(todayf), JString(tomorrowf))) = json\ "forecasts"\ "telop"
    val forecast = "簡易予報: " + location + "の" + today + "、" + tomorrow + "の天気は" + todayf + "、" + tomorrowf + "です。"
    val JString(descr) = json\ "description"\ "text"
    val description = "詳細: " + descr
    println(pubTime)
    println(minmaxtemp)
    println(forecast)
    println(description)
  }
}
