using System;

namespace src
{
    class Program
    {
        static void Main(string[] args)
        {
			var lines = System.IO.File.ReadAllLines("../input.txt");
        	int index = 0;
			int[] jlt = new int[lines.Length - 1];
			foreach(var line in lines) {
				if(Int32.TryParse(line, out int val)) {
					jlt[index++] = val;
				} else {
					break;
				}
			}

			Array.Sort(jlt);

			foreach(var num in jlt)
				Console.WriteLine(num);

		}
    }
}
