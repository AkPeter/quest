class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_ticket
    if current_user
      tickets = Ticket.where('user_id=? and ticket_status_id=?', session[:uid], 2)
      @current_ticket = tickets.any? ? tickets.first : nil
    end
  end
  helper_method :current_ticket

  def selected_ticket
    tickets = Ticket.where('id=? and ticket_status_id=?', session[:tid], 1)
    @selected_ticket = tickets.any? ? tickets.first : nil
  end
  helper_method :selected_ticket

  def current_user
    if session[:uid]&&User.any?
      users = User.where('id=?', session[:uid])
      @current_user = users.any? ? users.first : nil
    end
  end
  helper_method :current_user

  def current_quest
    session[:qid] = QuestItem.first.id unless session[:qid]
    session[:qid]
  end
  helper_method :current_quest

  def time_left
    Time.at((current_ticket.reserve_start_time.to_datetime + RobokassaController::RESERVE_TIME).to_i - DateTime.now.to_i).getutc
  end
  helper_method :time_left

  def tickets_per_day(qid)
    1.day / QuestItem.find(qid).session_length.minutes
  end
  helper_method :tickets_per_day

  def tickets_view_percent(qid)
    (100 / (1.day / QuestItem.find(qid).session_length.minutes).to_f).round 4
  end
  helper_method :tickets_view_percent

  def parse_datetime_params (dt_params)
    (DateTime.parse "#{dt_params.values[0..2].join('-')} #{dt_params.values[-2..-1].join(':')}").to_s(:db)
  end

end
