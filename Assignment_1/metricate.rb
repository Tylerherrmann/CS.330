# Check if the correct number of args are passed in
if ARGV.length != 1
	puts "Missing argument of a file containing imperial measurements."
	exit(0)
end

# Extract the filename, open and read the file
text = File.read(ARGV[0])

contents = text.gsub(/\s\s+/,' ')

# This will pull out yard measurements using regex and convert to m
contents = contents.gsub(/\d+\.\d+(?= yard)|\d+\.\d+(?= yards)|\d+\.\d+(?= yd)|\d+(?= yard)|\d+(?= yards)|\d+(?= yd)/) { |num| (num.to_f * 0.9144) }
# This will pull out inches measurements using regex and convert to cm
contents = contents.gsub(/\d+\.\d+(?= inch)|\d+\.\d+(?= inches)|\d+\.\d+(?= in)|\d+(?= inch)|\d+(?= inches)|\d+(?= in)/) { |num| (num.to_f * 2.54) }
# This will pull out pounds measurements using regex and convert to kg
contents = contents.gsub(/\d+\.\d+(?= pound)|\d+\.\d+(?= pounds)|\d+\.\d+(?= lb)|\d+(?= pound)|\d+(?= pounds)|\d+(?= lb)/) { |num| (num.to_f * 0.453592) }
# This will pull out miles measurements using regex and convert to km
contents = contents.gsub(/\d+\.\d+(?= miles)|\d+\.\d+(?= mile)|\d+\.\d+(?= mph)|\d+(?= miles)|\d+(?= mile)|\d+(?= mph)/) { |num| (num.to_f * 1.60934) }

# Now converting all the text for the measurements over
contents = contents.gsub(/inch|inches|in/,"cm")
contents = contents.gsub(/mile|miles/,"km")
contents = contents.gsub(/mph/,"kph")
contents = contents.gsub(/pound|pounds|lbs/,"kg")
contents = contents.gsub(/yard|yards|yd/,"m")

# Printing out new measurements
puts contents

exit