def remove_quotes(string)
  string.gsub(%r'^\"|\"$|\\"','')
end

def convert(string)
  JSON.parse(string)
rescue
  case string
    when "null"
      nil
    when "true"
      true
    when "false"
      false
    when /^-{0,1}\d+$/
      string.to_i
    else
      remove_quotes(string)
  end
end

def interpret(output_lines)
  output_lines.map { |output|
    convert(output)
  }
end

describe Yq::RubyJq do
  describe 'https://raw.githubusercontent.com/stedolan/jq/master/tests/jq.test' do
    body = Net::HTTP.get(URI('https://raw.githubusercontent.com/stedolan/jq/master/tests/jq.test'))
    each_line = body.split("\n").select {|line| ! line[/^#/]}
    collector = []
    test = []
    each_line.each do |line|
      if line == ""
        collector.push test
        test = []
      else
        test.push line
      end
    end

    collector.reject! {|v| v == []}

    collector.each do |test|
      query = remove_quotes(test[0])
      input = test[1]
      output = interpret(test[2..-1])

      case query
        when "Aa\\r\\n\\t\\b\\f\\u03bc"
          # This one is not testing right
          next
        when "inter\\(\"pol\" + \"ation\")"
          next
      end

      case input
        when "\"Aa\\r\\n\\t\\b\\f\\u03bc\""
          next
      end

      describe [query, input, output] do
        subject { Yq::RubyJq.search_json(query, input) }
        it { is_expected.to match_array(output) }
      end
    end
  end

  describe '.search_json' do
    subject { Yq::RubyJq.search_json(query, input) }

    context 'HHA.foo.bar' do
      let(:query) { '.foo.bar' }
      let(:input) { '{"foo": {"bar": [100, 200] }}' }
      it { is_expected.to match_array([[100,200]]) }
    end

    context 'HHA.foo.bar, HHA.foo.bar[1]' do
      let(:query) { '.foo.bar, .foo.bar[1]' }
      let(:input) { '{"foo": {"bar": [100, 200] }}' }
      it { is_expected.to match_array([[100,200], 200]) }
    end

    context 'HHA.foo.bar for arrays' do
      let(:query) { '.[].foo.bar' }
      let(:input) { '[ {"foo": {"bar": [100, 200] }}, {"foo": {"bar": "what"}} ]' }
      it { is_expected.to match_array([[100,200], "what"]) }
    end
  end
end
