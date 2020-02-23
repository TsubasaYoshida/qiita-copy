$(document).on('turbolinks:load', function(){
  $("p:contains('===')").each(function(){
    var filename = $(this).text().replace(/===/g, '');
    $(this).next().prepend('<span class="filename">' + filename + '</span><div>&nbsp;</div>');
  });
  $("p:contains('===')").remove();
});
