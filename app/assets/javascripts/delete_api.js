var superlist = {};

superlist.setupDeleteHandlers = function() {

  $(document).ready(function(){

    $("body").on("click", "[data-delete-button]", function(event) {
      var todoId = $(event.target).attr("data-todo-id");
      var userId = $('meta[name="user_name"]').attr("content").split(' ').join('-').toLowerCase();
      var userToken = $('meta[name="user_auth"]').attr("content");
      if (confirm("Are you sure you want to delete this ?")) {
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
          },
          error : function(error) {
            alert('Error in deleting the item'); 
          }
        });
      };
    });
  });
  
};
superlist.setupDeleteHandlers();