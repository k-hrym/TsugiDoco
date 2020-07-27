// SPOT- の後に続く番号を1から順に振り直す。
function spotOrder(){
  var elements = document.getElementsByClassName('spot__form--order');
  for(let i = 0; i < elements.length; i++){
    elements[i].childNodes[0].textContent = `POST-${i + 1}`;
  };
};

$(document).ready(function(){
  spotOrder();
});