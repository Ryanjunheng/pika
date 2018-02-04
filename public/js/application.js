// likes count and like button update through ajax calls.
$(document).ready(function(){
	$(".upvote").on("submit", function(event){
		event.preventDefault()
		$form = $(event.target)
		$formSubmit = $form.find('input[id="likebutton"]')
		$formSubmit.val('Loading...')
		$.ajax({
			url: $form.attr('action'),
			method: $form.attr('method'),
			data: $form.serialize(),
			dataType: "JSON",
			success: function(response){
				$form.prev().find('span.plusone').html(response.likecount)
				$formSubmit.replaceWith("<p>You've liked this post!</p>")
			},
		});
	});
});

// pop up alert if sign up failure.
$(document).ready(function(){
	$("#signupform").on("submit", function(event){
		event.preventDefault()
		$form = $(event.target)
		$formSubmit = $form.find('input[id="signupbutton"]')
		$formSubmit.val('Loading...').attr("disabled", true);
		$.ajax({
			url: $form.attr('action'),
			method: $form.attr('method'),
			data: $form.serialize(),
			dataType: "JSON",
			success: function(response){
				if (response.saved==false){ 
				alert("Something wrong :( Please make sure everything entered is LEGIT!");
				$formSubmit.val('Sign up').attr("disabled", false);
			} else {
				window.location.replace("https://pikawami.herokuapp.com/users/" + response.id);
			}
			},
		});
	});
});

// pop up alert if login failure.
$(document).ready(function(){
	$("#loginform").on("submit", function(event){
		event.preventDefault()
		$form = $(event.target)
		$formSubmit = $form.find('input[id="loginbutton"]')
		$formSubmit.val('Loading...').attr("disabled", true);
		$.ajax({
			url: $form.attr('action'),
			method: $form.attr('method'),
			data: $form.serialize(),
			dataType: "JSON",
			success: function(response){
				if (response.saved==false){
				alert("Something wrong :( Please make sure everything entered is LEGIT!");
				$formSubmit.val('Log in').attr("disabled", false);
			} else {
				window.location.replace("https://pikawami.herokuapp.com/users/" + response.id);
			}
			},
		});
	});
});