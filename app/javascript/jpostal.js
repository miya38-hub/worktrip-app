document.addEventListener("turbo:load", function () {

  const postal = document.getElementById("postal_code");
  const address = document.getElementById("address");

  if (!postal || !address) return;

  postal.addEventListener("blur", function () {

    const zipcode = postal.value.replace("-", "");

    if (zipcode.length !== 7) return;

    fetch(`https://zipcloud.ibsnet.co.jp/api/search?zipcode=${zipcode}`)
      .then(res => res.json())
      .then(data => {
        if (data.results) {
          const result = data.results[0];
          address.value =
            result.address1 +
            result.address2 +
            result.address3;
        }
      })
      .catch(err => console.log(err));

  });

});