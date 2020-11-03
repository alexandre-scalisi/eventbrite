class UserMailer < ApplicationMailer
  default from: 'alexlemia13@outlook.fr'
   
    def welcome_email(user)
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @user = user 
  
      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'http://monsite.fr/login' 
  
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @user.email, subject: 'Bienvenue chez nous !') 
    end

    def attendance_email(attendance)
      
      @url  = 'http://monsite.fr/login'
      @admin = attendance.user
      @attendance = attendance
      @event = attendance.event
  
  
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @admin.email, subject: 'New attendance !') 
    end
end
