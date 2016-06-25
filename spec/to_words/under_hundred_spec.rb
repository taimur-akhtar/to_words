require_relative '../spec_helper'
RSpec.describe 'DIVISIONS' do
  let(:subject) do
    ToWords::UnderHundred::UNDER_HUNDRED
  end

  it { is_expected.to be_a Hash }

  it 'has all keys to be integers' do
    expect(subject.keys.all? { |key| key.is_a? Fixnum }).to be true
  end

  it 'has all values to be strings' do
    expect(subject.values.all? { |value| value.is_a? String }).to be true
  end

  it 'is expected to be frozen' do
    expect(subject.frozen?).to be true
  end
end
