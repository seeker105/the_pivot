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

  it "returns nearly correct theta0 and theta1 with exactly square root data and random hypothesis" do
    training_set = [{i: 0, o: 0}, {i: 1, o: 1}, {i: 4, o: 2}]
    hypothesis = Hypothesis.new(rand(-1..1), rand(-1..1))
    learner = Learner.new(2, training_set)
    expect(learner.decrease_cost(hypothesis)).to eq [0, 1]
    #assert qith epsilon
  end

  # it "does something" do
  #   data = [{:i=>5, :o=>1}, {:i=>10, :o=>3}, {:i=>15, :o=>6}]
  #   hypothesis = Hypothesis.new(rand(-1..1), rand(-1..1))
  #   learner = Learner.new(0.05, data)
  #   expect(learner.decrease_cost(hypothesis)).to eq [0, 1]
  # end

end
