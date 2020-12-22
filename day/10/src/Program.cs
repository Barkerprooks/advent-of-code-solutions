using System;
using System.Collections.Generic;

namespace src
{
    class Program
    {
			
        static void Main(string[] args)
        {
			var lines = System.IO.File.ReadAllLines("../ex.txt");
        	int index = 0, max = 0, c1 = 1, c3 = 0;
			int[] jlt = new int[lines.Length + 1];
			
			List<int[]> p = new List<int[]>();
			
			foreach(var line in lines) {
				if(Int32.TryParse(line, out int val)) {
					if(val > max)
						max = val;
					jlt[index++] = val;
				} else
					break;
			}

			jlt[index++] = max + 3;

			Array.Sort(jlt);

			for(int i = 1; i < index; i++) {
				if(jlt[i] == (1 + jlt[i - 1])) {
					c1++;
				} else if(jlt[i] == (3 + jlt[i - 1])) {
					c3++;
				}
			}

			List<int> gen = new List<int>();
			int val = -1, i = 0;

			gen.Add(0);

			while(i != jlt[index - 1]) {
				foreach(var n in jlt) {
					if(n < i + 3) {}
						
				}
				i = jlt[ind++];
			}
			
			Console.WriteLine("solution 1: {0}", c1 * c3);

		}
    }
}
