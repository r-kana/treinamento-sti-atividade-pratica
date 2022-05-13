var QTN = 1;

function createHidden(name, value, classId) {
  return $('<input></input>').attr( 'class', classId).attr('type', 'hidden').attr('name', name).attr('value', value);
}

function createDeleteBtn(qtn, current=true) {
  if (current) {
    const btn = $('<button></button>').addClass('btn-danger delete-btn').text('X').click(function() {
      reorder(qtn);
      this.parentNode.parentNode.remove();
      QTN--;
    });
    return btn;
  }
  else {
    const btn = $('<button></button>').addClass('btn-danger delete-btn').text('X').click(function() {
      reorder(qtn);
      QTN--;
      deleteWaypoint($(`#id-${qtn}`).val());
      this.parentNode.parentNode.remove();
    });
    return btn;
  }
}

function deleteWaypoint(id) {
  console.log(id)
  const authToken = $('[name=authenticity_token').val()
  console.log(authToken)
  $.ajax({
    url: `http://localhost:3000/waypoints/${id}?&authenticity_token=${authToken}`,
    type: 'DELETE',
    success: alert('Parada excluida')
  });
}


function reorder(qtn) {
  if (qtn < QTN) {
    $(`#order-${qtn + 1}`).val(qtn).attr('id', `#order-${qtn}`);
    reorder(qtn + 1);
  }
}

function createStopDiv(qtn) {
  const div = $('<div></div>').addClass('d-flex mb-3 align-items-center').attr('id', `stop-${qtn}`);
  div.append(createDeleteBtn(qtn));
  div.append($('<h5></h5>').addClass('m-0 ms-4')
  .text(`${$('#waypoint_address').val()}, ${$('#waypoint_neighborhood').val()}, ${$('#waypoint_city').val()}`));
  div.append(createHidden(`new_waypoint[${qtn}][address]`, $('#waypoint_address').val()));
  div.append(createHidden(`new_waypoint[${qtn}][neighborhood]`, $('#waypoint_neighborhood').val()));
  div.append(createHidden(`new_waypoint[${qtn}][city]`, $('#waypoint_city').val()));
  div.append(createHidden(`new_waypoint[${qtn}][is_college]`, "false"));
  div.append(createHidden(`new_waypoint[${qtn}][kind]`, 'stop'));
  div.append(createHidden(`new_waypoint[${qtn}][order]`, qtn, 'order'));
  return div;
}

function verifyWaypointsList() {
  $('#waypoints-list').children().each(function(index) {
    if ( !($(this).find('.delete-btn').is('button')) ) {
      $(this).find('div').prepend( createDeleteBtn($(this).find('.order').val(), false) );
    }
  });
}


$(document).ready(function() {
  if ($('#waypoints-list').children().last().find('.order').val())
    QTN = $('#waypoints-list').children().last().find('.order').val();

  verifyWaypointsList();

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