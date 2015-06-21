open System
open System.Net

let webcilent (address :String)(url: String) =
    let wc = new WebClient()
    let uri = Uri(address)
    try
        wc.DownloadFile(uri, url)
    with
    | ex -> printfn "%s" ex.Message |> ignore

let downLoadRustNightlyForWindows =
    let url = "https://static.rust-lang.org/dist/rust-nightly-x86_64-pc-windows-gnu.msi"
    let saveFileName = "rust-nightly-x86_64-pc-windows-gnu.msi"
    webcilent url saveFileName

Console.WriteLine "Downloading Rust nightly..."
downLoadRustNightlyForWindows
Console.WriteLine "done!"
