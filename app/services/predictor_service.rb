class PredictorService
  attr_reader :preparer, :hypothesis, :final_time

  def initialize(item, theta0=rand(-1..1), theta1=rand(-1..1))
    @final_time = (item.end_time - item.created_at)
    @preparer = DataPreparer.new(item)
    @hypothesis = Hypothesis.new(theta0, theta1)
  end

  def get_new_thetas
    data = preparer.format_training_data
    l = Learner.new(0.5, data)
    byebug
    l.decrease_cost(hypothesis)
  end

  def predict_price
    new_hypothesis = Hypothesis.new(get_new_thetas[0], get_new_thetas[1])
    new_hypothesis.function(final_time)
  end
end
