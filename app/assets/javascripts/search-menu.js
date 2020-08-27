$(function(){
  // 検索メニューの全画面表示
  $('.search-menu').on('click',function(){
      $('.gnav').fadeToggle();
  });
  // ×を押すとメニューを閉じる
  $('.search-close').on('click',function(){
      $('.gnav').fadeToggle();
  });
});
