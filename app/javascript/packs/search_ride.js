function createInput(name, placeholder) {
  const input = $('<input></input>');
  input.attr('type', 'text');
  input.attr('class', 'form-control');
  input.attr('name', name);
  input.attr('placeholder', placeholder);
  input.attr('id', name);
  return input;
}
function createSelect(collection = []) {
  const select = $('<select></select>');
  select.attr('name', 'ride[neighborhood]');
  select.attr('class', 'form-select');
  select.attr('id', 'college-select')
  select.append($("<option></option>").attr("selected", true).attr("value", null).text('Selecionar Campus '));
  collection.forEach((e) => select.append($("<option></option>").attr("value", e.neighborhood).text(e.text)));
  return select;
}

$(document).ready(function () {
  const colleges = [];

  $.get("/colleges.json", function(data, _) {
    for(let i = 0; i < data.length; i++) {
      colleges.push({
        text: `${data[i].name}, ${data[i].neighborhood}`,
        neighborhood: data[i].neighborhood
      });
    }
  });

  $('#departure_kind').click(function () {
    if ($('#destination_kind').is(':checked') && $('#departure_kind').is(':checked')) {
      $('#destination_kind').prop('checked', false);
    } 

    if ($('#destination').is('input')) {
      $('#destination').attr('disabled', false);
    } 
    else {
      $("#college-select").remove()
      $('#destination-input').append(createInput('destination', 'Destino: '));
    }

    $('#departure').remove();
    $('#departure-input').append(createSelect(colleges));
  });

  $('#destination_kind').click(function () {
    if ($('#departure_kind').is(':checked') && $('#destination_kind').is(':checked')) {
      $('#departure_kind').prop('checked', false);
    } 

    if ($('#destination_kind').is(':checked')) {

      if($('#departure').is('input')) {
        $('#departure').attr('disabled', false);
      } 
      else {
        $("#college-select").remove()
        $('#departure-input').append(createInput('departure', 'Origem: '));
      }

      $('#destination').remove();
      $('#destination-input').append(createSelect(colleges));
    }
  });
})