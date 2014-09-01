require "spec_helper"
describe 'named_let' do
  context 'symbol only' do
    named_let(:foo) { Object.new }
	it { expect(foo.to_s).to eq "foo" }
	it { expect(foo.inspect).to eq "foo" }
  end

  context 'with label strings' do
    named_let(:foo,"label for display"){ Object.new }
	it { expect(foo.to_s).to eq "label for display" }
	it { expect(foo.inspect).to eq  "label for display" }
  end
end
