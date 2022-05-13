

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
  select.attr('id', 'college-select');
  select.append($("<option></option>").attr("selected", true).attr('value', '0').text('--- Selecionar Campus ---'));
  collection.forEach((e) => select.append($("<option></option>").attr("value", e.neighborhood).text(e.text)));
  select.change(function() {
    if ($("#college-select").is('select') && $("#college-select").val() !== '0')
      $('#commit-btn').attr('disabled', false).attr('class', 'btn btn-outline-success');
    else $('#commit-btn').attr('disabled', true).attr('class', 'btn btn-outline-secondary');
  });
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
    if ($('#destination_kind').is(':checked')) {

      $("#college-select").remove()
      $('#destination-input').append(createInput('destination', 'Destino: '));
      $('#destination_kind').prop('checked', false);

      $('#departure').remove();
      $('#departure-input').append(createSelect(colleges));
      $('#commit-btn').attr('disabled', true).attr('class', 'btn btn-outline-secondary')
    } 
    else if ($('#departure').is('input')) {
      $('#departure').remove();
      $('#departure-input').append(createSelect(colleges)); 
      $('#commit-btn').attr('disabled', true).attr('class', 'btn btn-outline-secondary')
    }
  });

  $('#destination_kind').click(function () {

    if ($('#departure_kind').is(':checked')) {

      $("#college-select").remove()
      $('#departure-input').append(createInput('departure', 'Origem: '));
      $('#departure_kind').prop('checked', false);

      $('#destination').remove();
      $('#destination-input').append(createSelect(colleges));
      $('#commit-btn').attr('disabled', true).attr('class', 'btn btn-outline-secondary')
    }
    else if ($('#destination').is('input')){
      $('#destination').remove();
      $('#destination-input').append(createSelect(colleges));
      $('#commit-btn').attr('disabled', true).attr('class', 'btn btn-outline-secondary')
    }
  });
})