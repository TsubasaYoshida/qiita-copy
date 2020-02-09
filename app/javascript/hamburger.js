$(document).on('turbolinks:load', function(){
  $('.header__hamburger').on('click', function(){
    $(this).toggleClass('open');
    $('.header__menu').toggleClass('open');
    $('.main-container').toggleClass('open');
    $('.footer').toggleClass('open');
    $('.main').toggleClass('open');
  });
});
