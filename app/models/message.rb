class Message < ActiveRecord::Base
	belongs_to :person

	validates_presence_of :person

	after_create :broadcast

	private

  def setup_outbound_conns
    @sms = Clickatell::API.authenticate('3205392', 'breakglass', 'rhok2009')
    Twilio.connect('AC22b634ba0e4e36e926222a3ae89a72ea', '82b27d73fa88a8dd599a12172e8c0bd3')
    
    #TODO: Need to make this a full URL instead of a relative one
    @twilio_cb_url = "/twilio?message=#{text}" 
  end

	def broadcast
    setup_outbound_conns

    self.person.family.people.each do |person|
      if !person.sms.nil?
        send_sms person.sms
      end
      
      if !person.phone.nil?
        voice_call person.phone
      end
      
      if !person.email.nil?
        send_email person.email
      end
    end
  end

  def send_sms(cell)
    puts "Sending sms: #{text} to: #{cell}"
    @sms.send_message(cell, text)
  end

  def voice_call(phone)
    puts "Voice calling: #{phone} and telling them: #{text}"
    Twilio::Call.make(@caller_id, phone, @twilio_cb_url)
  end

  def send_email(address)
    puts "Sending email: #{text} to: #{address}"
    #TODO: send emails!
  end
end
