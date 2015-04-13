module Main where

import System.Posix.Daemonize (CreateDaemon(..), serviced, simpleDaemon, exitCleanly, fatalError)
import System.Posix.Signals (installHandler, Handler(Catch), sigHUP, sigTERM, fullSignalSet)
import System.Posix.Syslog (syslog, Priority(Notice))
import Control.Concurrent (threadDelay)
import Control.Monad (forever)

main :: IO ()
main = serviced defaultMain

defaultMain :: CreateDaemon ()
defaultMain = simpleDaemon { program = daemonMain }

daemonMain :: () -> IO ()
daemonMain _ = do
  installHandler sigHUP (Catch hupCatched) (Just fullSignalSet)
  installHandler sigTERM (Catch termCatched) (Just fullSignalSet)
  forever $ do threadDelay (10^6)
               syslog Notice "[hdaemonize test] It's still alive!"

hupCatched :: IO ()
hupCatched = syslog Notice "caught SIGHUP."

termCatched :: IO ()
termCatched = syslog Notice "caught SIGTERM."
