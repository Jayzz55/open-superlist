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
      console.log("test", userId, userToken, todoBody, data);
      $.ajax({
        type : "POST",
        url : "/api/users/"+userId+"/todos",
        data: { "todo": { "user_id": userId, "body": todoBody } },
        datatype : 'json',
        contentType: "application/json; charset=utf-8",
        beforeSend: function (xhr) {
          xhr.setRequestHeader ("Authorization", userToken);
        },
        success : function() {
          alert('Item successfully created!'); 
        },
        error : function(error) {
        }
      });
    });

  });
  
};
superlist.setupDeleteHandlers();