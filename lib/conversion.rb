# Convert phone number to meaningfull word(s) based on available dictionary.
# Meaningfull words help to remember phone number.
class Conversion
  attr_reader :phone_number
  attr_reader :dic_file

  def initialize(phone_number, dic_file)
    @phone_number = phone_number
    @dic_file = dic_file
    @digit_to_chars = { '2' => %w[A B C],
                        '3' => %w[D E F],
                        '4' => %w[G H I],
                        '5' => %w[J K L],
                        '6' => %w[M N O],
                        '7' => %w[P Q R S],
                        '8' => %w[T U V],
                        '9' => %w[W X Y Z] }
    @correct_words = {}
  end

  def valid_phone_number?
    return false if phone_number.nil?

    @phone_number_parts = phone_number.split('.').map{|p| p.gsub(/[^2-9]/, '')}
  end

  def get_correct_words(phone_chars_array, index)
    matches = []
    phone_chars_array.each do |phone_chars|
      unless phone_chars.empty?
        # Now combine characters and create possible words.
        possible_words = phone_chars.shift.product(*phone_chars).map(&:join)
        possible_words.reject! { |x| x.length < @phone_number_parts[index].length }
        # Match / Intersection of possible words with @dictionary array
        matches << (possible_words & @dictionary)
      end
    end
    return if matches.any?(&:empty?)
    # Making combinations from above output

    if matches.size == 1
      @correct_words[index] = @correct_words[index] ? @correct_words[index] + matches[0] : matches[0]
    elsif matches.size == 2
      @correct_words[index] += matches[0].product(matches[1])
    elsif matches.size == 3
      @correct_words[index] += matches[0].product(matches[1]).product(matches[2]).map(&:flatten)
    end
  end

  def parse_dictionary
    @dictionary = []
    File.foreach(@dic_file || Dir.pwd + '/data/dictionary.txt') do |word|
      @dictionary << word.strip
    end
  end

  def extract_words
    @phone_keys = {}
    @phone_number_parts.each_with_index do |p_part, index|
      length = p_part.length
      i = 0
      @phone_keys[index] = p_part.chars.map { |n| @digit_to_chars[n] }

      while i < length # loop will run till i = 6
        phone_chars1 = @phone_keys[index][0..i]
        phone_chars2 = @phone_keys[index][(i + 1)..(length - 1)]
        get_correct_words([phone_chars1, phone_chars2], index)
        i += 1
      end
    end
  end

  def number_to_words_combinations
    return unless valid_phone_number?

    parse_dictionary
    extract_words
  end

  def process
    number_to_words_combinations
    c_words = @correct_words.values
    combination_words =  if c_words.length == 1
                [c_words[0].join("-")]
              elsif c_words.length == 2
                c_words[0].product(c_words[1]).map(&:flatten).map {|w| w.join("-")}
              elsif c_words.length === 3
                c_words[0].product(c_words[1]).product(c_words[2]).map(&:flatten).map {|w| w.join("-")}
              else
                c_words
              end
    result = []
    combination_words.each do |v|
      special_chars = @phone_number.gsub(/[2-9.]/, '')
      temp_r = v
      special_chars.each_char do |c|
        i = phone_number.index(c)
        temp_r.insert(i, c)
      end
      result << temp_r
    end
    result.join(", ")
  end
end