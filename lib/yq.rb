require "yq/version"
require 'yq/ruby_jq'
require 'contracts'
require 'jmespath'
require 'stringio'
require 'yaml'
require 'json'

module Yq
  def self.search_yaml(query, yaml)
    hash = yaml_to_hash(yaml)
    resp_hash = search(query, hash)
    resp_yaml = hash_to_yaml(resp_hash)
    return resp_yaml
  end

  def self.search_json(query, json)
    hash = json_to_hash(json)
    resp_hash = search(query, hash)
    resp_json = hash_to_json(resp_hash)
    return resp_json
  end

  def self.search(query, hash)
    JMESPath.search(query, hash)
  end

  def self.yaml_to_hash(yaml)
    YAML.parse(yaml).to_ruby
  end

  def self.hash_to_yaml(hash)
    hash.to_yaml
  end

  def self.json_to_hash(json)
    JSON.parse(json)
  end

  def self.hash_to_json(hash)
    hash.to_json
  end
end
