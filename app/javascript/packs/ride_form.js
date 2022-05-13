var currentTab = 0;
const colleges = [];

function showTab(n) {
  var tabs = document.getElementsByClassName("tab");
  tabs[n].style.display = "block";
  if (n == 0) {
    document.getElementById("backBtn").style.display = "inline";
    document.getElementById("prevBtn").style.display = "none";
  } else {
    document.getElementById("backBtn").style.display = "none";
    document.getElementById("prevBtn").style.display = "inline";
  }
  if (n == (tabs.length - 1)) {
    document.getElementById("nextBtn").innerHTML = "Salvar";
  } else {
    document.getElementById("nextBtn").innerHTML = "Próximo";
  }
}

function validateForm() {
  var tabs, inputs, i, valid = true;
  tabs = document.getElementsByClassName("tab");
  inputs = tabs[currentTab].getElementsByTagName("input");
  for (i = 0; i < inputs.length; i++) {
    if (inputs[i].value == "") {
      inputs[i].className += " invalid";
      valid = false;
    }
  }
  return valid; 
}

function nextPrev(n) {
  const tabs = document.getElementsByClassName("tab");
  if (n == 1 && !validateForm()) return false;
  tabs[currentTab].style.display = "none";
  currentTab = currentTab + n;
  if (currentTab >= tabs.length) {
    document.getElementById("regForm").submit();
    return false;
  }
  showTab(currentTab);
}

function createSelect(collection = []) {
  const select = $('<select></select>');
  select.attr('name', 'ride[college_id]');
  select.attr('class', 'form-select mb-3');
  select.attr('id', 'college-select')
  select.append($("<option></option>").attr("selected", true).attr("value", null).text('--- Selecionar Campus ---'));
  collection.forEach((e) => select.append($("<option></option>").attr("value", e.id).text(e.text)));
  if ($('#hidden-ride-id').val()) select.val($('#hidden-college-id').val());
  return select;
}

function create_label(id, label) {
  return $('<label></label>').addClass('mb-2 form-label').attr('for', id).text(label);
}

function create_input(name) {
  return $('<input></input>').addClass('form-control mb-3 form-control-sm').attr('type', 'text').attr('name', name).attr('id', name);
}

function appendTextInputs(name) {
  $(`#${name}-input`).append(create_label(`ride[${name}_address]`, 'Endereço'));
  $(`#${name}-input`).append(create_input(`ride[${name}_address]`))
    .val($('#hidden-ride-id').val() ? $(`#hidden-${name}-address`).val() : null);

  $(`#${name}-input`).append(create_label(`ride[${name}_neighborhood]`, 'Bairro'));
  $(`#${name}-input`).append(create_input(`ride[${name}_neighborhood]`))
  .val($('#hidden-ride-id').val() ? $(`#hidden-${name}-address`).val() : null);

  $(`#${name}-input`).append(create_label(`ride[${name}_city]`, 'Cidade'));
  $(`#${name}-input`).append(create_input(`ride[${name}_city]`))
  .val($('#hidden-ride-id').val() ? $(`#hidden-${name}-address`).val() : null);
}

function removeAll(id) {
  const length = $(id).children().length;
  for(let i = 0; i < length; i++){ $(id).children()[0].remove(); }
}

function setValue(element, value) {
  const length = element.length;
  for(let i = 0; i < length; i++) { element[i].value = value; }
}
function resetCheckboxes() {
  if ($('#to_college_destination').is(':checked') && $('#to_college_departure').is(':checked')) {
    if ($('#hidden-to-college-value').value == 0) {
      $('#to_college_destination').prop('checked', false)
      $('#to_college_departure').prop('checked', true)

      removeAll('#departure-input');
      $('#departure-input').append(createSelect(colleges));
    }
    else {
      $('#to_college_departure').prop('checked', false)
      $('#to_college_destination').prop('checked', true)

      removeAll('#destination-input');
      $('#destination-input').append(createSelect(colleges));
    }
  }
}

function fillUpInputs() {
  if ($('#hidden-ride-id').val()) {
    $('#ride_destination_address').val($('#hidden-destination-address').val());
    $('#ride_destination_city').val($('#hidden-destination-city').val());
    
    $('#ride_departure_address').val($('#hidden-departure-address').val());
    $('#ride_departure_city').val($('#hidden-departure-city').val());
  }
}


$(document).ready(function(){ 

  $.get("/colleges.json", function(data, _) {
    for(let i = 0; i < data.length; i++) {
      colleges.push({ text: `${data[i].name}, ${data[i].neighborhood}`, id: data[i].id });
    }
    console.log(colleges);
  });

  showTab(currentTab);
  fillUpInputs();
  resetCheckboxes();

  $('#prevBtn').click(function(){nextPrev(-1);})

  $('#nextBtn').click(function(){
    nextPrev(1);
    if (currentTab == 1) {
      if (!$('#to_college_departure').is(':checked')){
        $('#to_college_destination').prop('checked', true);
        $('#to_college_destination').attr('disabled', true);
        setValue($('div.to-college > input:hidden'), 1);

        removeAll('#destination-input');
        $('#destination-input').append(createSelect(colleges));
      }
    }
  });

  $('#to_college_departure').click(function() {
    if ($('#to_college_departure').is(':checked')) {
      setValue($('div.to-college > input:hidden'), 0);
      if ($('#to_college_destination').is(':checked')) {
        $('#to_college_destination').prop('checked', false);
        setValue($('div.to-college > input:hidden'), 0);

        removeAll('#destination-input');
        appendTextInputs('destination');
      }
      removeAll('#departure-input'); // remove inputs
      $('#departure-input').append(createSelect(colleges));
      $('#to_college_destination').attr('disabled', true);
    } 
    else {
      setValue($('div.to-college > input:hidden'), 1);
      $('#to_college_destination').attr('disabled', false);
      removeAll('#departure-input'); // remove select
      appendTextInputs('departure');
    }
  });

  $('#to_college_destination').click(function() {
    if ($('#to_college_destination').is(':checked')) {
      setValue($('div.to-college > input:hidden'), 1);
      removeAll('#destination-input'); // remove inputs
      $('#destination-input').append(createSelect(colleges));
      $('#to_college_departure').attr('disabled', true);
    } 
    else {
      setValue($('div.to-college > input:hidden'), 0);
      $('#to_college_departure').attr('disabled', false);
      removeAll('#destination-input'); // remove select
      appendTextInputs('destination');
    }
  });

});

