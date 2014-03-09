import Shelly
import Data.Text
import Prelude hiding (FilePath)
import System.Exit

main :: IO ()
main = shelly $ do
    let kernel_name = "-custom-fornewercore2" :: Text
    grep_cpus    <- silently $ run_cat "/proc/cpuinfo" [] -|- run_grep "processor" []
    let cpu_nums = Prelude.length $ Data.Text.lines grep_cpus
        job_nums = cpu_nums + 1
    bool <- test_f ".config"
    case bool of
      False -> do
        echo ".config not found."
        liftIO $ exitFailure
      True  -> echo ".config found."
    let kernel_version = "--append_to_version=" `append` kernel_name
        j_num          = "-j" `append` (pack $ show job_nums)
    run_fakeroot "make-kpkg" ["--initrd", "kernel_image", "kernel_headers", kernel_version , "--revision=1", j_num]
    return ()

run_cat :: Text -> [Text] -> Sh Text
run_cat option args = do
  run "cat" (option:args)

run_grep :: Text -> [Text] -> Sh Text
run_grep option args = do
  run "grep" (option:args)

run_fakeroot:: Text -> [Text] -> Sh Text
run_fakeroot option args = do
  run "fakeroot" (option:args)
