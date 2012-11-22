module IronMotion
  module Helper
    def Helper.hash_to_query_string(hash)
      query_string = ''
      if hash.keys == 0
        return ""
      elsif hash.keys == 1
        hash.each_pair do |k,v|
          query_string << "#{k}=#{v}"
        end
      else
        hash.each_pair do |k,v|
          query_string << "#{k}=#{v}&"
        end
      end

      query_string.chomp!('&')
      query_string.chomp!('.0')
      "?#{query_string}"
    end

  end

end