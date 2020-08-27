$(function(){
  // 検索メニューの全画面表示
  $('.hamburger').on('click',function(){
      $('.hamburger-gnav').fadeToggle();
  });
  // ×を押すとメニューを閉じる
  $('.hamburger-close').on('click',function(){
      $('.hamburger-gnav').fadeToggle();
  });
});
