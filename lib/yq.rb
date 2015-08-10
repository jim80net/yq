require "yq/version"
require 'jmespath'

module Yq
  def self.search(query, yaml)
    JMESPath.search(query, yaml)
  end

end
