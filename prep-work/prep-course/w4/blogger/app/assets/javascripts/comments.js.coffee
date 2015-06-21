# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@plusMinus = (id) ->
  element = document.getElementById('comment_button_' + id)
  element.text = if element.text == '+' then '-' else '+'
  return

@collapseViews = (id) ->
  block = document.getElementById('comment_block_' + id)
  buttons = document.getElementById('comment_voter_' + id)
  block.style.height = if block.style.height == "0px" then "" else "0px"
  buttons.style.height = if buttons.style.height == "0px" then "" else "0px"
  return

@handleCollapse = (id) ->
  @plusMinus(id)
  @collapseViews(id)
  return
