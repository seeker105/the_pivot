require 'rails_helper'

RSpec.describe Hypothesis do
  it "takes in theta0 and theta1" do
    hp = Hypothesis.new(1, 2)
    assert_equal 1, hp.theta0
    assert_equal 2, hp.theta1
  end

  it "generates a line" do
    hp = Hypothesis.new(1, 2)
    assert_equal 5, hp.function(4)
  end
end
