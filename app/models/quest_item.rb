class QuestItem < ActiveRecord::Base
  belongs_to :quest_status
  has_many :picturesofwinners, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :price_presets, dependent: :destroy
  has_many :tickets, dependent: :destroy

  daytypes = Daytype.all
  t0 = Time.new.beginning_of_day.to_s (:db)
  t1 = Time.now.end_of_day.to_s (:db)

  after_create do

    self.price_presets.create ([
                           {daytype_id: daytypes [0].id, t0: t0, t1: t1},
                           {daytype_id: daytypes [1].id, t0: t0, t1: t1}
                       ])

  end

  after_update do
    case self.quest_status.name
      when 'Включен'
        TicketBuilderJob.perform_later self.id
      when 'Выключен'
    end
  end
end