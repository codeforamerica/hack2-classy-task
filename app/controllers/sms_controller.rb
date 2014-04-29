require 'twilio-ruby'

class SmsController < ApplicationController
  include Webhookable

  after_filter :set_header
  
  skip_before_action :verify_authenticity_token

  def receive

    msg = params['Body'].upcase
    from = params['From']

    case msg
    # Task Number
    when /^\d+$/
      response = handle_task_id msg, from
    
    when 'LIST' 
      response = handle_list

    when 'YES'
      response = handle_yes from

    when 'WHAT'
      response = handle_help

    else
      response = handle_unknown msg
    end


    render_twiml response
  end


  def handle_task_id(msg, from)
    n = Need.find(msg)
    resp_str = "#{n.name} for #{n.event_name}, #{n.start}, with Mr. Tran's CfA class. Reply YES to sign up or LIST for tasks."

    h = History.create :phone => from, :need_id => n.id


    resp resp_str
  end

  def handle_list
  end

  def handle_yes(from)
    thing = "Field trip chaperoning"
    
    history = History.find_by phone: from

    if history
      n = Need.find(history.need_id)
      resp_str =  "Great, we've got you signed up for #{n.name} for #{n.event_name}. We'll send a reminder the day before."
    else
      resp_str = "We're not sure what you're volunteering for. Reply LIST to see tasks."
    end

    resp resp_str
  end

  def handle_help
    resp "Come back later. We aren't here yet."
  end

  def handle_unknown(msg)
    resp "Sorry, don't know what you meant by '#{msg}'."
  end


  def resp(msg)
    response = Twilio::TwiML::Response.new do |r|
      r.Message msg
    end
  end

end