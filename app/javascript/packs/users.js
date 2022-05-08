$(document).ready( () => {
  const INPUT = $("#term");
  function addActive(elements, focus) {
    if (!elements) return false;
    removeActive(elements);
    if (focus >= elements.length) focus = 0;
    if (fFocus < 0) focus = (elements.length - 1);
    elements[focus].addClass("autocomplete-active");
  }
  function removeActive(elements) {
    for (let i = 0; i < elements.length; i++) {
      elements[i].removeClass("autocomplete-active");
    }
  }
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
    INPUT.on('input', function() {
      let item, val = this.value;
      closeAllLists();
      if (!val) { return false }
      currentFocus = -1;
      const list = $("<div></div>");
      list.attr("id", this.id + "-autocomplete-list");
      list.addClass("autocomplete-items");
      $(this).parent().append(list);
      if (this.value.length >= 3) {
        for (let i = 0; i < collection.length; i++) {
          if (collection[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
            item = $("<div></div>");
            item.html(function () {
              let content = "<strong>" + collection[i].substr(0, val.length) + "</strong>";
              content += collection[i].substr(val.length);
              content += "<input type='hidden' value='" + collection[i] + "'>";
              return content;
            });
            item.click(function() {
              INPUT.val($(this).find('input')[0].value);   
              closeAllLists();
            });
            list.append(item);
          }
        }
      }
    });
    INPUT.on("keydown", function(e) {
      let list = $('#' + this.id + '-autocomplete-list');
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
    $(document).click( (e) => closeAllLists(e.target) );
  }
  autocomplete();
  })