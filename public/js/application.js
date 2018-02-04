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
				console.log(response)
				// let addLikecount = "<p id=\"plusone\">" + response.likecount + "&nbsp;&nbsp;<img id=\"likeicon\" src=\"/img/like.png\"></p>"
				// $('#plusone-' + response.id).html(response.likecount)
				$form.prev().find('span.plusone').html(response.likecount)
				$formSubmit.replaceWith("<p>You've liked this post!</p>")

				// $("#plusone").html(response.likecount);
				
			},
		});
	});
});

$(document).ready(function(){
	$("#signupform").on("submit", function(event){
		event.preventDefault()
		$form = $(event.target)
		$formSubmit = $form.find('input[id="signupbutton"]')
		$formSubmit.val('Loading...').attr("disabled", true);
		alert("Something wrong :( Please make sure everything entered is LEGIT!");
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