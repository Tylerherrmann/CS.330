# Check if the correct number of args are passed in
if ARGV.length != 2
	puts "Missing argument of a regex statement and file path, please try again."
	exit(0)
end

# Extract the regex statement passed in
regexStatement = ARGV[0]

# Read the passed in file line by line until we find a match. Output any matches to stdout.
File.readlines(ARGV[1]).each do |line|
	if line =~ /#{regexStatement}/ 
		puts line
	end
end

exit(1)