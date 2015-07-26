class PasswordResurrectionKillJob < ActiveJob::Base
  queue_as :password_resurection_killers

  def perform(uid)
    users = User.where('id=?', uid)
    if users.any?
      user = users.first
      user.update(resurrection:nil)
    end
  end

end