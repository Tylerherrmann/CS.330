# Check if the correct number of args are passed in
if ARGV.length != 1
	puts "Missing argument of a text file."
	exit(0)
end

File.readlines(ARGV[0]).each do |line|
	if line =~ /\s\s+/ 
		puts line.gsub(/\s\s+/,' ')
	else
		puts line
	end
end
