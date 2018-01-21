$(function () {
  'use strict';
  var $form = $('form.article');

  var $token = $("meta[name='csrf-token']").attr('content');
  var $textarea = $form.find('textarea');
  $textarea.inlineattachment({
    uploadUrl: '/articles/blob',
    uploadMethod: 'POST',
    allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'],
    extraParams: {'authenticity_token': $token},
    urlText: '[image:{filename}]'
  });
});
