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
    val JString(location) = json\ "location" \"city"
    val JArray(List(JString(today), JString(tomorrow))) = json\ "forecasts"\ "dateLabel"
    val JArray(List(JString(todayf), JString(tomorrowf))) = json\ "forecasts"\ "telop"
    val forecast = location + "の" + today + "、" + tomorrow + "の天気は" + todayf + "、" + tomorrowf + "です。"
    val JString(descr) = json\ "description"\ "text"
    println(forecast)
    println(descr)
  }
}
