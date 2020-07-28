// マイページで投稿、いいねした投稿、行きたいプレイス、行ったプレイスの切り替え
$(function(){
  $('#user__routes').on('click',function(){
    $('#user__routes--content').show();
    $(this).css('border-bottom','2px solid #4682b4');
    $('#user__likes--content').hide();
    $('#user__likes').css('border-bottom','none');
    $('#user__wishes--content').hide();
    $('#user__wishes').css('border-bottom','none');
    $('#user__wents--content').hide();
    $('#user__wents').css('border-bottom','none');
  });
  $('#user__likes').on('click',function(){
    $('#user__routes--content').hide();
    $('#user__routes').css('border-bottom','none');
    $('#user__likes--content').show();
    $(this).css('border-bottom','2px solid #4682b4');
    $('#user__wishes--content').hide();
    $('#user__wishes').css('border-bottom','none');
    $('#user__wents--content').hide();
    $('#user__wents').css('border-bottom','none');
  });
  $('#user__wishes').on('click',function(){
    $('#user__routes--content').hide();
    $('#user__routes').css('border-bottom','none');
    $('#user__likes--content').hide();
    $('#user__likes').css('border-bottom','none');
    $('#user__wishes--content').show();
    $(this).css('border-bottom','2px solid #4682b4');
    $('#user__wents--content').hide();
    $('#user__wents').css('border-bottom','none');
  });
  $('#user__wents').on('click',function(){
    $('#user__routes--content').hide();
    $('#user__routes').css('border-bottom','none');
    $('#user__likes--content').hide();
    $('#user__likes').css('border-bottom','none');
    $('#user__wishes--content').hide();
    $('#user__wishes').css('border-bottom','none');
    $('#user__wents--content').show();
    $(this).css('border-bottom','2px solid #4682b4');
  });
});