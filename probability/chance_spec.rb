# Copyright 2014 by Fred George. May be copied with this notice, but not used in classroom training.

require 'rspec'
require_relative 'chance'

# Confirms Chance operates correctly
RSpec.describe Chance do
  IMPOSSIBLE = Chance.new(0)
  UNLIKELY =  Chance.new(0.25)
  EQUALLY_LIKELY = Chance.new(0.5)
  LIKELY = Chance.new(0.75)
  CERTAIN = Chance.new(1)

  it "should understand equality" do
    expect(UNLIKELY).to eq(Chance.new(0.25))
    expect(UNLIKELY).not_to eq(Object.new)
    expect(UNLIKELY).not_to eq(nil)
    expect(UNLIKELY).not_to eq('hello')
  end

  it "should understand 'not'" do
    expect(UNLIKELY).to eq(~LIKELY)
    expect(CERTAIN).to eq(~IMPOSSIBLE)
    expect(IMPOSSIBLE).to eq(~CERTAIN)
    expect(LIKELY).to eq(~~LIKELY)
  end

  it "should understand 'and'" do
    expect(UNLIKELY).to eq(EQUALLY_LIKELY & EQUALLY_LIKELY)
    expect(0.375.chance).to eq(LIKELY & EQUALLY_LIKELY)
  end

  it "should understand 'or'" do
    expect(LIKELY).to eq(EQUALLY_LIKELY | EQUALLY_LIKELY)
    expect(0.875.chance).to eq(LIKELY | EQUALLY_LIKELY)
  end

end
