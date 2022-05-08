$(document).ready( () => {
  function autocomplete(inp, arr) {
    /*the autocomplete function takes two arguments,
    the text field element and an array of possible autocompleted values:*/
    var currentFocus;
    /*execute a function when someone writes in the text field:*/
    inp.on('input', () => {
      console.log(this)
      var itemsDiv, itemDiv, i, val = this.value;
      /*close any already open lists of autocompleted values*/
      closeAllLists();
      if (!val) { return false }
      currentFocus = -1;
      /*create a DIV element that will contain the items (values):*/
      itemsDiv = $("<div></div>");
      itemsDiv.attr("id", this.id + "autocomplete-list");
      itemsDiv.addClass("autocomplete-items");
      /*append the DIV element as a child of the autocomplete container:*/
      $(this.id).parent().append(itemsDiv);
      if (this.value.length >= 3) {
      /*for each item in the array...*/
        for (i = 0; i < arr.length; i++) {
          /*check if the item starts with the same letters as the text field value:*/
          if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
            /*create a DIV element for each matching element:*/
            itemDiv = $("<div></div>");
            /*make the matching letters bold:*/
            itemDiv.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
            itemDiv.innerHTML += arr[i].substr(val.length);
            /*insert a input field that will hold the current array item's value:*/
            itemDiv.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
            /*execute a function when someone clicks on the item value (DIV element):*/
            itemDiv.click(() => {
              /*insert the value for the autocomplete text field:*/
              inp.value = this.getElementsByTagName("input")[0].value;
              /*close the list of autocompleted values,
              (or any other open lists of autocompleted values:*/
              closeAllLists();
            });
            itemsDiv.append(itemDiv);
          }
        }
      }
    });
    /*execute a function presses a key on the keyboard:*/
    inp.on("keydown", function(e) {
      let x = $('#' + this.id + 'autocomplete-list');
      if (x) x = x.$("div");
      if (e.keyCode == 40) {
        /*If the arrow DOWN key is pressed,
        increase the currentFocus variable:*/
        currentFocus++;
        /*and and make the current item more visible:*/
        addActive(x);
      } else if (e.keyCode == 38) { //up
        /*If the arrow UP key is pressed,
        decrease the currentFocus variable:*/
        currentFocus--;
        /*and and make the current item more visible:*/
        addActive(x);
      } else if (e.keyCode == 13) {
        /*If the ENTER key is pressed, prevent the form from being submitted,*/
        e.preventDefault();
        if (currentFocus > -1) {
          /*and simulate a click on the "active" item:*/
          if (x) x[currentFocus].click();
        }
      }
    });
    function addActive(x) {
      /*a function to classify an item as "active":*/
      if (!x) return false;
      /*start by removing the "active" class on all items:*/
      removeActive(x);
      if (currentFocus >= x.length) currentFocus = 0;
      if (currentFocus < 0) currentFocus = (x.length - 1);
      /*add class "autocomplete-active":*/
      x[currentFocus].addClass("autocomplete-active");
    }
    function removeActive(x) {
      /*a function to remove the "active" class from all autocomplete items:*/
      for (var i = 0; i < x.length; i++) {
        x[i].removeClass("autocomplete-active");
      }
    }
    function closeAllLists(elmnt) {
      /*close all autocomplete lists in the document,
      except the one passed as an argument:*/
      const items = $(".autocomplete-items");
      for (var i = 0; i < items.length; i++) {
        if (elmnt != items[i] && elmnt != inp) {
          items[i].remove();
        }
      }
    }
    /*execute a function when someone clicks in the document:*/
    $(document).click( (e) => closeAllLists(e.target) );
  }
  
  /*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/
  autocomplete($("#term"), countries);
})