class SessionController < ApplicationController
  include TicketsLib

  def signin
    @user = User.find_by_email(params[:email].downcase)
    if @user
      if @user.authenticate(params[:password])
        session[:uid] = @user.id
        if session[:tid]
          case reserveTicket session[:tid]
            when  'root'
              flash.keep
              redirect_to root_url
            else
              flash.keep
              redirect_to payment_url
          end
        else
          flash.keep
          redirect_to personal_page_url
        end
      else
        flash[:notice] = 'неправильный пароль, воспользуйтесь восстановлением пароля'
        render :template => 'users/signin', :locals => {:uid => @user.id}
      end
    else
      redirect_to signin_path, notice: 'такого email нет в системе, зарегистрируйтесь'
    end
  end

  def resurrection
    if params[:resurrection_code].present?
      users = User.where(resurrection: params[:resurrection_code])
      if users.any?
        user = users.first
        password = SecureRandom.hex(8)
        if user.update(password:password, resurrection:nil)
          user.authenticate(password)
          session[:uid] = user.id
          flash[:notice] = 'Ваш пароль сброшен, задайте новый пароль'
          redirect_to personal_page_url
        end
      else
        flash[:notice] = 'вероятно срок действия ссылки истёк, или она уже использована'
        redirect_to root_url
      end
    else
      flash[:notice] = 'нет кода доступа'
      redirect_to root_url
    end

  end

  def logout
    reset_session
    flash[:notice] = 'Заходите ещё !'
    redirect_to root_url
  end

end