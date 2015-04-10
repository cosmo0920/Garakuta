open System
open System.Net

let webcilent (address :String)(url: String) =
    let wc = new WebClient()
    let uri = Uri(address)
    try
        wc.DownloadFile(uri, url)
    with
    | ex -> printfn "%s" ex.Message |> ignore

let downLoadMroongaForWindows (mariaDBVer: String) (mroongaVer: String) =
    let url = String.Format("http://packages.groonga.org/source/mroonga/mariadb-{0}-with-mroonga-{1}-for-windows.zip", mariaDBVer, mroongaVer)
    let saveFileName = String.Format("mariadb-{0}-with-mroonga-{1}-for-windows.zip", mariaDBVer, mroongaVer)
    webcilent url saveFileName

let mariaDBVer = "10.0.17"
let mroongaVer = "5.01"

Console.WriteLine("downloading mariadb-{0}-with-mroonga-{1}-for-windows.zip...", mariaDBVer, mroongaVer)
downLoadMroongaForWindows mariaDBVer mroongaVer
Console.WriteLine "done!"