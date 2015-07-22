class PricePreset < ActiveRecord::Base
  belongs_to :quest_item
  belongs_to :daytype

  after_update do
    # промежутки во времени заполняются новыми пресетами
    # промежуток до
    preset = PricePreset.where(quest_item_id: self.quest_item_id, daytype_id: self.daytype_id).order(t0: :asc).first
    add_preset preset.t0.at_beginning_of_day, preset.t0 - 1.minute if preset.t0 - preset.t0.at_beginning_of_day > 2.minutes
    # промежуток между
    t1 = nil
    PricePreset.where(quest_item_id: self.quest_item_id, daytype_id: self.daytype_id).order(t0: :asc).each do |preset|
      unless t1.nil?
        add_preset preset.t1 + 1.minute, preset.t0 - 1.minute if preset.t0 - preset.t1 > 2.minutes
      end
      t1 = preset.t1
    end
    # промежуток после
    preset = PricePreset.where(quest_item_id: self.quest_item_id, daytype_id: self.daytype_id).order(t0: :desc).first
    add_preset preset.t1 + 1.minute, preset.t1.at_end_of_day if preset.t1.at_end_of_day - preset.t1 > 2.minutes
  end

  before_destroy do
    # вероятно оператор упоролся и решил грохнуть последний пресет, не надо так .)
    false if PricePreset.where(quest_item_id: self.quest_item_id, daytype_id: self.daytype_id).count == 1
  end

  private

  def add_preset (t0, t1)
    PricePreset.create ([{quest_item_id: self.quest_item_id, daytype_id: self.daytype_id, t0: t0.to_s(:db), t1: t1.to_s(:db)}])
  end

end