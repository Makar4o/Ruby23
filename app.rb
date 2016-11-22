#encoding: utf-8
require 'rubygems'
require 'sinatra'


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for"
end

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit
end

post '/visit' do
    @user_name = params[:userName]
    @phone = params[:userPhone]
    @data_time = params[:dataTime]
    @select_barber = params[:selectBarber]
    @color = params[:colorVisitor]

     hh = { :username => 'Enter name',
            :userPhone => 'Enter phone',
            :dataTime => 'Enter data and time'
          }

    @error = hh.select {|key,_| params[key] == ""}.values.join(", ")
    if @error != ''
      return erb :visit
    end
end

 #    f = File.open './public/infoVisitor.txt', 'a'
 #     f.write "
 #             Visitor #{@user_name},
 #             Phone Visitor #{@phone},
 #             Data and time #{@data_time},
 #             Barber: #{@select_barber},
 #             Visitor choose color: #{@color}
 #            "
 #    f.close
 #
 #     erb :visit
 # end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
      @email_visitor = params[:userEmail]
      @message_visitor = params[:messageVisitor]
    f = File.open './public/contacts.txt', 'a'
      f.write"
              Visitor email #{@email_visitor}
              Message Visitor: #{@message_visitor}
             "
      f.close
  erb :contacts
end

