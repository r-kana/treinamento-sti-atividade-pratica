const users = [];
$.get("/users.json", function(data, _){
  for(let i = 0; i < data.length; i++) {
    users.push(data[i].name);
    users.push(data[i].iduff);
  }
});

$(document).ready( () => {
  const INPUT = $("#q");
  console.log(INPUT);

  // Verifica o foco e adicionar a classe autocomplete-active
  function addActive(elements, focus) { 
    if (!elements) return false;
    removeActive(elements);

    if (focus >= elements.length) focus = 0;
    if (fFocus < 0) focus = (elements.length - 1);
    elements[focus].addClass("autocomplete-active");
  }

  // Remova a classe autocomplete-active
  function removeActive(elements) {
    for (let i = 0; i < elements.length; i++) {
      elements[i].removeClass("autocomplete-active");
    }
  }

  // Remove os elementos da lista com a classe autocomplete-items
  function closeAllLists(element) {
    const items = $(".autocomplete-items");
    for (var i = 0; i < items.length; i++) {
      if (element != items[i] && element != INPUT) {
        items[i].remove();
      }
    }
  }

  function autocomplete(collection) {
    let currentFocus;
    let count = 0;

    INPUT.on('input', function() {
      // this: Input de nome
      let item, val = this.value;
      closeAllLists();
      if (!val) { return false }
      currentFocus = -1;

      const list = $("<ul></ul>");
      list.attr("id", this.id + "-autocomplete-list");
      list.addClass("autocomplete-items dropdown-menu d-inline-block w-25");
      $(this).parent().parent().append(list);
      

      if (this.value.length >= 3) {
        
        for (let i = 0; i < collection.length; i++) {
          console.log("Maior que 3");
          console.log(collection[i].substr(0, val.length).toUpperCase())
          console.log(val.toUpperCase())
          if (collection[i].substr(0, val.length).toUpperCase() == val.toUpperCase() && count < 20) {
            console.log("Match!")
            count ++;
            // Criação de elemento para a lista

            item = $("<li></li>");
            item.addClass('dropdown-item')
            item.html(function () {
              let content = "<strong>" + collection[i].substr(0, val.length) + "</strong>";
              content += collection[i].substr(val.length);
              content += "<input type='hidden' value='" + collection[i] + "'>";
              return content;
            });
            item.click(function() {
              INPUT.val($(this).find('input')[0].value);   
              closeAllLists();
              count = 0;
            });
            list.append(item);
          }
        }
      }
    });

    INPUT.on("keydown", function(e) {
      let list = $(`#${this.id}-autocomplete-list`);
      if (list) list = list.children("div");
      if (e.keyCode == 40) {
        currentFocus++;
        addActive(list, currentFocus);
      } else if (e.keyCode == 38) {
        currentFocus--;
        addActive(list, currentFocus);
      } else if (e.keyCode == 13) {
        e.preventDefault();
        if (currentFocus > -1) {
          if (list) list[currentFocus].click();
        }
      }
    });
    // Fecha a lista se clickar fora
    $(document).click( function(e) {
      closeAllLists(e.target)
      count = 0; 
    });
  }
  console.log(users)

  autocomplete(users);
})