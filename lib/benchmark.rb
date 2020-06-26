require_relative 'conversion.rb'
phone_numbers_file = ARGV[0]
dictionary_file = ARGV[1]

if phone_numbers_file.nil?
    while true
        puts 'Please enter mobile number(enter "\q" to quit) :'
        phone_number = gets.chomp #'! 2255.63' #'6686787825'
        if phone_number == '\q'
            puts "Program exited"
            exit(0)
        else
            object = Conversion.new(phone_number, dictionary_file)
            p "#{phone_number} => #{object.process}"
        end
    end
else
    File.foreach(phone_numbers_file) do |phone_number|
        object = Conversion.new(phone_number.chop, dictionary_file)
        p "#{phone_number.chop} => #{object.process}"
    end
end