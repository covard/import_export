class Importer
  attr_accessor :start_time

  def initialize
    super
    @start_time = Time.now
  end

  def process
    raise 'Override this in sub class'
  end

  def run_time(end_time)
    Time.diff(@start_time, end_time, '%H %N %S')
  end
end
