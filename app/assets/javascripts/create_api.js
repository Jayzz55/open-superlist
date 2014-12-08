var superlist = {};

superlist.setupCreateHandlers = function() {

  $(document).ready(function(){

    $("body").on("click", "[data-create-button]", function(event) {
      var userId = $('meta[name="user_name"]').attr("content").split(' ').join('-').toLowerCase();
      var userToken = $('meta[name="user_auth"]').attr("content");
      var todoBody = $('#new_todo_body').val();
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
          $('#new_todo_body').val("");
          insertRow = '<tbody class="tbody" id="todo-'+data.id+'"><tr><td>'+data.body+'</td><td>7</td><td><input id="todo_'+data.id+'" name="todos[]" value='+data.id+'  type= "checkbox"  /><td><a class="btn btn-danger" data-delete-button="true" data-remote="true" data-todo-id='+data.id+' data-user-id='+userId+' data-user-token='+userToken+' href="#">Delete</a></td><tr/></tbody>';
          $('.js-todos').append(insertRow);
        },
        error : function(error) {
          alert('Error in creating the item'); 
        }
      });
    });

  });
  
};
superlist.setupCreateHandlers();