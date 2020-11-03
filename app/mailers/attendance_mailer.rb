class AttendanceMailer < ApplicationMailer
  default from: 'alexlemia13@outlook.fr'
  def attendance_email(attendance)
      
    @url  = 'http://monsite.fr/login'
    @admin = attendance.user
    @attendance = attendance
    @event = attendance.event


    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @admin.email, subject: 'New attendance !') 
  end
end
