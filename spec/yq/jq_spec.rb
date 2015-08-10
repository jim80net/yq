describe Yq do
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

    collector.each do |test|
      describe test do
        query =  test[0]
        input = test[1]
        output = test[2,-1]

        subject { Yq.search_json(query, input) }
        it { is_expected.to match(output) }
      end
    end
  end
end
