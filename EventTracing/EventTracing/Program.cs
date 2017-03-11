using System;
using Microsoft.Diagnostics.Tracing;

namespace EventTracing
{
    class Program
    {
        static void Main(string[] args)
        {
            TailEventSource.Log.Critical("This is a test for windows event log.");
            Console.WriteLine("Confirm windows eventlog. (Press Enter)");
            Console.ReadLine();
        }
    }

    [EventSource(Name = "TailEventSource")]
    public sealed class TailEventSource : EventSource
    {
        public static readonly TailEventSource Log = new TailEventSource();

        [Event(1, Message = "{0}", Channel = EventChannel.Admin)]
        public void Critical(string message)
        {
            WriteEvent(1, message);
        }
    }
}