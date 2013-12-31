{-# LANGUAGE OverloadedStrings #-}
import Shelly
import Data.Text
import Data.Maybe (fromMaybe)

main = shelly $ do
    let cabal_install = run_cabal "install" []
    let cabal_configure = run_cabal "configure" []
    let cabal_install_only_dep = run_cabal "install" ["--only-dependencies"]
    let cabal_build = run_cabal "build" []
    cabal_configure
    cabal_install_only_dep
    cabal_build
    echo "test"
    return ()


newtype Sudo a = Sudo { sudo :: Sh a }

run_ghc_test :: Sh ()
run_ghc_test = do
  writefile "a.hs" "main = print \"hello\""
  ghc ["a.hs"]
  out <- run "./a" []
  echo out
 where
  ghc files = run "ghc" files

run_cabal :: Text -> [Text] -> Sh Text
run_cabal option args = do
  cabal <- fmap (fromText . fromMaybe "cabal") $ get_env "CABAL"
  run cabal (option:args)

cabal_install_latest :: Sh Text
cabal_install_latest = shelly $ do
  run_cabal "update" []
  run_cabal "install" ["cabal-install"]

run_sudo :: Text -> [Text] -> Sudo Text
run_sudo cmd args = Sudo $ run "/usr/bin/sudo" (cmd:args)