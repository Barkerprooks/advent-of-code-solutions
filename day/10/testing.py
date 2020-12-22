nums = [0]

with open("ex.txt", "rt") as handle:
    for line in handle.readlines():
        if line.strip():
            nums.append(int(line))

nums.sort()
nums.append(nums[-1] + 3)

j = []

for i in range(len(nums) - 1):
    j = i + 1
    i0 = nums[i]
    while nums[j] - i0 < 2:
        print(f"{nums[i]}: {nums[j]}")
        j += 1

