$.fn.tagAutocomplete = function () {
  'use strict'

  function formatTag (tag) {
    return Select2.util.escapeMarkup(tag.name)
  }

  this.select2({
    placeholder: Viauco.translations.tags_placeholder,
    minimumInputLength: 1,
    tokenSeparators: [','],
    multiple: true,
    tags: true,
    initSelection: function (element, callback) {
      var data = $(element.val().split(',')).map(function () {
        return { name: this, id: this }
      })
      callback(data)
    },
    ajax: {
      url: Viauco.routes.tags_api,
      datatype: 'json',
      cache: true,
      data: function (term) {
        return {
          q: term,
          token: Viauco.api_key
        }
      },
      results: function (data) {
        return {
          results: data.tags.map(function (tag) {
            return { name: tag.name, id: tag.name }
          })
        }
      }
    },
    createSearchChoice: function (term, data) {
      if ($(data).filter(function () {
        return this.name.localeCompare(term) === 0
      }).length === 0) {
        return { id: term, name: term }
      }
    },
    formatResult: formatTag,
    formatSelection: formatTag
  })
}

$(document).ready(function () {
  $('.tag_picker').tagAutocomplete()
})
