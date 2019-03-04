# Check if the correct number of args are passed in
if ARGV.length != 1 
	puts "Missing argument of .txt file, please try again."
	exit
end

File.read(ARGV[0]).scan(/[^\d]31[^\d]|[^\d]30[^\d]|[^\d]2[0-9][^\d]|[^\d]1[0-9][^\d]|[^\d]0?[0-9][^\d]/) { |line| puts line }

exit


