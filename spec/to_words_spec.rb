# frozen_string_literal: true
require_relative "spec_helper"
RSpec.describe "to_word" do
  context '#to_word' do
    it "converts 1 to `one`" do
      expect(1.to_words).to eq("one")
    end

    it "converts '1' to `one`" do
      expect("1".to_words).to eq("one")
    end

    it "converts '1,000' to `one`" do
      expect(1_000.to_words).to eq("one Thousand")
    end

    it "raises error for non-numerical string '1d'" do
      expect { "1d".to_words }.to raise_error "A whole number is expected"
    end

    it "raises error for non-numerical string 'd1'" do
      expect { "d1".to_words }.to raise_error "A whole number is expected"
    end

    it "it extends Fixnum / Integer methods" do
       # Fixnum before Ruby 2.4, Integer from Ruby 2.4
      expect(1.methods).to include :to_words
    end
  end
end
