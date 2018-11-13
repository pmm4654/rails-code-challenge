$(document).ready(function() {
  $(document).on('click', '.remove_new_line_item', remove_row)
})

function remove_row(e) {
  e.preventDefault();
  $(this).parents('tr.line_item_form').remove()
}