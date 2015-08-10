describe Yq do
  subject { described_class }

  describe '#search' do
    let(:query) { 'foo.bar' }

    let (:yaml) {
      { foo: { bar: { baz: "value" }}}
    }

    it 'passes it through to JMESPath' do
      expect(JMESPath).to receive(:search).with(query, yaml)
      subject.search(query, yaml)
    end

    it 'works' do
      expect(subject.search(query, yaml)).to match(baz: "value")
    end
  end

end
