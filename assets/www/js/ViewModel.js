$(function (){											//apply data-bindings when the DOM is ready
	
	$(document).bind('pagechange', function() {			// reset jquery Mobile classes on page navigations
  		$("#viewDetails").trigger('create');
  		$("#shopKart").trigger('create');
	});
	
	var imgPath = "img/";
	my.product = function (selectedItem) {  			// To create Product objects
        var self = this;
        self.name = ko.observable();
        self.price = ko.observable();
        self.img = ko.observable();
        self.category = ko.observable();        
                
        self.imgUrl = ko.computed(function () {
            return imgPath + this.img();
        },self);
    };
    
    my.cartItem = function (){							// To create Product objects
    	var self = this;
    	self.name = ko.observable();
    	self.price = ko.observable();
    	self.units = ko.observable(1);
    	self.imgPath = ko.observable();
    	self.productDetails = ko.observable();
    	self.totalPrice = ko.computed(function(){
    		return self.price() * parseInt("0" + self.units(), 10);
    	});
    };
	
	
	my.viewModel = (function (){ 						//ViewModel - Revealing Module pattern using anonymous closures
	var categories = my.appData.data.categories,	    // Private ViewModel Content
		selectedProduct	= ko.observable(),
		products = ko.observableArray([]),
		cart = ko.observableArray(),
		
    	selectProduct = function(p){
    		selectedProduct(p); 
    		return true;   		
    	},
    	createProducts = function (){
    		$.each(my.appData.data.productList, function (index,p){    			
    			products.push(new my.product(selectedProduct)
    								.name(p.Name)
    								.price(p.Price)
    								.img(p.Img)
    								.category(p.Category));
    		});    		
    	},
    	addToCart = function (p){    		
    		match = ko.utils.arrayFirst(my.viewModel.cart(), function (n) {
    					if (n.name() === p.name()) {    					
         					return true;
    					}
					});
			if (!match) {
    			// This means it wasn't already in our array, so we'll add it.    			
    			cart.push(new my.cartItem().name(p.name()).price(p.price()).imgPath(p.imgUrl).productDetails(p));
			}
    		return true;
    	};
    	removeFromCart = function (p){
    		cart.remove(p);    		
    	},
    	grandTotal = ko.computed(function(){
    		var sum = 0;
    		$.each(cart(), function(){sum=sum+this.totalPrice()});
    		return sum;
    	});
	return{												// Public ViewModel Content (exposing functions and properies)
	        categories:categories,
	        products: products, 
	        selectProduct:selectProduct,
	        selectedProduct:selectedProduct,
	        createProducts: createProducts,
	        cart:cart,
	        addToCart:addToCart,
	        removeFromCart:removeFromCart ,
	        grandTotal:grandTotal	                      
		  }; 
	})();												//Immediate function invocation
	
	my.viewModel.createProducts();
	ko.applyBindings(my.viewModel);
});