var my = {};															//namespace to avoid global reference															
my.appData = (function(){	 											//Model (Revealing Module pattern)
	var data = {
				productList:[
	       			 		{"Name":"Microwave","Price":"10000","Img":"microwave.png","Category":"Electronics"},
	       					{"Name":"Television","Price":"40000","Img":"tv.png","Category":"Electronics"},
	       					{"Name":"Vacuum Cleaner","Price":"20000","Img":"vacuum.png","Category":"Electronics"},	       				
	       					{"Name":"Table","Price":"8000","Img":"table.png","Category":"Furniture"},
	       					{"Name":"Chair","Price":"5000","Img":"chair.png","Category":"Furniture"},
	       					{"Name":"Almirah","Price":"12000","Img":"almirah.png","Category":"Furniture"}	       			
	     	 			    ],
	     	 			   
	     	 	categories : [{"Type" :"Electronics"},{"Type" : "Furniture"}]
	};
	return{
		data : data
	};
})();


