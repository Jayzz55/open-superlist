var superlist = {};

superlist.setupDeleteHandlers = function() {

  $(document).ready(function(){

    console.log("doc is ready!");

    $("body").on("click", "[data-delete-button]", function(event) {
      console.log("event click", event, "hi");
      var todoId = $(event.target).attr("data-todo-id");
      var userId = $(event.target).attr("data-user-id");
      var userToken = $(event.target).attr("data-user-token");
      $.ajax({
        type : "DELETE",
        url : "http://localhost:3000/api/users/"+userId+"/todos/"+todoId,
        datatype : "application/json",
        contentType: "application/json; charset=utf-8",
        beforeSend: function (xhr) {
          xhr.setRequestHeader ("Authorization", userToken);
        },
        success : function() {

        },
        error : function(error) {

        }
      });
      $("#todo-"+todoId).fadeOut(600);
    });

  });
  
};
superlist.setupDeleteHandlers();