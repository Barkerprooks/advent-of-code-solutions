function find_gold(key, bags, gold=[])
	for b in bags[key]
		b = b[3:length(b)]
		if occursin("shiny gold", b)
			if ! (key in gold)
				push!(gold, key)
			end
			return true
		elseif ! occursin("other", b)
			if find_gold(b, bags, gold)
				if ! (key in gold)
					push!(gold, key)
				end
				return true
			end
		end
	end
	false
end

bags = Dict()

open("input.txt", "r") do fd
	while ! eof(fd)
		line = readline(fd)
		pair = split(line, "contain")
		k = split(strip(pair[1]), " bag")[1]
		v = map(strip, split(pair[2], ", "))
		bags[k] = [split(i, " bag")[1] for i in v]
	end
end

gold = []
for bag in bags
	find_gold(bag.first, bags, gold)
end

println("solution 1: ", length(gold))
