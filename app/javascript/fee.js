if (location.pathname.match("items/new")){
window.addEventListener('load', function() {

  const inputPrice = document.getElementById("item-price")
  const addTax = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")


  inputPrice.addEventListener('input', function() {
    let price = this.value;
    let sales_commission = Math.round(price * 0.1);
    addTax.textContent = '';
    addTax.insertAdjacentHTML('beforeend', sales_commission);
  })

  inputPrice.addEventListener('input', function() {
    let price = this.value;
    let sales_commission = Math.round(price * 0.1);
    let profit_price = price - sales_commission;
    profit.textContent = "";
    profit.insertAdjacentHTML('beforeend', profit_price);
  })
})
};
