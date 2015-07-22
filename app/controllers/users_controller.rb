class UsersController < ApplicationController
  include TicketsLib

  def signin
    @user = User.new
    if session[:tid]
      @ticket = selected_ticket
    end
  end
  def create
    password = SecureRandom.hex(8)
    @user = User.new(name: params[:name], email: params[:email], phone: params[:phone], password: password, admin: params[:email]=='shadows.of.unevenness@gmail.com')

    respond_to do |format|
      if @user.save
        session[:uid] = @user.id
        UserMailer.new_bee(@user, password).deliver_now
        if Ticket.any?&&session[:tid]
          case reserveTicket session[:tid]
            when  'root'
              format.html {redirect_to root_url}
            else
              format.html {redirect_to payment_url}
          end
        else
          format.html {redirect_to personal_page_path}
        end
      else
        format.html { render :signin }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      @user = current_user
      if @user.update(name: params['name'], phone: params['phone'], password: params['password'])
        format.html { redirect_to action: 'personal_page' }
        format.json { head :no_content }
      else
        format.html { redirect_to signin_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def password_reset
    new_password = SecureRandom.hex(8)
    @user = User.find(params[:uid])
    if @user.update(password: new_password)
      UserMailer.password_reset(@user, new_password).deliver_now
      redirect_to signin_url
    end
  end
  def personal_page
    if current_user
      @user = current_user
      if current_user.admin
        @tickets = Ticket.where.not(user_id: nil).order(ticket_status_id: :desc, updated_at: :desc)
      else
        @tickets = Ticket.where(user_id: current_user.id)
      end
      render :template => 'users/personal_page', locals: {admin: current_user.admin, tickets_count: @tickets.any?}
    else
      redirect_to root_url
    end
  end
end