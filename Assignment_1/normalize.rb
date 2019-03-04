# Check if the correct number of args are passed in
if ARGV.length != 1
	puts "Missing argument of a text file."
	exit(0)
end

# Extract the filename, open and read the file
text = File.read(ARGV[0])

# Eliminate any extra spaces, replace them with single spaces, store the result in a variable.
contents = text.gsub(/\s\s+/,' ')

puts contents

exit