class TicketBuilderJob < ActiveJob::Base
  queue_as :tickets_builder

  def perform(id = nil)

    require 'russian_holidays_checkup'

    workday_id = Daytype.all.where(name: "workdays").first.id
    holiday_id = Daytype.all.where(name: "holidays").first.id

    # для квестов с активированым выпуском билетов или для квеста которому сменился выпуск билетов пользователем, прилагается соответствнено его id
    quests = id.present? ? [QuestItem.all.find(id)] : QuestItem.all.where(quest_status_id: 1)

    quests.each do |quest_item|
      session_length = quest_item.session_length.minutes
      end_time = DateTime.now.beginning_of_day + TicketsController::GenerationPeriod - session_length - session_length
      quest_item.tickets.last.nil? ? start_time = DateTime.now.beginning_of_day - session_length : start_time = quest_item.tickets.last.dt.to_datetime

      current_day = start_time.to_date

      while start_time < end_time
        start_time += session_length

        if current_day != (start_time + session_length).to_date
          start_time = start_time.tomorrow.beginning_of_day
          current_day = start_time.to_date
        end

        daytype_id = start_time.redday? ? holiday_id : workday_id
        t = start_time.to_time.to_s(:db)

        preset = PricePreset.all.where('quest_item_id = ? and daytype_id = ? and t0 <= ? and t1 >= ?', quest_item.id, daytype_id, t, t)
        quest_item.tickets.create([{dt: start_time.to_s(:db), daytype_id: daytype_id, price: preset.first.price}])

      end

    end

  end

  after_perform do |job|
    job.enqueue(wait_until: DateTime.now + 1.hour)
  end

end