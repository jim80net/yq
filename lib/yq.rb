require "yq/version"
require 'jmespath'
require 'stringio'
require 'yaml'

module Yq
  def self.search_yaml(query, yaml)
    hash = yaml_to_hash(yaml)
    resp_hash = search(query, hash)
    resp_yaml = hash_to_yaml(resp_hash)
    return resp_yaml
  end

  def self.search(query, hash)
    return hash if query == '.'
    JMESPath.search(query, hash)
  end

  def self.yaml_to_hash(yaml)
    YAML.parse(yaml).to_ruby
  end

  def self.hash_to_yaml(hash)
    hash.to_yaml
  end
end
