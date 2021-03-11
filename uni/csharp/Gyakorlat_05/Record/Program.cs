using System;

namespace Record
{
    class Program
    {
        static void Main(string[] args)
        {
            int arraySize = ReadInt("Amount of records: ");
            Record[] records = new Record[arraySize];
            
            for(int i = 0; i < records.Length; i++)
            {
                Console.WriteLine($"{i + 1}. record performer: ");
                string performer = Console.ReadLine();

                Console.WriteLine($"{i + 1}. record title: ");
                string title = Console.ReadLine();
                int length = ReadInt($"{i + 1}. record length: ");
                records[i] = new Record(title, performer, length);
            }

            int longest = LongestRecordIndex(records);
            Console.WriteLine($"Longest record: {records[longest]}");

            Console.WriteLine("Performer: ");
            PrintPerformerRecords(records, Console.ReadLine());
        }

        static void PrintPerformerRecords(Record[] records, string performer)
        {
            Console.WriteLine($"Records performed by {performer}");
            foreach(Record i in records)
            {
                if (i.IsPerformedBy(performer))
                    Console.WriteLine(i);
            }
        }

        static int LongestRecordIndex(Record[] records)
        {
            int longest = 0;
            for (int i = 1; i < records.Length; i++)
            {
                if (records[i].Equals(records[longest]) == 1)
                    longest = i;
            }

            return longest;
        }

        static int ReadInt(string msg)
        {
            Console.WriteLine(msg);
            return Convert.ToInt32(Console.ReadLine());
        }     
    }
}