# Author : Jared Smith
# UserID : jaredsmithse
# we need to switch station id with state and county to plot
# it into our R webapp, so we essentially join the data,
# substituting in the info we need
file = File.open("station_index.csv", "r")
stations = Hash.new
file.each do |line|
	row = line.split(',')
	stations[row[0].chomp] = [row[1].strip, row[2].strip]
end
file.close

file = File.open("awesome-stuff.csv","r")

file.each do |line|
	row = line.split(',')
	begin
		puts stations[row[0][5..-1]][0].to_s + ',' + stations[row[0][5..-1]][1].to_s + line[11..-1]
	rescue
		next
	end
end

file.close



