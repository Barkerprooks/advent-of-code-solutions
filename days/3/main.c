#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define MAX_BYTES 20000

int count_trees(char *, int, unsigned int, unsigned int);

int main(void)
{
	int fd;
	unsigned int bytes, trees, xs, ys;
	unsigned int slopes[][2] = { 
		{1, 1}, {3, 1}, {5, 1},
		{7, 1}, {1, 2}
	};
	
	char buf[MAX_BYTES] = {0};
	
	fd = open("input.txt", O_RDONLY);
	bytes = read(fd, buf, MAX_BYTES);
	close(fd);

	trees = count_trees(buf, bytes, 3, 1);

	printf("solution 1: %u\n", trees);

	trees = 1;

	for(int i = 0; i < 5; i++)
	{
		xs = slopes[i][0];
		ys = slopes[i][1];
		trees *= count_trees(buf, bytes, xs, ys);
	}

	printf("solution 2: %u\n", trees);

	return 0;
}

int count_trees(char *buf, int bytes, unsigned int xs, unsigned int ys)
{
	unsigned int trees = 0, height = 0, x = 0;
	char pos;

	for(int i = 0; i < bytes; i++)
		if(buf[i] == '\n')
			height++;

	for(int y = ys; y < height; y += ys)
	{
		x += xs;

		if(x >= 31)
			x -= 31;

		if(buf[x + 32 * y] == '#')
			trees++;
	}

	return trees;
}
