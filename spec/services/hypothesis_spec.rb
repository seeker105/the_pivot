require 'rails_helper'

RSpec.describe Hypothesis do
  it "takes in theta0 and theta1" do
    hp = Hypothesis.new(1, 2)
    expect(hp.theta0).to eq 1
    expect(hp.theta1).to eq 2
  end

  it "generates a line" do
    hp = Hypothesis.new(1, 2)
    expect(hp.function(4)).to eq 5
  end
end
