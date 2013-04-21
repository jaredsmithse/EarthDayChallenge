f = open("version2.csv")

state_map = open("../state-name-map.csv")

state_list = {}

for line in state_map:
	line = line.split(",")
	state_list[line[1].strip()] = line[0].strip()

print state_list
index = 0
for line in f:
	if index == 0:
		index += 1
		continue
	state = line[0:2]
	new_state = state_list[state]
	line = new_state + line[2:].lower()
	print line.strip()
