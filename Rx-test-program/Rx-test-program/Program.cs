using System;
using System.Reactive.Linq;
using System.Web;
using System.Net;
using System.IO;
using System.Text;

namespace Rxtestprogram
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			HttpWebRequest request = (HttpWebRequest)WebRequest.Create ("http://github.com");
			var rx = GetDocumentContents (request).ToObservable();
			rx.Subscribe (Console.Write);
		}

		private static string GetDocumentContents(System.Net.HttpWebRequest request)
		{
			string documentContents;
			HttpWebResponse response = (HttpWebResponse)request.GetResponse ();
			using (Stream receiveStream = response.GetResponseStream())
			{
				using (StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8))
				{
					documentContents = readStream.ReadToEnd();
				}
			}
			return documentContents;
		}
	}
}
