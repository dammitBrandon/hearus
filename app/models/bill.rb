class Bill
  include ActionView::Helpers::NumberHelper
  attr_reader :id

  def initialize(sunlight_id)
    @id = sunlight_id
  end

  def self.choice_type(name)
    define_method(name) { Vote.where("sunlight_id = ? AND choice = ?", @id, name.to_s.titleize) }
    define_method("percent_#{name}") { percent send(name) }
  end

  choice_type :yes
  choice_type :no
  choice_type :no_opinion

  def percent(choice)
    number_to_percentage(choice.count.to_f/self.votes.count * 100, precision: 0)
  end

  def votes
    Vote.where("sunlight_id = ?", @id)
  end
end
