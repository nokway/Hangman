class AcessFile
  attr_accessor :directory

  def initialize(fd_io)
    @directory = IO.new(fd_io)
  end
end
