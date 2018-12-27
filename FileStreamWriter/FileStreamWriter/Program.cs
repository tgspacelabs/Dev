using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FileStreamWriter
{
    class Program
    {
        static void Main(string[] args)
        {
            string filename;
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();

            for (int i = 0; i < 1000000; i++)
            {
                filename = String.Format(@"C:\WaveformData\WaveformFile{0:d3}.bin", i);
                CreateBlobFile(filename);
            }

            Console.WriteLine("Elapsed Time: {0:d2}:{1:d2}:{2:d2}.{3:d3}", stopwatch.Elapsed.Hours, stopwatch.Elapsed.Minutes, stopwatch.Elapsed.Seconds, stopwatch.Elapsed.Milliseconds);
            //Console.WriteLine("Elapsed Time: " + stopwatch.Elapsed.Hours + ":" + stopwatch.Elapsed.Minutes + ":" + stopwatch.Elapsed.Seconds + "." + stopwatch.Elapsed.Milliseconds);

            Console.ReadLine();
        }

        private static void CreateBlobFile(string filename)
        {
            // Create a text file C:\Temp\TG01.bin
            FileStream fs = new FileStream(filename, FileMode.Create, FileAccess.Write);
            StreamWriter streamWriter = new StreamWriter(fs);

            char[] buffer = new char[20000];

            // Write to the file using StreamWriter class
            streamWriter.BaseStream.Seek(0, SeekOrigin.End);
            streamWriter.Write(" File Write Operation Starts : ");
            streamWriter.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(), DateTime.Now.ToLongDateString());
            streamWriter.WriteLine(" First Line : Data is first line \n");
            streamWriter.WriteLine(" This is next line in the text file. \n ");
            streamWriter.Write(buffer);
            streamWriter.Flush();

            // Read from the file using StreamReader class
            // StreamReader m_streamReader = new StreamReader(fs);
            // string str = m_streamReader.ReadLine();
        }
    }
}
