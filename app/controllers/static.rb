get '/' do
	if !session[:user_id].nil? 
  		redirect "/users/#{session[:user_id]}"
  	else
  		erb :"static/index"
  	end
end

get '/home' do 
	erb :"static/logged_in"
end

get '/failure' do 
	erb :"static/failure"
end

post '/signup' do
	user = User.new(username: params[:user_username], email: params[:user_email], password: params[:user_password])
	if user.save
		session[:user_id] = user.id
		{saved: true, id: user.id}.to_json
	else 
		{saved: false}.to_json
	end
end

post '/login' do 
	user = User.find_by(email: params[:user_email])

	if user and user.authenticate(params[:user_password])
		session[:user_id] = user.id
		
		{saved: true, id: user.id}.to_json
	else
		{saved: false}.to_json
	end
end

get '/users/:id' do
	if logged_in? 
		@user = User.find(params[:id])
		if @user.nil? == false  
			erb :"static/users"
		else @user.nil? == true 
			redirect '/'
		end
	
	end
end	

# post '/search' do
# 	if logged_in?
# 		@search = User.find_by(email: params[:user_search])
# 		if !@search.nil?
# 			redirect "/users/#{@search.id}"
# 		elsif @search.nil?
# 			@search = nil
# 			redirect "/users/#{current_user.id}"
# 		end
# 	end
# end

post '/question' do
		
		@question = Question.new(user_id: current_user.id, title: params[:user_title], description: params[:user_description])
		@question.save
		@user = User.find(current_user.id)
		erb :"static/questions"
end

post '/answer' do 
	
	@answer = Answer.new(user_id: current_user.id, question_id: params[:current_question_id], description: params[:user_answer])
	@answer.save 
	@question = Question.find(params[:current_question_id])
	redirect "/questions/#{@question.id}"
end


get '/users/:id/questions' do
	if logged_in?
		@user = User.find(params[:id])
		erb :"static/questions"
	else 
		redirect '/failure'
	end
end

get '/users/:id/answers' do
	if logged_in?
		@user = User.find(params[:id])
		erb :"static/answers"
	else 
		redirect '/failure'
	end
end

get '/questions/:id' do
	if logged_in?
		@question = Question.find(params[:id])
		erb :"static/this_question"
	end
end

get '/question/:id/edit' do
	@question = Question.find_by(id: params[:id])
	erb :"static/editquestion"
end

get '/question/:id/delete' do
	@question = Question.find_by(id: params[:id])
	@question.destroy
	redirect "/users/#{@question.user_id}/questions"
end

get '/answer/:id/edit' do
	@answer = Answer.find(params[:id])
	erb :"static/editanswer"
end

get '/answer/:id/delete' do
	@answer = Answer.find(params[:id])
	@answer.destroy
	redirect "questions/#{@answer.question_id}"
end

post '/question/:id' do 
	@question = Question.find_by(id: params[:id])
	@question.update(title: params[:question_title], description: params[:question_description])
	redirect "/questions/#{@question.id}"
end

post '/answer/:id' do
	@answer = Answer.find(params[:id])
	@answer.update(description: params[:answer_description])
	redirect "/questions/#{@answer.question_id}"
end

post '/vote/:id' do
	@answer = Answer.find(params[:id])
	@vote = Vote.new(user_id: current_user.id, answer_id: params[:id], count: params[:upvote].to_i)
	if @vote.save
		# @message = "You've already liked this"
		{likecount: @answer.votes.count}.to_json
	end 
	# {likecount: @answer.votes.count}.to_json
	# redirect "/questions/#{@answer.question_id}"
end

get '/logout' do 
	sign_out
	if session[:user_id] == nil 
		redirect '/'
	else 
		redirect '/failure'
	end 
end




