using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;

namespace day10
{
    class Program
    {	
		static List<long> xs = new List<long>();
		static Hashtable dt = new Hashtable();

        static void Main(string[] args)
        {	
			xs.Add(0);	
        	
			foreach(var line in File.ReadLines("input.txt")) {
				xs.Add(Int64.Parse(line));
			}

			xs.Sort();
			xs.Add(xs[xs.Count - 1] + 3);
			
			long n = 0, c1 = 0, c3 = 0;

			for(int i = 1; i < xs.Count; i++) {
				n = xs[i - 1];
				if(xs[i] == 1 + n) {
					c1++;
				} else if(xs[i] == 3 + n) {
					c3++;
				}
			}

			long ans = dp(0);

			Console.WriteLine("solution 1 {0}", c1 * c3);
			Console.WriteLine("solution 2 {0}", ans);
		}

		static long dp(int i) {
			
			if(i == xs.Count - 1) {
				return 1;
			}

			if(dt.ContainsKey(i)) {
				return (long) dt[i];
			}

			long ans = 0;

			for(var j = i + 1; j < xs.Count; j++) {
				if(xs[j] - xs[i] <= 3) {
					ans += dp(j);
				}
			}

			dt[i] = ans;
			return ans;
		}
    }
}
