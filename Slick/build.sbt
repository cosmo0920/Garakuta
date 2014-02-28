name := "scfes-time-calc"

version := "0.1"

organization := "net.cosmo0920"

scalaVersion := "2.10.2"

mainClass in (Compile,run) := Some("Main")

libraryDependencies ++= Seq(
  "com.typesafe.slick" %% "slick" % "1.0.1",
  "org.slf4j" % "slf4j-nop" % "1.6.4",
  "org.xerial" % "sqlite-jdbc" % "3.7.2"
)
