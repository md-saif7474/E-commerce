function add_to_cart(pid,pname,price)
{
	let cart = localStorage.getItem("cart");	
	
	if(cart==null)
	{
		let products = [];
		let product = {productId:pid, productName:pname, productQuantity:1, productPrice:price}
		products.push(product);
		localStorage.setItem("cart",JSON.stringify(products));
//		console.log("Product is added");
		showToast("Item is added to cart");
	}
	else{
		let pcart = JSON.parse(cart);
		let oldProduct = pcart.find((item) => item.productId==pid)
		
		if(oldProduct)
		{
			oldProduct.productQuantity = oldProduct.productQuantity+1
			pcart.map((item)=>{
				if(item.productId==oldProduct.productId)
				{
					item.productQuantity = oldProduct.productQuantity;
				}
			})
			localStorage.setItem("cart",JSON.stringify(pcart));
//			console.log("Product quantity is increased");
			showToast(oldProduct.productName +"Quantity is increased, Quantity = "+oldProduct.productQuantity);
		}
		else
		{
			let product = {productId:pid, productName:pname, productQuantity:1, productPrice:price}
			pcart.push(product)
			localStorage.setItem("cart",JSON.stringify(pcart));
	//		console.log("Product is added");
			showToast("Product is added");
		}
	}
	
	updateCart();
}


// Update cart

function updateCart()
{
	let cartString = localStorage.getItem("cart");
	let cart = JSON.parse(cartString);
	if(cart==null || cart.length==0)
	{
		console.log("Cart is empty");
		$(".cart-items").html(("0"));
		$(".cart-body").html("<h3>Cart does not have any item</h3>");
		$(".checkout-btn").addClass('disabled');
	}
	else{
		// cart has item
		console.log(cart)
		$(".cart-items").html(`(${cart.length})`);
		let table=`
			<table class='table'>
				<thead class='thead-light'>
					<tr>
					<th>Item Name</th>
					<th>Price</th>
					<th>Quantity</th>
					<th>Total Price</th>
					<th>Action</th>			
					</tr>
				</thead>
		
		
		`;
		
		let totalPrice=0
		cart.map((item)=>{
			
			table += `
				<tr>
					<td>${item.productName}</td>
					<td>${item.productPrice}</td>
					<td>
      				<!-- Minus Button -->
      					<button  onclick="decreaseQuantity(${item.productId})">-</button>
      
      				<!-- Quantity Display -->
      					<span id="quantity-${item.productId}">${item.productQuantity}</span>
      
     				 <!-- Plus Button -->
     					 <button  onclick="increaseQuantity(${item.productId})">+</button>
    				</td>
					<td>${item.productQuantity*item.productPrice}</td>
					<td> <button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>Remove </button> </td>
				
				</tr>
				
				`
				totalPrice += item.productPrice*item.productQuantity;
		})
		
		
		
		table = table + `
		<tr> <td colspan='5' class='text-right font-weight-bold'> Total Price : ${totalPrice} </td> </tr>
		</table>` 
		$(".cart-body").html(table);
		$(".checkout-btn").removeClass('disabled');
	}
}



function deleteItemFromCart(pid)
{
	let cart = JSON.parse(localStorage.getItem('cart'));
	
	let newcart = cart.filter((item)=> item.productId!=pid);
	
	localStorage.setItem('cart',JSON.stringify(newcart));
	updateCart();
	showToast("Item is removed rom the cart");
}


// Increase quantity

function increaseQuantity(pid)
{
	let cart = JSON.parse(localStorage.getItem('cart'));
	cart.map((item)=>{
				if(item.productId==pid)
				{
					item.productQuantity += 1;
				}
			})
	localStorage.setItem('cart',JSON.stringify(cart));
	updateCart();
}

// decrease quantity

function decreaseQuantity(pid)
{
	let cart = JSON.parse(localStorage.getItem('cart'));
	let q = 0;
	cart.map((item)=>{
				if(item.productId==pid)
				{
					q = item.productQuantity;
				}
			})		
	if(q==1)
	{
		let newcart = cart.filter((item)=> item.productId!=pid);
		localStorage.setItem('cart',JSON.stringify(newcart));
	}
	else{
		cart.map((item)=>{
				if(item.productId==pid)
				{
					item.productQuantity -= 1;
				}
			})
		localStorage.setItem('cart',JSON.stringify(cart));
	}
	
	updateCart();
}




$(document).ready(function()
{
  updateCart();
})


function showToast(content)
{
	$("#toast").addClass("display");
	$("#toast").html(content);
	setTimeout(	() =>{
		$("#toast").removeClass("display");
	},2000);
	
}








