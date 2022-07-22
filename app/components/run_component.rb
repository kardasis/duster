# Manages the live run view
class RunComponent < ViewComponent::Base
  def initialize(run:)
    @run = run
  end
end
