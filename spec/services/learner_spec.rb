require 'rails_helper'

RSpec.describe Learner do
  it "is initialized with a learning rate and training set" do
    training_set = [{i: 800, o: 1000}]
    learning_rate = 0.5
    learner = Learner.new(learning_rate, training_set)

    expect(learner.learning_rate).to eq 0.5
    expect(learner.training_set).to eq([{i: 800, o: 1000}])
  end

  it "returns 0 cost with exactly square root data" do
    training_set = [{i: 0, o: 0}, {i: 1, o: 1}, {i: 4, o: 2}]
    hypothesis = Hypothesis.new(0, 1)
    learner = Learner.new(0, training_set)
    expect(learner.cost(hypothesis)).to  eq 0
  end

  it "returns the same theta0 and theta1 with exactly square root data" do
    training_set = [{i: 0, o: 0}, {i: 1, o: 1}, {i: 4, o: 2}]
    hypothesis = Hypothesis.new(0, 1)
    learner = Learner.new(0.5, training_set)
    expect(learner.decrease_cost(hypothesis)).to eq([0, 1])
  end
end
