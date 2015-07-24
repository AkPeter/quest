class MainController < ApplicationController


  def index
    require 'russian_holidays_checkup'
    # сексуальное разбитие по дням для последующего потока в вёрстку
    @tickets = {}
    @wrappers = {}
    tickets = Ticket.all.where('quest_item_id = ? and dt >= ?', current_quest, DateTime.now.beginning_of_day.to_s(:db)).order(dt: :asc)
    tickets.each do |ticket|
      ticket_dt = ticket.dt.to_datetime
      day = ticket_dt.redday? ? "#{ticket_dt.strftime('%m%d')}holiday" : "#{ticket_dt.strftime('%m%d')}workday"
      @tickets[day] = [] unless @tickets[day].present?
      @tickets[day] << ticket
      @tickets.rehash # Matz сказал делать rehash в своей книге если используешь динамичные ключи, вот я и делаю .)
    end

    # а тут рассчёты подрисовки цен для вёрстки, wrapper'ы - разница цены, ticket_status_id 1..3 | 4
    ticket_width_percent = tickets_view_percent current_quest

    @tickets.each do |day, ticket_hash|
      brothers_ticket_count = 0
      price = nil
      status = nil

      ticket_hash.each do |ticket|
        @wrappers[day] = [] unless @wrappers[day].present?
=begin
          case ticket.ticket_status_id
            when 4
              if status != 4
                status = 4
                brothers_ticket_count = 0
              end
                brothers_ticket_count += 1
            else

          end


          if status != ticket.ticket_status_id
            status = ticket.ticket_status_id
            if status < 4
              @wrappers[day] << {:price => price, :width => brothers_ticket_count * ticket_width_percent, :disabled_line => true} if brothers_ticket_count > 0
            else
              brothers_ticket_count += 1
            end
          end
=end

        if price != ticket.price
          @wrappers[day] << {:price => price, :width => brothers_ticket_count * ticket_width_percent} if brothers_ticket_count > 0
          price = ticket.price
          brothers_ticket_count = 0
        end
        brothers_ticket_count += 1
      end

      @wrappers[day] << {:price => price, :width => brothers_ticket_count * ticket_width_percent}

    end

    # расписание сеансов в вёрстку! уже не нужно ёптат, вот так вот
    @timetable = []
    start_time = DateTime.now.beginning_of_day
    session_length = QuestItem.find(current_quest).session_length
    1.upto(tickets_per_day current_quest) do
      @timetable << start_time.to_time
      start_time += session_length.minutes
    end

    @picturesofwinners = Picturesofwinner.all

    @responses = Response.all.where('quest_item_id=?', current_quest)

    @tickets_view_percent = tickets_view_percent current_quest

  end
end