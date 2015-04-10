open System
open System.Net

let webcilent (address :String)(url: String) =
    let wc = new WebClient()
    let uri = Uri(address)
    try
        wc.DownloadFile(uri, url)
    with
    | ex -> printfn "%s" ex.Message |> ignore

let downLoadGroonga (groongaVer: String) =
    let url = String.Format("http://packages.groonga.org/source/groonga/groonga-{0}.zip", groongaVer)
    let saveFileName = String.Format("groonga-{0}.zip", groongaVer)
    try
        webcilent url saveFileName
    with
    | ex -> printfn "%s" ex.Message; ()

let version = "5.0.2"

Console.WriteLine("downloading groonga {0}...", version)
downLoadGroonga version
Console.WriteLine "done!"