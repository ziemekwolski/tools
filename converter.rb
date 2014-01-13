# This convert was built to reduce typing on my part. The result is test each value in the hash
# and give correct test error messages in tests, instead of this hash does not match this hash.
#
# assert_equal expected, [{test: "asdf", some_values: [1,2,4]}]
# 
#
# Example: [{test: "asdf", some_values: [1,2,4]}]
# Output:
# [0]["test"], "asdf"
# [0]["some_values"][0], 1
# [0]["some_values"][1], 2
# [0]["some_values"][2], 4
#
# After some quick edits you might end up with something like this:
# 
# assert_equal test[0]["test"], "asdf"
# assert_equal test[0]["some_values"][0], 1
# assert_equal test[0]["some_values"][1], 2
# assert_equal test[0]["some_values"][2], 4

require 'JSON'
require 'pry'

json_response = [{test: "asdf", some_values: [1,2,4]}]

def format_key(key)
  (key.is_a?(Symbol) || key.is_a?(String)) ? "\"#{key}\"" : key
end

def print_format(key, value)
  if value.is_a?(String)
    return "[#{format_key(key)}], #{value.inspect}\n"
  elsif value.is_a?(Hash)
    return print_long(value).collect {|v| "[#{format_key(key)}]#{v}"}
  elsif value.is_a?(Array)
    return print_long(value).collect {|v| "[#{format_key(key)}]#{v}"}
  elsif value.nil?
    return "[#{format_key(key)}], nil\n"
  else
    return "[#{format_key(key)}], #{value}\n"
  end
end

def print_long(obj)
  output = []
  if obj.is_a?(Hash)
    obj.each do |key, value|
      output << print_format(key, value)
    end
  elsif obj.is_a?(Array)
    obj.each_with_index do |value, key|
      output << print_format(key, value)
    end
  end
  output.flatten
end

puts print_long(json_response)

