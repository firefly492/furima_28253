window.addEventListener('load', function() {

  const inputPrice = document.getElementById("item-price")
  const addTax = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")


  inputPrice.addEventListener('input', function() {
    let price = this.value;
    let sales_commission = price * 0.1;
    addTax.insertAdjacentHTML('beforeend', sales_commission);
    console.log(sales_commission)
  })

  inputPrice.addEventListener('input', function() {
    let price = this.value;
    let sales_commission = price * 0.1;
    let profit_price = price - sales_commission
    profit.insertAdjacentHTML('beforeend', profit_price);
  })
})

