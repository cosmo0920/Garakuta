name := "Json-spike"

version := "0.1-pre"

organization := "net.cosmo0920"

resolvers += "Typesafe Repository" at "http://repo.typesafe.com/typesafe/releases/"

libraryDependencies ++= Seq(
  "org.slf4j" % "slf4j-simple" % "1.7.4"
, "net.databinder.dispatch" %% "dispatch-core" % "0.11.0"
, "net.databinder.dispatch" %% "dispatch-json4s-native" % "0.11.0"
)

scalaVersion := "2.10.2"
