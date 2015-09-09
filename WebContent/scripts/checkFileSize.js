// JavaScript Document

$(document).ready(function() {
   $("#i_file").change(function () 
   { 
     var iSize = ($("#i_file")[0].files[0].size); 
     if (iSize > 1048576 ) 
     {        
		iSize = (Math.round((iSize / 1024)/10) / 100)
		alert("Το αρχείο σου είναι :" + iSize + "Mb!!! Μπορείς να ανεβάσεις μέχρι 1Mb ");
     }  
  }); 
});