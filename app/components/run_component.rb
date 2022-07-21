# Manages the live run view
class RunComponent < ViewComponent::Base
  def initialize(run:)
    @run = run
  end

  def title
    if @run.present?
      'You are running'
    else
      'Start whenever you want'
    end
  end
end
