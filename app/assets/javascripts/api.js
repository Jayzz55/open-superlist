var superlist = {};

superlist.setupDeleteHandlers = function() {

  $(document).ready(function(){

    $("body").on("click", "[data-delete-button]", function(event) {
      var todoId = $(event.target).attr("data-todo-id");
      var userId = $(event.target).attr("data-user-id");
      var userToken = $(event.target).attr("data-user-token");
      $.ajax({
        type : "DELETE",
        url : "/api/users/"+userId+"/todos/"+todoId,
        datatype : "application/json",
        contentType: "application/json; charset=utf-8",
        beforeSend: function (xhr) {
          xhr.setRequestHeader ("Authorization", userToken);
        },
        success : function() {
          $("#todo-"+todoId).fadeOut(600);
          alert('Item successfully deleted!'); 
        },
        error : function(error) {

        }
      });
    });

    $('.new-todo').submit(function(event) {
      var userId = $('.btn-success').attr("data-user-id");
      var userToken = $('.btn-success').attr("data-user-token");
      var todoBody = $('#todo_body').val();
      var data = {"todo": {"user_id": userId, "body":todoBody}};
      $.ajax({
        type : "POST",
        url : "/api/users/"+userId+"/todos",
        data: JSON.stringify(data),
        datatype : 'json',
        contentType: "application/json; charset=utf-8",
        beforeSend: function (xhr) {
          xhr.setRequestHeader ("Authorization", userToken);
        },
        success : function(data) {
          $('#todo_body').val("");
          insertRow = '<tbody class="tbody" id="todo-"'+data.id+'><tr><td>'+data.body+'</td><td>7</td><td><input id="todo_"'+data.id+' name="todos[]" value='+data.id+'  type= "checkbox"  /><td><a class="btn btn-danger" data-delete-button="true" data-remote="true" data-todo-id='+data.id+' data-user-id='+userId+' data-user-token='+userToken+' href="#">Delete</a></td><tr/></tbody>';
          $('.js-todos').append(insertRow);
          alert('Item successfully created!');
        },
        error : function(error) {
        }
      });
    });

  });
  
};
superlist.setupDeleteHandlers();