#include <iostream>
#include <fstream>
#include <string>
#include <map>

int main(void)
{
	std::ifstream fd("input.txt");
	std::string line;
	std::map<char, int> ans;

	unsigned int total_1 = 0, total_2 = 0, people = 0;

	if(fd.is_open())
	{
		while(getline(fd, line))
		{
			if(line.empty())
			{
				total_1 += ans.size();	

				for(auto pair : ans)
				{
					if(pair.second == people)
						total_2 += 1;
				}
			
				people ^= people;
				ans.clear();
			} 
			else 
			{
				for(char ch : line)
				{
					if(!ans[ch])
						ans[ch] = 1;
					else
						ans[ch]++;
				}
				
				people++;
			}	
		}
	}
				
	total_1 += ans.size();
	
	for(auto pair : ans)
	{
		if(pair.second == people)
			total_2 += 1;
	}

	std::cout << "solution 1: " << total_1 << std::endl;
	std::cout << "solution 2: " << total_2 << std::endl;

	fd.close();

	return 0;
}
