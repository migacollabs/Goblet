<!doctype html>

<html>
<head>

	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width"/>

	<link rel="icon" 
	type="image/png" 
	href="" />

	<title>Goblet :: Game Objects</title>

	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link href='/css/materialize/css/materialize.min.css' rel='stylesheet' type='text/css'>

	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script type="text/javascript" src="/css/materialize/js/materialize.min.js"></script>



</head>

<body>


	<nav>
		<div class="nav-wrapper blue-grey lighten-2">
			<a href="/" class="brand-logo"><i class="material-icons left">&nbsplocal_bar</i>Goblet</a>
			<ul id="nav-mobile" class="right"></ul>
		</div>
	</nav>


	<p>&nbsp</p>


	<div class="container">

		<p>&nbsp</p>
	    <h3><i class="material-icons">toll</i> Game Objects</h3>

	    <div class="row">
	        <div class="col s12">
	            <table>
	                <thead>
	                    <th data-field="name">Name</th>
	                    <th data-field="name">Description 1</th>
	                </thead>
	                <tbody>
	                    %for go in game_objects:
	                        %if go.name != 'na' and go.id != 1:
	                        <tr>
	                            <td>${go.name}</td>
	                            <td>${go.description_1}</td>
	                        </tr>
	                        %endif
	                    %endfor
	                </tbody>
	            </table>
	        </div>
	    </div>








		<div class="fixed-action-btn" style="bottom: 45px; right: 24px;">
			<a class="btn-floating btn-large red">
				<i class="large material-icons">add</i>
			</a>
			<ul>
				<li><a class="btn-floating green lighten-1" id="new-game-object-btn"><i class="material-icons">toll</i></a></li>
			</ul>
		</div>

	</div>







<!-- Modal Structure -->
<div id="new-game-object-modal" class="modal modal-fixed-footer">
    <br>
    <div class="container" style="width:90%;">

        <div class="row">
            <h4>New Game Object</h4>
        </div>

        <div class="row">

            <form id="new-game-object-form" method="POST">

                <div class="input-field col s12">
                    ${
                        pymf.add_input(
                            "text", 
                            name_="name", 
                            id_="game-object-name",
                            required=True
                        )
                    }
                    <label id="game-object-name-label" for="session">Name</label>
                </div>

                <div class="input-field col s12">
                    ${
                        pymf.add_input(
                            "text", 
                            name_="description_1", 
                            id_="game-object-description-1",
                            required=True
                        )
                    }
                    <label id="game-object-description-1-label" for="game-object-description-1">Description 1</label>
                </div>

                <!-- <input type="hidden" id="game-id" name="id" value=""/> -->

            </form>
        </div>

    </div>

    <div class="modal-footer">
        <a href="#!" class="modal-action waves-effect waves-green btn-flat accept-new-game-object-btn">Save</a>
        <a href="#!" class="modal-action waves-effect waves-red btn-flat no-thanks-new-game-object-btn">Cancel</a>
    </div>

</div>





</body>

<script type="text/javascript">

	$(document).ready(function(){

		$('select').material_select();


		$("#new-game-object-btn").click(function(event){
			event.preventDefault();
			$(".accept-new-game-object-btn").removeAttr('data-game-id');
			$("#new-game-object-modal").openModal();

		});


		$(".accept-new-game-object-btn").click(function(event){
			event.preventDefault();

			var form = $("form[id=new-game-object-form]");
			var data = form.serializeArray();

			alert(data);

			var action = "PUT";
			var game_id = $(this).attr('data-game-id');
			if(typeof game_id === 'undefined'){
				action = "POST";
			}else{
				data.push({'name':'id', 'value':game_id});
			}

			$.ajax({
				type:action,
				url:"/g/edit",
				data:data,
				success:function(data){
					window.location.reload(false);
				},
				error:function(data){
					alert('Error');
				}
			});

			$("#new-game-object-modal").closeModal();

		});

		$(".no-thanks-new-game-object-btn").click(function(event){
			$("#new-game-object-modal").closeModal();

		});


	});

</script>

</html>


<%namespace name="pymf" file="modelfuncs.mako"/>









