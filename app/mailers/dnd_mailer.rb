class DndMailer < ActionMailer::Base
  default from: 'dnd.roles@dnd-role-app-radben13.c9.io'
  
  def welcome_email(player)
    @player = player
    @url = 'http://dnd-role-app-radben13.c9.io/login'
    mail(:to => @player.email, subject: "Welcome to the DnD Role Community!")
  end
end