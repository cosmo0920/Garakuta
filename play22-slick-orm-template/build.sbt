name := "project-template"

version := "1.0-SNAPSHOT"

libraryDependencies ++= Seq(
  jdbc,
  //anorm,
  cache,
  "com.typesafe.slick" %% "slick" % "2.0.0",
  "org.slf4j" % "slf4j-nop" % "1.6.4",
  "com.typesafe.play" % "play-slick_2.10" % "0.6.0.1",
  "org.jumpmind.symmetric.jdbc" % "mariadb-java-client" % "1.1.1"
)

play.Project.playScalaSettings
