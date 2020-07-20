$(function(){
  $("#place_postcode").jpostal({
    postcode : [ "#place_postcode" ],
    address  : {"#place_address": "%3%4%5%6%7"}
  });
});
