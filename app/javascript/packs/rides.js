$(document).ready(function () {
  const destination = $("#destination");
  const departure = $("#departure");
  const address_1 = $("#address_1")
  const address_2 = $("#address_2")
  const to_college = $("#to_college")
  
  $("form").submit(function (e) {
    if (to_college.val() === true) {
      destination.val(address_2.val());
      departure.val(address_1.val());
    }
    else {
      destination.val(address_1.val());
      departure.val(address_2.val());
    }
  });
});