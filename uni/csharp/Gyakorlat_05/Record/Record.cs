using System;

namespace Record
{
    class Record
    {
        public string Title { get; private set; }
        public string Performer { get; private set; }
        public int Length { get; private set; }

        public Record() { }

        public Record(string title, string performer, int length)
        {
            Title = title;
            Performer = performer;
            Length = length;
        }

        public bool IsPerformedBy(string performer)
        {
            return string.Equals(Performer, performer);
        }

        public int Equals(Record record)
        {
            if (record.Length == Length) return 0;
            else if (Length > record.Length) return 1;
            else return -1;
        }

        public override string ToString()
        {
            return $"{Performer}: {Title}, {Length} minutes";
        }
    }
}