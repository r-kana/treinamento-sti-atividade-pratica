function create_label(id, label) {
  return $('<label></label>').addClass('mb-2 form-label').attr('for', id).text(label);
}

function create_input(name) {
  return $('<input></input>').addClass('form-control form-control-sm').attr('type', 'text').attr('name', name).attr('id', name);
}

function create_hidden(name, value) {
  return $('<input></input>').attr('type', 'hidden').attr('name', name).attr('value', value);
}

function create_input_div(name, label) {
  const div = $('<div></div>').addClass('me-3 mb-3');
  div.append(create_label(name, label));
  div.append(create_input(name));
  return div;
}

$(document).ready(function () {

  var qtn = 1;

  $('#add-stop').click(function() {
    const div = $('<div></div>').addClass('d-flex');

    div.append(create_input_div(`waypoint[address-${qtn}]`, 'Endereço'))
    div.append(create_input_div(`waypoint[neighborhood-${qtn}]`, 'Bairro'))
    div.append(create_input_div(`waypoint[city-${qtn}]`, 'Cidade'))
    
    div.append(create_hidden(`waypoint[order-${qtn}]`, qtn));
    div.append(create_hidden(`waypoint[kind-${qtn}]`, 'stop'));
    div.append(create_hidden(`waypoint[is_college-${qtn}]`, 'false'));
    // TODO Criar botão para excluir parada da lista e reoganizar ordem
    $('#input-list').append(div);
    qtn = qtn + 1;
  });
});