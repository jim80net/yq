describe Yq do
  subject { described_class }

  let(:query) { 'foo.bar' }

  let (:hash) {
    { "foo" => { "bar" => { "baz" => "value" }}}
  }

  let (:yaml) {<<EOF}
foo:
  bar:
    baz: value
EOF

  describe '.search' do
    subject { described_class.search(query, hash) }

    it { is_expected.to match("baz" => "value") }

    it 'passes it through to JMESPath' do
      expect(JMESPath).to receive(:search).with(query, hash)
      subject
    end
  end

  describe '.yaml_to_hash' do
    subject { described_class.yaml_to_hash(yaml) }
    it { is_expected.to match(hash) }
  end

  describe '.hash_to_yaml' do
    subject { described_class.hash_to_yaml(hash) }
    it { is_expected.to match(yaml) }
  end

  describe '.search_yaml' do
    subject { described_class.search_yaml(query, yaml) }

    it { is_expected.to match("baz: value") }
  end


  describe '.which' do
    subject { described_class.which('jq') }

    before(:each) {
      allow(ENV).to receive(:[]).with('PATH').and_return("/bin:/other/bin")
      allow(File).to receive(:executable?).with("/bin/jq").and_return(false)
      allow(File).to receive(:directory?).with("/bin/jq").and_return(false)
      allow(File).to receive(:directory?).with("/other/bin/jq").and_return(false)
    }

    context 'but it does not exist' do
      before(:each) {
        allow(File).to receive(:executable?).with("/other/bin/jq").and_return(false)
      }
      it  { is_expected.to be_falsey }
    end

    context 'and it does exist' do
      before(:each) {
        allow(File).to receive(:executable?).with("/other/bin/jq").and_return(true)
      }
      it  { is_expected.to eq('/other/bin/jq') }
    end

  end

end
