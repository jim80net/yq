require 'jq'
require 'contracts'
require 'json'

module Yq
  class RubyJq
    include ::Contracts

    Contract String, String => Object
    def self.search_json(query, input)
      jq = JQ(input, parse_json: true)

      return jq.search(query)
    end
  end
end
