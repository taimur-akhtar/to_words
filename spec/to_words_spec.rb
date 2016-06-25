require_relative 'spec_helper'
RSpec.describe 'to_word' do
  context '#to_word' do
    it 'converts 1 to `one`' do
      expect(1.to_words).to eq('one')
    end

    it "converts '1' to `one`" do
      expect('1'.to_words).to eq('one')
    end

    it "raises error for non-numerical string '1d'" do
      expect { '1d'.to_words }.to raise_error 'A number is expected'
    end

    it "raises error for non-numerical string 'd1'" do
      expect { 'd1'.to_words }.to raise_error 'A number is expected'
    end

    it 'it extends Fixnum methods' do
      expect(1.methods).to include :to_words
    end
  end
end
