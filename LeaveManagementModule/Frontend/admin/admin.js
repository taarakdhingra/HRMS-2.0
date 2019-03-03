function leavedeletion(){

var leaveidfetch=localStorage.getItem("LeaveId");

    $.ajax({
    url: //'http://localhost:64490/api/MOCK/' + leaveidfetch,
    type: 'DELETE',
    // data:DeletingSingleData,
    

    success: function(data) {
        alert("DATA DELETED SUCCESSFULLY");
        
            function leavesdisplay();

    }
  
});



}
    
