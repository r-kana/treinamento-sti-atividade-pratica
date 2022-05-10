function createInput(name, placeholder) {
  const input = $('<input></input>');
  input.attr('type', 'text');
  input.attr('class', 'form-control');
  input.attr('name', name);
  input.attr('placeholder', placeholder);
  input.attr('id', name);
  return input;
}
function createSelect(collection) {
  const select = $('<select></select>');
  select.attr('name', 'ride[college_id]');
  select.attr('class', 'form-select');
  select.attr('id', 'ride[college_id]')
  select.append($("<option></option>").attr("selected", true).text('Selecionar Campus '));
  collection.forEach((e) => select.append($("<option></option>").attr("value", e.id).text(e.text)));
  return select;
}

$(document).ready(function () {
  const colleges = [];

  $.get("/colleges.json", function(data, _) {
    for(let i = 0; i < data.length; i++) {
      colleges.push({
        text: `${data[i].name}, ${data[i].neighborhood}`,
        id: data[i].id
      });
    }
  });

  $('#departure_kind').on('input', function () {
    if ($('#destination_kind').is(':checked') && this.is(':checked')) {
      $('#destination_kind').attr('checked', false);
    } 
    // Se o input for verdadeiro
    if (this.is(':checked')) {
      if($('#destination')) {
        $('#destination').attr('disabled', false);
      } else {
        $('#ride[college_id]').remove()
        $('#destination-input').append(createInput('destination', 'Destino: '));
      }
      $('#departure').remove();
      this.parent().append(createSelect(colleges));
    }

  
  });

  $('#destination_kind').on('input', function () {
    if ($('#departure_kind').is(':checked') && this.is(':checked')) {
      $('#departure_kind').attr('checked', false);
    } 
    if (this.is(':checked')) {
      if($('#departure')) {
        $('#departure').attr('disabled', false);
      } else {
        $('#ride[college_id]').remove()
        $('#departure-input').append(createInput('departure', 'Origem: '));
      }
      $('#destination').remove();
      this.parent().append(createSelect(colleges));
    }
  });
})