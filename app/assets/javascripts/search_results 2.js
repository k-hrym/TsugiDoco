$(function(){
  $('.search-results__place').on('click',function(){
    $('.search-results__place--table').show();
    $(this).css({
        'border-top':'2px solid #4682b4',
        'border-bottom':'none',
        'background-color':'transparent'
    });
    $('.search-results__route--table').hide();
    $('.search-results__route').css({
        "border-top":'none',
        "border-bottom":"1px solid #dee2e6",
        "background-color":'#e3f2fd'
    });
  });
  $('.search-results__route').on('click',function(){
    $('.search-results__place--table').hide();
    $('.search-results__place').css({
        "border-top":'none',
        "border-bottom":"1px solid #dee2e6",
        "background-color":'#e3f2fd'
    });
    $('.search-results__route--table').show();
    $(this).css({
        'border-top':'2px solid #4682b4',
        'border-bottom':'none',
        'background-color':'transparent'
    });
  });
});
