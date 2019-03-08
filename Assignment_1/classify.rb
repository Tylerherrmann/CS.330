# Check if the correct number of args are passed in
if ARGV.length != 1 
	puts "Missing argument of .java file, please try again."
	exit
end

# Define classDef so it persists outside of below if statement
classDef = nil
# Read the .java file line by line until we find our public class def. Extract this into the classDef variable.
File.readlines(ARGV[0]).each do |line|
	if line =~ /^public/ 
		classDef = line
	end
end

# Remove .java from the extracted file name for use in Regex matching. Add class prior to the filename for future matching.
fileName = "class " + ARGV[0].chomp(".java")

# Check if match between extracted file name and class name
if classDef =~ /#{fileName}\W{/
	exit(0)
else
	exit(1)
end