#!/usr/bin/env python3

with open("input.txt") as stream:
    
    p1 = 0
    p2 = 0

    while(line := stream.readline()):
        line = line.strip()
        if line:
            prtn = line.split(":")
            info, pswd = prtn[0], prtn[1].strip()
            info_parts = info.split(' ')
            
            r = info_parts[0].split('-')
            c = info_parts[1]
            lo, hi = int(r[0]), int(r[1])
            
            count = 0
            for ch in pswd:
                if ch == c:
                    count += 1

            appears = 0
            for i in [lo - 1, hi - 1]:
                if pswd[i] == c:
                    appears += 1

            if appears == 1:
                p2 += 1

            if not (count < lo or count > hi):
                p1 += 1


print(f"part 1 answer: {p1}")
print(f"part 2 answer: {p2}")
