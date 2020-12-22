function find_gold(key, bags, gold)
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

function search_for_gold(bags)
	gold = []
	for bag in bags
		find_gold(bag.first, bags, gold)
	end
	gold
end

function get_ncnt(key, bags)
	total = 0
	for bag in bags[key]
		if occursin("other", bag)
			return 0
		else
			n = parse(Int64, bag[1:2])
			b = bag[3:length(bag)]
			total += n
			total += n * get_ncnt(b, bags)
		end
	end
	total
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

gold = search_for_gold(bags)

println("solution 1: ", length(gold))
println("solution 2: ", get_ncnt("shiny gold", bags))
