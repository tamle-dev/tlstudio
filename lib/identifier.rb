# Identifier.new.generate
class Identifier
  attr_reader :started_at, 
              :seq_bits, 
              :shard_bits, 
              :seq_shard_bits,
              :period

  def initialize(options = {})
    @started_at = options[:started_at] || Time.new(2021, 1, 1)
    @seq_bits = options[:seq_bits] || 10
    @shard_bits = options[:shard_bits] || 10
    @period = options[:period]
    @seq_shard_bits = seq_bits + shard_bits
  end

  def generate(increase_id, shard_num, created_at = Time.zone.now)
    ((parse_timestamp(created_at, period) - parse_timestamp(started_at, period)) << seq_shard_bits) |
    ((shard_num % (2**shard_bits)) << seq_bits) |
    increase_id % (2**seq_bits)
  end

  def created_at(id)
    duration = created_at_duration(id)
    duration = case period
    when :second
      duration * 1000
    when :minute
      duration * 60 * 1000
    when :hour
      duration * (60*60) * 1000
    when :day
      (duration-1) * (24*60*60) * 1000
    else
      duration
    end

    Time.strptime((parse_timestamp(started_at) + duration).to_s, '%Q')
  end
  
  def shard(id)
    (id >> seq_bits) & ((2 ** shard_bits) - 1).to_i
  end

  def seq(id)   
    id & ((2**seq_bits) - 1).to_i
  end

  private

  def created_at_duration(id)
    a = id >> seq_shard_bits
    b = (2**(64-seq_shard_bits)) - 1
    a & b
  end

  def parse_timestamp(t, in_period = nil)
    case in_period
    when :second
      t.to_i
    when :minute
      t.to_i / 60
    when :hour
      t.to_i / (60*60)
    when :day
      t.to_i / (24*60*60)
    else
      (t.to_f * 1000).to_i
    end
  end
end
