function leaveDeletion(){

var leaveidfetch=localStorage.getItem("LeaveId");

    $.ajax({
    url: //'http://localhost:64490/api/MOCK/' + leaveidfetch,
    type: 'DELETE',
    // data:DeletingSingleData,
    

    success: function(data) {
        alert("DATA DELETED SUCCESSFULLY");
        
            function leavesDisplay();

    }
  
});



}



function newLeave(){

  var leave=document.getElementById('new-leave-type').value;
  var addleaves=document.getElementById('total-leaves-add').value;
  var maxleaves=document.getElementById('max-leaves-add').value;

  
  var PostingData={
            "LeaveType": leave,
            "TotalLeaves": addleaves,
            "MaxConsecutiveLeaves":maxleaves,
            



  }
    $.ajax({
        type: 'POST',
        url: //'http://localhost:64490/api/MOCK URL',
        data:PostingData,  
            success: function(data) {
        alert("SUCCESSFUL SUBMISSION OF NEW LEAVE TYPE");
       
      }
    });
  }
    
  

    
