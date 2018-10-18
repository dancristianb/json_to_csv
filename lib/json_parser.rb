require 'net/http'
require 'json'

class JsonParser
  class << JsonParser
    private
    def add_quotation_if_needed(input_string)
      input_string.include?(",") ? "\"#{input_string}\"" : input_string
    end
  
    def get_keys(array)
      array.each_with_index do |element,index|
        if not ((element.is_a? Hash) or (element.is_a? Array))
          @@keys << add_quotation_if_needed(element) if index.even? 
        else
          # the item we just added is followed by hash/array
          # so we need to remove it (like movies:)
          @@keys.pop if index.even?
          get_keys(element.flatten)
        end
      end
    end
  
    def get_values(array)
      array.each_with_index do |element,index|
        if not ((element.is_a? Hash) or (element.is_a? Array))
          @@values << add_quotation_if_needed(element) if index.odd? 
        else
          # no need for the below since all value pairs have a single key
          # @@values.pop if index.even?
          get_values(element.flatten)        
        end
      end
      
      @@values
    end

    def get_keys_and_values(json)
      @@keys = Array.new
      @@values = Array.new
      get_keys(json.flatten)
      get_values(json.flatten)
    end
    
    def keys_and_values_to_csv
      result = String.new
      @@keys = @@keys.uniq
      @@values = @@values.each_slice(@@keys.size).to_a
      
      result << @@keys.join(",") << "\n"
      @@values.each do |row|
        result << row.join(",")
        result << "\n" unless row.equal?(@@values.last)
      end
      
      result
    end

    public
    def get_csv_from_json(json)
      get_keys_and_values(json)
      keys_and_values_to_csv
    end
    
  end
end

class JsonFetcher
  def self.get_json_from_url(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end

# url = 'https://academy-ruby.nyc3.digitaloceanspaces.com/movies.json'
# json = JsonFetcher.get_json_from_url(url)
# csv = JsonParser.get_csv_from_json(json)
# puts csv
