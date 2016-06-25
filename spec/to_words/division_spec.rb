require_relative '../spec_helper'
RSpec.describe 'DIVISIONS' do
  let(:subject) do
    ToWords::Divisions::DIVISIONS
  end

  it { is_expected.to be_a Array }

  it 'has 7 items' do
    expect(subject.length).to eq 7
  end

  it "has '' at index 0" do
    expect(subject[0]).to eq ''
  end

  it 'has Thousand at index 1' do
    expect(subject[1]).to eq 'Thousand'
  end

  it 'has Million at index 2' do
    expect(subject[2]).to eq 'Million'
  end

  it 'has Billion at index 3' do
    expect(subject[3]).to eq 'Billion'
  end

  it 'has Trillion at index 4' do
    expect(subject[4]).to eq 'Trillion'
  end

  it 'has Quadrillion at index 5' do
    expect(subject[5]).to eq 'Quadrillion'
  end

  it 'has Quintrillion at index 6' do
    expect(subject[6]).to eq 'Quintrillion'
  end

  it 'is expected to be frozen' do
    expect(subject.frozen?).to be true
  end
end
