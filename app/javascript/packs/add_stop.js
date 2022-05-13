var QTN = $('#waypoints-list').childre().length;

function createHidden(name, value, id) {
  return $('<input></input>').attr('type', 'hidden').attr('name', name).attr('value', value).attr('id', id);
}

function createDeleteBtn(qtn) {
  return $('<button></button>').addClass('btn btn-danger').text('X').click(function() {
    reorderStops(qtn)
    this.parentNode.parentNode.remove()
    QTN--;
  });
}
// TODO Melhorar metodo para onclick de botões 
// delete na lista de paradas ja cadastradas

// NOTE Poderia criar a lista de paradas cadastradas
// com uma requisição ajax
function deleteBtnAction(qtn) {
  reorderStops(qtn)
  this.parentNode.parentNode.remove()
  QTN--;
}

function reorderStops(qtn) {
  if (qtn !== QTN) {
    $(`#order-${qtn + 1}`).val(qtn).attr('id', `#order-${qtn}`);
    reorderStops(qtn + 1);
  }
}

function createStopDiv(qtn) {
  const div = $('<div></div>').addClass('d-flex mb-3 align-items-center').attr('id', `stop-${qtn}`);
  div.append(createHidden(`waypoint[${qtn}][address]`, $('#waypoint_address').val()));
  div.append(createHidden(`waypoint[${qtn}][neighborhood]`, $('#waypoint_neighborhood').val()));
  div.append(createHidden(`waypoint[${qtn}][city]`, $('#waypoint_city').val()));
  div.append(createHidden(`waypoint[${qtn}][order]`, qtn, `order-${qtn}`));
  div.append(createHidden(`waypoint[${qtn}][is_college]`, false));
  div.append(createHidden(`waypoint[${qtn}][kind]`, 'stop'));
  div.append(createDeleteBtn(qtn));
  div.append($('<h5></h5>').addClass('m-0 ms-4')
    .text(`${$('#waypoint_address').val()}, ${$('#waypoint_neighborhood').val()}, ${$('#waypoint_city').val()}`));
  return div;
}




$(document).ready(function() {
  $('#add-stop').click(function() {
    if ($('#waypoint_address').val() && $('#waypoint_neighborhood').val() && $('#waypoint_city').val()) {
      const div = createStopDiv(QTN);
      $('#waypoints-list').append($('<li></li>').append(div));
      QTN = QTN + 1;
      $('#waypoint_address').val('').removeClass('is-invalid');
      $('#waypoint_neighborhood').val('').removeClass('is-invalid');
      $('#waypoint_city').val('').removeClass('is-invalid');
    }
    else {
      if (!$('#waypoint_address').val()) $('#waypoint_address').addClass('is-invalid');
      if (!$('#waypoint_neighborhood').val()) $('#waypoint_neighborhood').addClass('is-invalid');
      if (!$('#waypoint_city').val()) $('#waypoint_city').addClass('is-invalid');
    }
  });
});