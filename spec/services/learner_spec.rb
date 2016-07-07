require 'rails_helper'

RSpec.describe Learner do
  it "is initialized with a learning rate and training set" do
    training_set = [{i: 800, o: 1000}]
    learning_rate = 0.5
    learner = Learner.new(learning_rate, training_set)

    assert_equal 0.5, learner.learning_rate
    assert_equal [{i: 800, o: 1000}], learner.training_set
  end

  it "returns 0 cost with exactly square root data" do
    training_set = [{i: 0, o: 0}, {i: 1, o: 1}, {i: 4, o: 2}]
    hypothesis = Hypothesis.new(0, 1)
    learner = Learner.new(0, training_set)
    assert_equal 0, learner.cost(hypothesis)
  end

  it "returns the same theta0 and theta1 with exactly square root data" do
    training_set = [{i: 0, o: 0}, {i: 1, o: 1}, {i: 4, o: 2}]
    hypothesis = Hypothesis.new(0, 1)
    learner = Learner.new(0.5, training_set)
    assert_equal [0, 1], learner.decrease_cost(hypothesis)
  end
end
