require "yq/version"
require 'open3'
require 'stringio'
require 'yaml'
require 'json'
require 'timeout'

module Yq
  def self.which(cmd)
    exts = ENV['PATH'] ? ENV['PATH'].split(':') : ['']
    exts.each { |ext|
      exe = File.join(ext, cmd)
      return exe if File.executable?(exe) && !File.directory?(exe)
    }
    return nil
  end

  def self.search_yaml(query, yaml)
    req_json = yaml_to_json(yaml)
    resp_json = search(query, req_json)
    resp_yaml = json_to_yaml(resp_json)
    return resp_yaml
  end

  def self.search(query, json)
    cmd = [which('jq'), query]
    input = json
    output = ""
    LOGGER.debug "sending jq #{cmd}"

    Open3.popen2(*cmd) do |i, o, t|
      begin
        pid = t.pid

        if input
          i.puts input
          i.close
        end

        Timeout.timeout(5) do
          o.each { |v|
            output << v
          }
        end
      rescue Timeout::Error
        LOGGER.warn "Timing out #{t.inspect} after 1 second"
        Process.kill(15, pid)
      ensure
        status = t.value
        raise "JQ failed to exit cleanly" unless status.success?
      end
    end
    return output
  end

  def self.yaml_to_json(yaml)
    a = yaml_to_hash(yaml)
    hash_to_json(a)
  end

  def self.json_to_yaml(json)
    a = json_to_hash(json)
    hash_to_yaml(a)
  end

  def self.yaml_to_hash(yaml)
    YAML.parse(yaml).to_ruby
  end

  def self.hash_to_yaml(hash)
    hash.to_yaml
  end

  def self.json_to_hash(json)
    JSON.parse(json)
  rescue JSON::ParserError
    LOGGER.debug "Non JSON output from jq. Interpreting."
    interpret_non_json_output(json)
  end

  def self.hash_to_json(hash)
    hash.to_json
  end

  def self.interpret_non_json_output(string)
    regex = /(^\{.+?^\}|^\[.+?\]|^".+?")/m
    matches = string.scan(regex)

    without_the_wrapping_array = matches.map(&:first)
    without_the_wrapping_array.map do |line|
      begin
        JSON.parse(line)
      rescue JSON::ParserError
        LOGGER.debug "Assuming #{line} is a string."
        obj = JSON.parse(%Q[{ "value": #{line} }])
        obj["value"]
      end
    end
  end
end
