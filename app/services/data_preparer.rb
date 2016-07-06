class DataPreparer

  def initialize(item)
    @_item = item
    @_bids = item.bids
  end

  def inputs
    bids.map do |bid|
      bid.created_at - item.created_at
    end
  end

  def outputs
    bids.map do |bid|
      bid.price
    end
  end

  def format_training_data
    raw_pairs = inputs.zip(outputs)
    raw_pairs.map do |pair|
      {i: pair[0], o: pair[1]}
    end 
  end

private
  def bids
    @_bids
  end

  def item
    @_item
  end

end
